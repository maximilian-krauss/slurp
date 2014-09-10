###
	[DELETE] Post Api Controller - Delets an existing post (kinda obvious...)
	Auth: cookie
###

db		= require "../../database"

module.exports = (req, res) ->
	await db.postModel.remove uid: req.params.id, defer err
	if err
		res.status(500).send()

	res.status(200).send()
