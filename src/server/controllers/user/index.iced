###
	User API Controller
	---
	Handles calls to /api/user
###

module.exports =
	get: require "./get"
	post: require "./post"
	put: null
	changePassword: require "./change-password"
