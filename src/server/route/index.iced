path				= require "path"
appRoot			= path.dirname require.main.filename
userCtrl		= require "../controllers/user"
eRes				= require "../error-response"
envi 				= require "../environment-helper"

_ensureAuthenticated = (req, res, next) ->
	if(req.isAuthenticated())
		next()
	else
		res.send 401, "Unauthorized"

_ensureAuthenticatedByToken = (req, res, next) ->
	storedToken = envi.server.token
	sentToken = req.get("X-Auth-Token")

	if(storedToken? and storedToken is sentToken)
		return next()

	eRes.send res, 400, "Invalid token dude"

module.exports.config = (router) ->

	router.route "/api/user"
		.post _ensureAuthenticatedByToken, userCtrl.post

	# Handle default route and let angular do the work
	router.route "*"
			.get (req, res) ->
				res.sendfile path.join appRoot, "..", "public", "html", "index.html"

	return router
