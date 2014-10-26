path					= require "path"
appRoot				= path.dirname require.main.filename
userCtrl			= require "../controllers/user"
postCtrl			= require "../controllers/post"
streamCtrl		= require "../controllers/stream"
configCtrl		= require "../controllers/app-config"
settingsCtrl	= require "../controllers/settings"
uploadCtrl		= require "../controllers/upload"
eRes					= require "../error-response"
envi 					= require "../environment-helper"
apiBaseRoute	= "/api/0/"

_ensureAuthenticated = (req, res, next) ->
	if(req.isAuthenticated())
		next()
	else
		res.status(401).send message: "Unauthorized"

_ensureAuthenticatedByToken = (req, res, next) ->
	storedToken = envi.server.token
	sentToken = req.get "X-Auth-Token"

	if(storedToken? and storedToken is sentToken)
		return next()

	eRes.send res, 400, "Invalid token dude"

module.exports.apiBaseRoute = apiBaseRoute

module.exports.config = (router, io) ->
	# User routes
	router.route "#{apiBaseRoute}user"
		.get userCtrl.get
		.post _ensureAuthenticatedByToken, userCtrl.post

	router.route "#{apiBaseRoute}user/change-password"
		.post _ensureAuthenticated, userCtrl.changePassword

	# Post routes
	router.route "#{apiBaseRoute}posts/rerender"
		.post _ensureAuthenticated, postCtrl.rerender

	router.route "#{apiBaseRoute}posts/:id"
		.get postCtrl.get
		.delete _ensureAuthenticated, postCtrl.delete

	router.route "#{apiBaseRoute}posts/:id/track-click"
		.post postCtrl.trackClick

	router.route "#{apiBaseRoute}posts"
		.post _ensureAuthenticated, postCtrl.post(io)

	# Stream routes
	router.route "#{apiBaseRoute}stream/:offset"
		.get streamCtrl.get

	# Initial configuration
	router.route "/:buildId/application-config.js"
		.get configCtrl

	# Settings/Application
	router.route "#{apiBaseRoute}settings/application"
		.get _ensureAuthenticated, settingsCtrl.application.get
		.put _ensureAuthenticated, settingsCtrl.application.put

	# Settings/Profile
	router.route "#{apiBaseRoute}settings/profile"
		.get _ensureAuthenticated, settingsCtrl.profile.get
		.put _ensureAuthenticated, settingsCtrl.profile.put

	# Upload
	router.route "#{apiBaseRoute}upload"
		.post _ensureAuthenticated, uploadCtrl.post

	router.route "#{apiBaseRoute}upload/:id"
		.delete _ensureAuthenticated, uploadCtrl.delete

	router.route "#{apiBaseRoute}upload/:id/assign"
		.post _ensureAuthenticated, uploadCtrl.assign

	# Favicon fallback, TODO: Remove if added
	router.route "/favicon.ico"
		.get (req, res) ->
			res.status(404).send()

	# Handle default route and let angular do the work
	router.route "*"
			.get (req, res) ->
				res.sendFile path.join appRoot, "..", "public", "html", "index.html"

	return router
