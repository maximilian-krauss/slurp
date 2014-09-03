class Inspector
	constructor: (@post, @match) ->

	matches: ->
		@match.test @post.content

	render: (cb) ->

module.exports = Inspector
