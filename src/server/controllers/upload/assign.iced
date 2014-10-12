###
	[POST] Assign Object to upload controller
	Assigns an object to an upload  which prevents the upload from being deleted
	Auth: Cookie
	RequestBody:
		uploadUid: string
		referenceUid: string
		referenceType: string
###

db		= require "../../database"

module.exports = (req, res) ->
	await db.uploadModel.findOne uid: req.body.uploadUid, defer err, upload
	if err
		return res.status(400).send message: err.message

	if not upload
		return res.status(404).send message: "Upload not found"

	upload.referenceUid = req.body.referenceUid
	upload.referenceType = req.body.referenceType

	await upload.save defer err
	if err
		return res.status(400).send message: err.message

	res.status(200).send()
