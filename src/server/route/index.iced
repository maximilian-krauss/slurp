path					= require "path"
appRoot				= path.dirname require.main.filename
userCtrl			= require "../controllers/user"
postCtrl			= require "../controllers/post"
eRes					= require "../error-response"
envi 					= require "../environment-helper"
apiBaseRoute	= "/api/0/"

_ensureAuthenticated = (req, res, next) ->
	if(req.isAuthenticated())
		next()
	else
		res.send 401, "Unauthorized"

_ensureAuthenticatedByToken = (req, res, next) ->
	storedToken = envi.server.token
	sentToken = req.get "X-Auth-Token"

	if(storedToken? and storedToken is sentToken)
		return next()

	eRes.send res, 400, "Invalid token dude"

module.exports.apiBaseRoute = apiBaseRoute

module.exports.config = (router) ->
	# User routes
	router.route "#{apiBaseRoute}user"
		.get _ensureAuthenticated, userCtrl.get
		.post _ensureAuthenticatedByToken, userCtrl.post

	# Post routes
	router.route "#{apiBaseRoute}posts/:id"
		.get postCtrl.get

	router.route "#{apiBaseRoute}posts"
		.post postCtrl.post

	# Favicon fallback, TODO: Remove if added
	router.route "/favicon.ico"
		.get (req, res) ->
			res.status(404).send()

	# Handle default route and let angular do the work
	router.route "*"
			.get (req, res) ->
				res.sendFile path.join appRoot, "..", "public", "html", "index.html"

	return router
