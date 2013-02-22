pusher = require "../lib/pusher"

requiresLogin = (req, res, next) ->
  if req.user
    next()
  else
    res.redirect("/auth/google") unless req.user

module.exports = (app) ->
  app.get '/chat', requiresLogin, (req, res) ->
    res.render "chat",
      pusherKey: process.env.PUSHER_APP_KEY

  app.post '/chat/messages', requiresLogin, (req, res) ->
    params = 
      user: req.user.displayName
      message: req.body.message
    pusher.trigger 'subscribe-messages', 'new-message', params, null, (err) ->
      console.log err

