angular.module("app").classy.controller
	name: "PostCtrl"
	inject: ["$scope", "$routeParams", "$location", "$rootScope", "PostService"]

	init: ->
		@$isBusy = true
		@PostService.get @$routeParams.id
			.then (result) =>
				@$.model = result.data
				@$rootScope.title = @$.model.title
				@$.isBusy = false

			.catch =>
				@$location.path "/404"
