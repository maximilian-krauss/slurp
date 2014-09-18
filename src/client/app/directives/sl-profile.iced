angular.module("app").directive "slProfile", (directiveTemplateUri, UserService, AuthService) ->
	restrict: "E"
	replace: true
	templateUrl: [ directiveTemplateUri, "sl-profile.html" ].join("/")
	scope: true
	controller: ($scope) ->
		$scope.profileLoaded = false
		$scope.showProfile = true
		$scope.profile = {}
		$scope.authenticated = AuthService.isAuthenticated

		_init = () ->
			UserService.profile()
				.then (result) ->
					$scope.profile = result.data
					$scope.profileLoaded = true
				.catch () ->
					$scope.showProfile = false

		_init()
