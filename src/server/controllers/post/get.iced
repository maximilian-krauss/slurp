###
	[GET] Post API Controller: Returns a single post entity
	Content-Type: json
	Auth: none
###

db 						= require "../../database"
socketEvents	= require "../../socket-events"

module.exports = (io) ->
	(req, res) ->
		await db.postModel.findOne uid: req.params.id, defer err, post
		if err
			return res.status(500).send()

		if not post
			return res.status(404).send()

		conditions = uid: post.uid
		update = $inc: hitCount: 1

		await db.postModel.update conditions, update, defer err

		io.emit socketEvents.post.hitcountIncreased, uid: req.params.id

		res.send post
