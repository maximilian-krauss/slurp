db			= require "../../database"

###
	[GET] Stream controller: Returns paginated and rendered posts
	Content-Type: json
	Auth: none
###

module.exports = (req, res) ->
	offset = req.params.offset or 0
	postsPerPage = 10

	await db.postModel
		.find()
		.sort("-date")
		.skip( offset * postsPerPage )
		.limit(postsPerPage)
		.exec defer err, posts

	res.status(200).send posts
