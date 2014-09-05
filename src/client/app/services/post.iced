angular.module("app").service "PostService", ($http, endpoints) ->
	service = {}

	service.create = (postModel) ->
		$http
			method: 'POST'
			url: endpoints.post
			data: JSON.stringify postModel

	return service
