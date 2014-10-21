###
	Changes the password of the currently logged in user
	Auth: cookie
	Request-Body:
		currentPassword: string
		newPassword: string
		confirmation: string
###

module.exports = (req, res) ->
	usr = req.user

	await usr.comparePassword req.body.currentPassword, defer err, match
	if err or not match
		return res.status(400).send message: "The old password did not match"

	if req.body.newPassword isnt req.body.confirmation
		return res.status(400).send message: "The new passwords did not match"

	usr.password = req.body.newPassword
	await usr.save defer err
	if err
		return res.status(500).send message err.message

	res.status(200).send()
