express = require "express"
channel = require "./channel"

module.exports = 
  run: ->
    app = express()
    app.use express.logger()
    app.use express.compress()
    app.use express.bodyParser()
    app.use express.static("public")

    app.get "/", (req, res) ->
      res.redirect "index.html"

    app.post "/messages", (req, res) ->
      channel req.body.user, req.body.message
      res.send 200

    port = process.env.PORT || 3000
    app.listen port
    console.log "Application ready and listening on port #{port}"
