angular.module("app").directive "slProfile", (directiveTemplateUri, UserService) ->
	restrict: "E"
	replace: true
	templateUrl: [ directiveTemplateUri, "sl-profile.html" ].join("/")
	scope: true
	controller: ($scope) ->
		$scope.profileLoaded = false
		$scope.showProfile = true
		$scope.profile = {}

		_init = () ->
			UserService.profile()
				.then (result) ->
					$scope.profile = result.data
					$scope.profileLoaded = true
				.catch () ->
					$scope.showProfile = false

		_init()
