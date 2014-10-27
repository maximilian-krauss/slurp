###
	[POST] Post-Api-Controller: Tracks clicks of an post
	Content-Type: json
	Auth: none
###

db						= require "../../database"
socketEvents	= require "../../socket-events"

module.exports = (io) ->
	return (req, res) ->
		conditions = uid: req.params.id
		update = $inc: hitCount: 1

		await db.postModel.update conditions, update, defer err
		if err
			return res.status(500).send()

		io.emit socketEvents.post.hitcountIncreased, uid: req.params.id

		res.status(200).send()
