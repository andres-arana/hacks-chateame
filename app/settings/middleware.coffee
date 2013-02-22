google = require "../middleware/passport-google"

passport = require "passport"
passport.use google()

module.exports = (app, express) ->
  app.use express.logger()
  app.use express.compress()
  app.use express.bodyParser()
  app.use passport.initialize()
  app.use app.router
  app.use express.static("public")
