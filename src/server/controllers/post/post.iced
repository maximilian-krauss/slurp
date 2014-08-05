###
	[POST] Post API Controller: Creates a new post
	Content-Type: json
	Auth: cookie
	---
	Request body:
		title: string
		type: number, null
		description: string
		content: string
###

module.exports = (req, res) ->

	res.send 400
