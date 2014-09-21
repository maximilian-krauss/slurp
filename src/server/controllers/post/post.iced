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

	newPost = new db.postModel
		title: post.title
		content: post.content
		rendered: post.renderedContent
		type: post.type
		customPayload: post.customPayload

	await newPost.save defer err
	if err
		return res.status(500).send message: err.message

	return res.status(201).send newPost
