angular.module("app").service "UserService", ($http, endpoints) ->
	service = {}

	service.profile = ->
		$http
			url: endpoints.user
			method: "GET"

	service.changePassword = (model) ->
		$http
			url: [endpoints.user, "change-password"].join "/"
			data: JSON.stringify model
			method: "POST"

	return service
