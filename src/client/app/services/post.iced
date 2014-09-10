angular.module("app").service "PostService", ($http, endpoints) ->
	service = {}

	service.create = (postModel) ->
		$http
			method: "POST"
			url: endpoints.post
			data: JSON.stringify postModel

	service.get = (id) ->
		$http
			method: "GET"
			url: [ endpoints.post, id ].join("/")

	service.delete = (id) ->
		$http
			method: "DELETE"
			url: [ endpoints.post, id ].join("/")

	return service
