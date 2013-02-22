$(document).ready(function() {
  $("#message-form").submit(function(event) {
    event.preventDefault();
    $.post("/messages", $(this).serialize());
    $("#message").val("");
    $("#message").focus();
  });

  var pusher = new Pusher('401c86d9b8adb3a250c4');
  var channel = pusher.subscribe('messages-channel');
  channel.bind('new-message', function(data) {
    var css = data.user == $("#alias").val() ? "" : " alert-error"
    $("#chat").prepend('<div class="alert ' + css + '"><strong>' + data.user + ":</strong> " + data.message + "</div>");
  });
});
