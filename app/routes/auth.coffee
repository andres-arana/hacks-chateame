passport = require "passport"

module.exports = (app) ->
  app.get "/auth/google", passport.authenticate("google")
  app.get "/auth/google/return", passport.authenticate("google", { successRedirect: '/chat', failureRedirect: '/' })
  app.get "/auth/logout", (req, res) ->
    req.logout()
    res.redirect("/")
