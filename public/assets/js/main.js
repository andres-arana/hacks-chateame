$(document).ready(function() {
  var templates = {
    systemMessage: Handlebars.compile($("#system-message").html()),
    userMessage: Handlebars.compile($("#user-message").html()),
    memberMessage: Handlebars.compile($("#member-mov-message").html()),
  };

  var message = function(message) {
    $("#chat").prepend(message);
  }

  $("#message-form").submit(function(event) {
    event.preventDefault();
    $.post("/chat/messages", $(this).serialize());
    $("#message").val("");
    $("#message").focus();
  });

  var key = $("#pusher-key").val();
  Pusher.channel_auth_endpoint = '/chat/channel';
  var pusher = new Pusher(key);
  var channel = pusher.subscribe('presence-messages');

  channel.bind('new-message', function(data) {
    var me = channel.members.me.id;
    var params = {
      css: data.user == me ? "well" : "alert alert-info",
      user: data.user,
      message: data.message
    };
    message(templates.userMessage(params));
  });

  channel.bind('pusher:subscription_succeeded', function(members) {
    members.each(function(m) {
      message(templates.memberMessage({css: 'success', user: m.id, message: 'joined'}));
    });
  });

  channel.bind('pusher:member_added', function(m) {
    message(templates.memberMessage({css: 'success', user: m.id, message: 'joined'}));
  });

  channel.bind('pusher:member_removed', function(m) {
    message(templates.memberMessage({css: 'error', user: m.id, message: 'left'}));
  });

  message(templates.systemMessage({message: "Welcome to Chatea.me"}));
});
