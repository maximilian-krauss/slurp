mongoose		= require "mongoose"
Schema 			= mongoose.Schema
idgen				= require "./id-generator"

Upload = new Schema
	uid: type: String, unqiue: true
	date: type: Date, default: Date.now, required: true
	referenceType: type: String
	referenceUid: type: String
	blobPath: type: String, required: true
	blobUri: type: String, required: true
	filename: type: String, required: true


Upload.pre "save", (next) ->
	post = this

	if not post.uid?
		post.uid = idgen.compute()

	next()

module.exports.model = Upload
