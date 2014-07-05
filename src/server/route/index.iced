path				= require "path"
appRoot			= path.dirname require.main.filename

module.exports.config = (router) ->

	# TODO: Add api and other routing

	# Handle default route and let angular do the work
	router.route "*"
			.get (req, res) ->
				res.sendfile path.join appRoot, "..", "public", "html", "index.html"

	return router
