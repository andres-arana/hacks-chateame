$(document).ready(function() {
  var templates = {
    systemMessage: Handlebars.compile($("#system-message").html()),
    userMessage: Handlebars.compile($("#user-message").html()),
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
  var pusher = new Pusher(key);
  var channel = pusher.subscribe('subscribe-messages');
  channel.bind('new-message', function(data) {
    var params = {
      css: data.user == $("#alias").val() ? "success" : "info",
      user: data.user,
      message: data.message
    };
    message(templates.userMessage(params));
  });

  message(templates.systemMessage({message: "Welcome to Chatea.me"}));
});
