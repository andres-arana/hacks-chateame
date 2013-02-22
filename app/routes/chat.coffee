passport = require "passport"
pusher = require "../lib/pusher"

module.exports = (app) ->
  app.get '/chat', 
    passport.authenticate("google", { session: false}),
    (req, res) ->
      res.render "chat",
        user: req.user.displayName,
        pusherKey: process.env.PUSHER_APP_KEY

  app.post '/chat/messages', (req, res) ->
    params = 
      user: req.body.user
      message: req.body.message
    pusher.trigger 'messages-channel', 'new-message', params, null, (err) ->
      console.log err

