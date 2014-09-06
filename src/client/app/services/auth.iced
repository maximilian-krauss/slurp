angular.module("app").factory "AuthService", ($rootScope, $http, $q, endpoints, events) ->
	service =
		isAuthenticated: window.application.isAuthenticated

	service.login = (authModel) ->
		deferred = $q.defer()

		$http
			url: "#{endpoints.user}/login"
			method: "POST"
			data: JSON.stringify authModel
		.then =>
			@isAuthenticated = true
			$rootScope.$broadcast events.auth.loggedin
			deferred.resolve()
		, (err) =>
			deferred.reject()

		deferred.promise

	service.signup = (signupModel) ->
		$http
			url: endpoints.user
			method: "POST"
			data: JSON.stringify signupModel
			headers: "X-Auth-Token": signupModel.authToken

	return service
