# Chateame

Simple realtime chat room experiment using [node](http://nodejs.org/) and
[pusher](http://pusher.com/).

# Configuration

You'll need to set the following environment variables to host this application
somewhere:

* **PORT**: Port on which the http server will listen for inbound connections

* **REALM**: Root url to the application. For example, `http://localhost:3000`.

* **PUSHER_APP_ID**: Your pusher app id

* **PUSHER_APP_KEY**: Your pusher app key

* **PUSHER_APP_SECRET**: Your pusher app secret

To self-host your application on your development environment, you will still
need to define those environment variables through exporting them into your
local session. You can create a script at `scripts/localenv.{sh,bash,bat}` to
configure your local session with those variables, as it is ignored from the
repo.
