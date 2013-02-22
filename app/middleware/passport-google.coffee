google = require "passport-google"

strategyParams =
  returnURL: "#{process.env.REALM}/chat"
  realm: process.env.REALM

module.exports = ->
  new google.Strategy strategyParams, (id, profile, done) ->
    done null, profile
