angular.module("app").service "PostService", ($q, $http, endpoints, UploadService) ->
	service = {}

	service.create = (args) ->
		deferred = $q.defer()

		$http
			method: "POST"
			url: endpoints.post
			data: JSON.stringify args.post
		.then (result) =>
			if args.upload
				UploadService.assign args.upload.uid, result.data.uid, "post"
				.then =>
					deferred.resolve result
				.catch (err) =>
					deferred.reject err
			else
				deferred.resolve result

		.catch (err) =>
			deferred.reject err

		return deferred.promise

	service.get = (id) ->
		$http
			method: "GET"
			url: [ endpoints.post, id ].join("/")

	service.delete = (id) ->
		$http
			method: "DELETE"
			url: [ endpoints.post, id ].join("/")

	service.trackClick = (id) ->
		$http
			method: "POST"
			url: [ endpoints.post, id, "track-click" ].join("/")

	service.rerender = (ids) ->
		ids = ids or []

		$http
				method: "POST"
				url: [ endpoints.post, "rerender" ].join "/"
				data: JSON.stringify postUids: ids

	return service
