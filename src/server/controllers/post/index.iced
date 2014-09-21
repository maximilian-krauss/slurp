###
	Post API Controller
	---
	Handles calls to /api/posts and /api/posts/:id
###

module.exports =
	get: require "./get"
	post: require "./post"
	put: null
	delete: require "./delete"
	trackClick: require "./track-click"
