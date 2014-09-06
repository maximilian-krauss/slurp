Inspector 		= require "./inspector"
request				= require "request"

scResolveUri 	= "https://api.soundcloud.com/resolve.json"
scClientId 		= "898571bb5b53506de80e2de9b217ca45"

class Soundcloud extends Inspector
	constructor: (@post) ->
		super @post, /^https?:\/\/(www.|)soundcloud.com\/([^\?&\"\'>]+)$/

	_resolveSoundCloudUrl: (cb) ->
		await request.get scResolveUri,
			qs:
				client_id: scClientId
				url: @post.content
			json: true
		, defer err, res, body

		if err
			return cb err

		if body.errors
			return cb new Error body.errors[0].error_message

		cb null, body

	render: (done) ->
		await @_resolveSoundCloudUrl defer err, scBody
		if err
			return done err

		if not @post.title
			@post.title = scBody.title

		@post.renderedContent = "<div class=\"soundcloud-container\"><iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/#{scBody.id}&amp;color=ff5500&amp;auto_play=false&amp;hide_related=true&amp;show_comments=false&amp;show_user=false&amp;show_reposts=false\"></iframe>"
		@post.type = "soundcloud"
		super done

module.exports = Soundcloud
