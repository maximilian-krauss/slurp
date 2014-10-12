angular.module("app").directive "slNewActivity", ($rootScope, directiveTemplateUri, events, AuthService, PostService, NotificationService, UploadService, DialogService) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-new-activity.html"
	scope: true
	controller: ($scope) ->
		$scope.isSubmitBusy = false
		$scope.isUploadBusy = false
		$scope.authenticated = AuthService.isAuthenticated
		$scope.upload = null
		$scope.newActivityVM =
			title: ""
			content: ""

		_resetNewActivityForm = ->
			$scope.newActivityVM.title = ""
			$scope.newActivityVM.content = ""
			$scope.upload = null

		_verifyFileType = (file) ->
			return file?.type?.indexOf "image/" > -1

		$scope.submitPost = ->
			$scope.isSubmitBusy = true

			PostService.create post: $scope.newActivityVM, upload: $scope.upload
				.then (result) ->
					$rootScope.$broadcast events.activity.new, result.data
					_resetNewActivityForm()
				.catch (err) ->
					NotificationService.error title: "Post failed", message: err.data.message
				.finally ->
					$scope.isSubmitBusy = false


		$scope.onFileSelect = ($files) ->
			return if $scope.isUploadBusy or $scope.upload

			file = _($files).first()
			if _verifyFileType file
				$scope.isUploadBusy = true

				UploadService.upload file
					.then (result) =>
						$scope.upload = result.data
						$scope.newActivityVM.content = $scope.upload.blobUri
					.catch (err) =>
						NotificationService.error
							title: "Upload failed"
							message: err.data.message
							timeout: 10
					.finally =>
						$scope.isUploadBusy = false

		$scope.revokeUpload = ->
			DialogService.confirm
				title: "Confirm deletion"
				content: "Do you really want to delete the uploaded image?"
			.then =>
				UploadService.delete $scope.upload.uid
				$scope.newActivityVM.content = ""
				$scope.upload = null
