###
	Settings/Application
	Handles get and put methods to update application specific settings
	Auth: cookie
###

db		= require "../../database"

module.exports.get = (req, res) ->
	await db.applicationModel.findOne defer err, model
	if err
		return res.status(404).send()

	return res.send model

module.exports.put = (req, res) ->
	await db.applicationModel.findOne defer err, model
	if err
		return res.status(500).send()

	model.title = req.body.title
	model.description = req.body.description
	model.teaserImageUrl = req.body.teaserImageUrl

	await model.save defer err
	if err
		return res.status(500).send()

	res.status(204).send()
