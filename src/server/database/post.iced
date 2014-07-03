_					= require "lodash"
mongoose	= require "mongoose"
Schema		= mongoose.Schema

Post = new Schema
	uid: 				type: String, required: true, unique: true
	title: 			type: String, required: true
	date: 			type: Date, default: Date.now
	content: 		type: String, required: true
	type: 			type: String, required: true

module.exports.model = Post
