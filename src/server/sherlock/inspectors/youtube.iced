_					= require "lodash"
Inspector	= require "./inspector"

class Youtube extends Inspector
	constructor: (@post) ->
		super @post, /^https?:\/\/(www.|)(youtu.be\/|youtube.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&\"\'>]+)$/

	render: (done) ->
		videoId = _(@match.exec(@post.content)).last()
		if not videoId?
			return done new Error "Could not find video id"

		@post.renderedContent = "<div class=\"video-container\"><iframe width=\"560\" height=\"315\" src=\"//www.youtube.com/embed/#{videoId}?rel=0\" frameborder=\"0\" allowfullscreen></iframe></div>"
		@post.type = "youtube"
		super done

module.exports = Youtube
