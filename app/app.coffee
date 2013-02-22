express = require "express"

module.exports = 
  run: ->
    app = express()

    require("./settings/params")(app)
    require("./settings/middleware")(app, express)

    require("./routes/home")(app)
    require("./routes/chat")(app)

    app.listen process.env.PORT
    console.log "Application ready and listening on port #{process.env.PORT}"
