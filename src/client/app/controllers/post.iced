angular.module("app").classy.controller
	name: "PostCtrl"
	inject: ["$scope", "$routeParams", "$location", "PostService"]

	init: ->
		@$isBusy = true
		@PostService.get @$routeParams.id
			.then (result) =>
				@$.model = result.data
				console.log result.data
				@$.isBusy = false

			.catch =>
				@$location.path "/404"
