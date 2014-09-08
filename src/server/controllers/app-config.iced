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

module.exports = (req, res) ->
	result =
		isAuthenticated: req.isAuthenticated()

	await _fetchConfigFromDB defer err, config
	if err
		return res.status(500).send()

	result.title = config.title
	result.description = config.description
	result.teaserImageUrl = config.teaserImageUrl

	res.set "Content-Type", "text/javascript"
	res.send "window.application = JSON.parse('#{JSON.stringify(result)}');"
