###
	Settings/Profile API Controller
	Handles get and put methods to retrieve and update the user profile
	Auth: Cookie
###

db		= require "../../database"

module.exports.get = (req, res) ->
	await db.userModel.findOne isActive: true, defer err, user
	if err
		return res.status(500).send message: err.message

	if not user
		return res.status(404).send()

	res.send user.getSafeProfile()

module.exports.put = (req, res) ->
	await db.userModel.findOne uid: req.body.id, defer err, user
	if err
		return res.status(500).send message: err.message

	if not user
		return res.status(404).send()

	user.firstName = req.body.firstName
	user.lastName = req.body.lastName
	user.profileImageUrl = req.body.profileImageUrl
	user.slug = req.body.slug

	await user.save defer err
	if err
		return res.status(500).send message: err.message

	res.status(204).send()
