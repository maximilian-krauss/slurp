path				= require "path"
appRoot			= path.dirname require.main.filename
userCtrl		= require "../controllers/user"

_ensureAuthenticated = (req, res, next) ->
	if(req.isAuthenticated())
		next()
	else
		res.send 401, "Unauthorized"

module.exports.config = (router) ->

	router.route "/api/user"
		.post userCtrl.post

	# Handle default route and let angular do the work
	router.route "*"
			.get (req, res) ->
				res.sendfile path.join appRoot, "..", "public", "html", "index.html"

	return router
