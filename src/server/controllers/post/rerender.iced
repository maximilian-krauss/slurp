###
	[POST] Provides a method to rerender all or some posts
	Auth: cookie
	RequestBody:
		postUids: [ string ]
###

db					= require "../../database"
sherlock		= require "../../sherlock"


_rerenderPost = (post, cb) ->
	body =
		content: post.content
		title: if post.type is "link" then post.customPayload else post.title

	await sherlock.render body, defer err, renderedPost
	post.title = renderedPost.title
	post.rendered = renderedPost.renderedContent
	post.type = renderedPost.type
	post.customPayload = renderedPost.customPayload

	await post.save defer err
	cb err, post

_findPosts = (uids, cb) ->
	if uids.length is 0
		await db.postModel.find defer err, posts
		return cb err, posts
	else
		posts = []
		for uid in uids
			await db.postModel.findOne uid: uid, defer err, post
			if err
				return cb err

			posts.push post

		cb null, posts

module.exports = (req, res) ->
	await _findPosts req.body.postUids, defer err, posts
	if err
		return res.status(400).send message: err.message

	rerenderedPosts = []
	for post in posts
		await _rerenderPost post, defer err, renderedPost
		if err
			return res.status(400).send message: err.message

		rerenderedPosts.push renderedPost

	res.send rerenderedPosts
