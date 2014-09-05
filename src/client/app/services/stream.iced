angular.module("app").service "StreamService", ($http, endpoints) ->
	service = {}

	service.fetch = (offset) ->
		$http
			url: [ endpoints.stream, offset ].join "/"
			method: 'GET'

	return service
