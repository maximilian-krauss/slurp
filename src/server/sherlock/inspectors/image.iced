Inspector			= require "./inspector"

class Image extends Inspector
	constructor: (@post) ->
		super @post, /^^https?:\/\/(www.|)(.*).(png|gif|jpg|jpeg)$/i

	render: (done) ->
		@post.renderedContent = "<div class=\"image-container\"><img src=\"#{@post.content}\" alt=\"#{@post.title}\" /></div>"
		@post.type = "image"
		super done


module.exports = Image
