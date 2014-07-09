_					= require "lodash"
mongoose	= require "mongoose"
Schema		= mongoose.Schema
idgen			= require "./id-generator"

Post = new Schema
	uid: 				type: String, required: true, unique: true
	title: 			type: String, required: true
	date: 			type: Date, default: Date.now
	content: 		type: String, required: true
	type: 			type: String, required: true

Post.pre "save", (next) ->
	post = this

	if(not post.uid?)
		post.uid = idgen.compute()

	next()

module.exports.model = Post
