angular.module("app").classy.controller
	name: "HeaderCtrl"
	inject: [ "$scope" ]
	init: ->
		@$.title = window.application.title
		@$.description = window.application.description
		@$.heading =
			"background-image": "url('#{window.application.teaserImage.url}')"
