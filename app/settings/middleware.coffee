google = require "../middleware/passport-google"

passport = require "passport"
passport.use google()
passport.serializeUser = (user, done) ->
  done null, user.displayName
passport.deserializeUser = (user, done) ->
  done null, { displayName: user }

module.exports = (app, express) ->
  app.use express.logger()
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser(process.env.COOKIE_KEY)
  app.use express.cookieSession()
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use express.static("public")
