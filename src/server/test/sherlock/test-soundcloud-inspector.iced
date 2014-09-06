should 			= require("chai").should()
scInspector	= require "../../sherlock/inspectors/soundcloud"

scHttpNoWwwUrl = "http://soundcloud.com/robin-schulz/robin-schulz-summerbreeze-dj-mix"
scHttpsNoWwwUrl = "https://soundcloud.com/robin-schulz/robin-schulz-summerbreeze-dj-mix"
scInvalidUrl = "http://soundcloud.com"

describe "Sherlock", ->
	describe "SoundCloud", ->

		it "should build a valid inspector", ->
			inspector = new scInspector content: scHttpNoWwwUrl
			inspector.should.be.a "Object"

		it "should fail by invalid urls", ->
			inspector = new scInspector content: scInvalidUrl
			match = inspector.matches()
			match.should.equal false

		it "should detect soundcloud.com http urls", ->
			inspector = new scInspector content: scHttpNoWwwUrl
			match = inspector.matches()
			match.should.equal true

		it "should detect soundcloud.com https urls", ->
			inspector = new scInspector content: scHttpsNoWwwUrl
			match = inspector.matches()
			match.should.equal true

		it "should render soundcloud posts", (done) ->
			inspector = new scInspector content: scHttpNoWwwUrl
			await inspector.render defer err, post

			throw err if err

			post.should.have.property "type"
			post.type.should.equal "soundcloud"

			post.should.have.property "renderedContent"

			done()

		it "should set title if none supplied", (done) ->
			inspector = new scInspector content: scHttpNoWwwUrl, title: ""
			await inspector.render defer err, post
			throw err if err

			post.title.should.equal "Robin Schulz - Summerbreeze [DJ-Mix]"
			done()

		it "should not set title if one is supplied by user", (done) ->
			inspector = new scInspector content: scHttpNoWwwUrl, title: "Awesome mix"
			await inspector.render defer err, post
			throw err if err

			post.title.should.equal "Awesome mix"
			done()
