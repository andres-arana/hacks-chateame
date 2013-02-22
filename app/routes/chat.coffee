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

  app.post '/chat/channel', (req, res) ->
    response = pusher.auth req.body.socket_id, req.body.channel_name, 
      user_id: req.user.email
    res.json response

  app.post '/chat/messages', requiresLogin, (req, res) ->
    params = 
      user: req.user.email
      message: req.body.message
    pusher.trigger 'presence-messages', 'new-message', params, null, (err) ->
      console.log err

