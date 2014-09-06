###
	Returns an config object with initial values used to bootstrap the
	web app
###

db		= require "../database"

module.exports = (req, res) ->
	result =
		isAuthenticated: req.isAuthenticated()

	res.set "Content-Type", "text/javascript"
	res.send "window.application = JSON.parse('#{JSON.stringify(result)}');"
