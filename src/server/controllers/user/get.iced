###
	[GET] User API Controller: Returns the current logged in user
	Content-Type: json
	Auth: cookie
###

module.exports = (req, res) ->
	usr = req.user
	if not usr
		return res.status(400).send "Fuck up"

	res.send usr.getSafeProfile()
