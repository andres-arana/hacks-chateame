google = require "passport-google"

strategyParams =
  returnURL: "#{process.env.REALM}/auth/google/return"
  realm: process.env.REALM

module.exports = ->
  new google.Strategy strategyParams, (id, profile, done) ->
    done null, 
      email: profile.emails[0].value

