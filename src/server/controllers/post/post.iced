###
	[POST] Post API Controller: Creates a new post
	Content-Type: json
	Auth: cookie
	---
	Request body:
		title: string
		content: string
###

sherlock		= require "../../sherlock"
db					= require "../../database"

module.exports = (req, res) ->
	await sherlock.render req.body, defer err, post
	res.status(400).send()
