angular.module("app").service "UserService", ($http, endpoints) ->
	service = {}

	service.profile = () ->
		$http
			url: endpoints.user
			method: "GET"

	return service
