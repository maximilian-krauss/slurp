###
	[POST] Post-Api-Controller: Tracks clicks of an post
	Content-Type: json
	Auth: none
###

db		= require "../../database"

module.exports = (req, res) ->
	conditions = uid: req.params.id
	update = $inc: hitCount: 1

	await db.postModel.update conditions, update, defer err
	if err
		return res.status(500).send()

	res.status(200).send()
