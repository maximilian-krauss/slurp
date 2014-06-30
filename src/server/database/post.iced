_					= require "lodash"
mongoose	= require "mongoose"
Schema		= mongoose.Schema

Post = new Schema
	pid: type: String, required: true, unique: true
	title: type: String, required: true

module.exports.model = Post
