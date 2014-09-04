class Inspector
	constructor: (@post, @match) ->

	matches: ->
		@match.test @post.content

	render: (done) ->
		done null, @post

module.exports = Inspector
