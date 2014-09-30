###
	Settings - API Controller
###

app			= require "./application"
profile	= require "./profile"

module.exports =
	application:
		get: app.get
		put: app.put
	profile:
		get: profile.get
		put: profile.put
