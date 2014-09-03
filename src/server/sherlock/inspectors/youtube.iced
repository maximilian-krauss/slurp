Inspector = require "./inspector"

class Youtube extends Inspector
	constructor: (@post) ->
		super @post, /^https?:\/\/(www.|)(youtu.be\/|youtube.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&\"\'>]+)$/


module.exports = Youtube
