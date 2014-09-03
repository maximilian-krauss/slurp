should = require("chai").should()
ytInspector = require "../../sherlock/inspectors/youtube"

youtubeLongHttpUrl = "http://www.youtube.com/watch?v=UWb5Qc-fBvk"
youtubeLongHttpsUrl = "https://www.youtube.com/watch?v=UWb5Qc-fBvk"
youtubeShortHttpUrl = "http://youtu.be/UWb5Qc-fBvk"
invalidUrl = "http://www.youtube.com"

describe "Sherlock:Youtube", ->
	it "should fail by invalid urls", ->
		inspector = new ytInspector content: invalidUrl
		inspector.should.be.a "Object"
		match = inspector.matches()
		match.should.equal false

	it "should detect youtube.com http urls", ->
		inspector = new ytInspector content: youtubeLongHttpUrl
		inspector.should.be.a "Object"
		match = inspector.matches()
		match.should.equal true

	it "should detect youtube.com https urls", ->
		inspector = new ytInspector content: youtubeLongHttpsUrl
		inspector.should.be.a "Object"
		match = inspector.matches()
		match.should.equal true

	it "should detect youtu.be http urls", ->
		inspector = new ytInspector content: youtubeShortHttpUrl
		inspector.should.be.a "Object"
		match = inspector.matches()
		match.should.equal true
