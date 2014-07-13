_						= require "lodash"
mongoose		= require "mongoose"
Schema			= mongoose.Schema
saltFactor	= 10
bcrypt 			= require "bcrypt"
idgen			  = require "./id-generator"

User = new Schema
	uid:  				type: String, unique: true
	username: 		type: String, required: true, unique: true
	email: 				type: String, required: true, unique: true
	password: 		type: String, required: true
	firstName: 		type: String, default: ''
	lastName: 		type: String, default: ''
	createdAt: 		type: Date, default: Date.now
	updatedAt: 		type: Date, default: Date.now
	isActive: 		type: Boolean, default: false

User.pre "save", (next) ->
	user = this

	if(not user.uid?)
		user.uid = idgen.compute()

	if(not user.isModified("password"))
    return next()

  await bcrypt.genSalt saltFactor, defer err, salt
  if(err)
    return next err

  await bcrypt.hash user.password, salt, defer err, hash
  if(err)
    return next err

  user.password = hash
  next()

User.methods.comparePassword = (password, cb) ->
  await bcrypt.compare password, this.password, defer err, isMatch
  if(err)
    return cb err

  return cb null, isMatch

module.exports.model = User
