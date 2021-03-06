_					= require "lodash"
mongoose	= require "mongoose"
Schema		= mongoose.Schema
idgen			= require "./id-generator"

Post = new Schema
	uid: 						type: String, unique: true
	title: 					type: String, required: true
	date: 					type: Date, default: Date.now
	content: 				type: String, required: true
	rendered: 			type: String
	type: 					type: String, required: true
	hitCount: 			type: Number, default: 0
	customPayload: 	type: String, default: ""

Post.pre "save", (next) ->
	post = this

	if(not post.uid?)
		post.uid = idgen.compute()

	next()

module.exports.model = Post
