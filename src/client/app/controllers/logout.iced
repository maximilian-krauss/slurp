angular.module("app").classy.controller
	name: "LogoutCtrl"
	inject: ["$scope", "$location", "AuthService"]

	logout: ->
		@AuthService.logout()
			.finally =>
				@$location.path "/"

	cancel: ->
		@$location.path "/"
