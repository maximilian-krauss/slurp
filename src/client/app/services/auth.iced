angular.module("app").service "AuthService", ($http, endpoints) ->
	service = {}

	service.login = (authModel) ->
		$http
			url: "#{endpoints.user}/login"
			method: "POST"
			data: JSON.stringify authModel

	service.signup = (signupModel) ->
		$http
			url: endpoints.user
			method: "POST"
			data: JSON.stringify signupModel
			headers: "X-Auth-Token": signupModel.authToken

	return service
