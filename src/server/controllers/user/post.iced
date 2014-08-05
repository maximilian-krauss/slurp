envi 				= require "../../environment-helper"
db					= require "../../database"
eRes				= require "../../error-response"

###
	[POST] User API Controller: Creates a new user
	Content-Type: json
	Auth: token
	---
	Request Body:
		username: string
		password: string
		email: string
###

module.exports = (req, res) ->
	user = new db.userModel
		username: req.body.username
		password: req.body.password
		email: req.body.email

	await user.save defer err
	if(err)
		return eRes.send res, 500, err.message

	res.send 201

	eRes.send res, 400
