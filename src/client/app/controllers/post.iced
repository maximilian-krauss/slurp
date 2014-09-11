angular.module("app").classy.controller
	name: "PostCtrl"
	inject: [ "$scope", "$routeParams", "$location", "$rootScope", "PostService", "postModel" ]

	init: ->
		@$.model = @postModel.data
		@$rootScope.title = @postModel.data.title
