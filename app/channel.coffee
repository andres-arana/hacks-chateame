Pusher = require "pusher"
 
pusher = new Pusher(
  appId: process.env.PUSHER_APP_ID,
  key: process.env.PUSHER_APP_KEY,
  secret: process.env.PUSHER_APP_SECRET,
)

module.exports = (user, message) ->
  pusher.trigger 'messages-channel', 'new-message', { user: user, message: message }, null, (err) ->
    console.log err


