###
	[GET] User API Controller: Returns the current logged in user
	Content-Type: json
	Auth: cookie
###

db		= require "../../database"

module.exports = (req, res) ->
	usr = req.user
	if usr?
		return res.send usr.getSafeProfile()

	await db.userModel.findOne isActive: true, defer err, user
	if err
		return res.status(500).send message: err.message

	if not user
		return res.status(404).send()

	res.send user.getSafeProfile()
