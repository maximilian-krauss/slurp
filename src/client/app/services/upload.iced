angular.module("app").service "UploadService", ($http, $upload, endpoints) ->
	service = {}

	service.upload = (file) ->
		$upload.upload
			url: endpoints.upload
			method: "POST"
			file: file
			withCredentials: true

	service.delete = (uid) ->
		$http
			url: [ endpoints.upload, uid ].join "/"
			method: "DELETE"

	service.assign = (uploadUid, refUid, refType) ->
		$http
			url: [ endpoints.upload, uploadUid, "assign" ].join "/"
			method: "POST"
			data: JSON.stringify
				uploadUid: uploadUid
				referenceUid: refUid
				referenceType: refType

	return service
