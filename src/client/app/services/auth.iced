angular.module("app").service "AuthService", ($http, endpoints) ->
	service = {}

	service.login = (authModel) ->
		$http
			url: "#{endpoints.user}/login"
			method: "POST"
			data: JSON.stringify authModel

	return service
