should = require("chai").should()
ytInspector = require "../../sherlock/inspectors/youtube"

youtubeLongHttpUrl = "http://www.youtube.com/watch?v=UWb5Qc-fBvk"
youtubeLongHttpNoWwwUrl = "http://youtube.com/watch?v=UWb5Qc-fBvk"
youtubeLongHttpsUrl = "https://www.youtube.com/watch?v=UWb5Qc-fBvk"
youtubeLongHttpsNoWwwUrl = "https://youtube.com/watch?v=UWb5Qc-fBvk"
youtubeShortHttpUrl = "http://youtu.be/UWb5Qc-fBvk"
invalidUrl = "http://www.youtube.com"

describe "Sherlock", ->

	describe "YouTube", ->

		it "should build an valid inspector", ->
			inspector = new ytInspector content: invalidUrl
			inspector.should.be.a "Object"

		it "should fail by invalid urls", ->
			inspector = new ytInspector content: invalidUrl
			match = inspector.matches()
			match.should.equal false

		it "should detect www.youtube.com http urls", ->
			inspector = new ytInspector content: youtubeLongHttpUrl
			match = inspector.matches()
			match.should.equal true

		it "should detect youtube.com http urls", ->
			inspector = new ytInspector content: youtubeLongHttpNoWwwUrl
			match = inspector.matches()
			match.should.equal true

		it "should detect www.youtube.com https urls", ->
			inspector = new ytInspector content: youtubeLongHttpsUrl
			match = inspector.matches()
			match.should.equal true

		it "should detect youtube.com https urls", ->
			inspector = new ytInspector content: youtubeLongHttpsNoWwwUrl
			match = inspector.matches()
			match.should.equal true

		it "should detect youtu.be http urls", ->
			inspector = new ytInspector content: youtubeShortHttpUrl
			match = inspector.matches()
			match.should.equal true

		it "should render youtube posts", (done) ->
			inspector = new ytInspector content: youtubeLongHttpUrl
			await inspector.render defer err, post
			throw err if err

			post.should.have.property "type"
			post.should.have.property "renderedContent"
			post.type.should.equal "youtube"
			done()
