angular.module("app").service "SettingsService", ($http, endpoints) ->
	service = {}

	service.getApplication = ->
		$http
			method: "GET"
			url: [ endpoints.settings, "application" ].join("/")

	service.putApplication = (model) ->
		$http
			method: "PUT"
			url: [ endpoints.settings, "application" ].join("/")
			data: JSON.stringify(model)

	service.getProfile = ->
		$http
			method: "GET"
			url: [ endpoints.settings, "profile" ].join("/")

	service.putProfile = (model) ->
		$http
			method: "PUT"
			url: [ endpoints.settings, "profile" ].join("/")
			data: JSON.stringify(model)

	return service
