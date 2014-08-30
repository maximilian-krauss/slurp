db			= require "../../database"

###
	[GET] Stream controller: Returns paginated and rendered posts
	Content-Type: json
	Auth: none
###

module.exports = (req, res) ->
	res.status(400).send()
