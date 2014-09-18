###
	Returns an config object with initial values used to bootstrap the
	web app
###

db		= require "../database"

_fetchConfigFromDB = (cb) ->
	await db.applicationModel.findOne defer err, config
	if err
		return cb err

	if not config
		config = new db.applicationModel
		await config.save defer err
		return cb err, config

	return cb null, config

_fetchUserFromSessionOrDB = (req, cb) ->
	if req.user?
		return cb null, req.user.getSafeProfile()

	await db.userModel.findOne isActive: true, defer err, user
	cb err, user?.getSafeProfile()

module.exports = (req, res) ->
	result =
		isAuthenticated: req.isAuthenticated()

	await _fetchConfigFromDB defer err, config
	if err
		return res.status(500).send()

	await _fetchUserFromSessionOrDB req, defer err, user
	if err
		return res.status(500).send()

	result.title = config.title
	result.description = config.description
	result.teaserImageUrl = config.teaserImageUrl
	result.user = user

	res.set "Content-Type", "text/javascript"
	res.send "window.application = JSON.parse('#{JSON.stringify(result)}');"
