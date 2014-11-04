angular.module("app").directive "slImageUpload", (UploadService, DialogService, NotificationService, directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-image-upload.html"
	scope:
		imageModel: "="
		heightRatio: "@?"

	link: (scope, elem, attrs) ->
		ratio = attrs.heightRatio or 4
		$(elem).height $(elem).width() / ratio

	controller: ($scope) ->
		$scope.style = {}
		$scope.imageSelected = false
		$scope.uploadBusy = false

		_updateScope = ->
			$scope.imageSelected = $scope.imageModel? and $scope.imageModel.url? and $scope.imageModel.url.length > 0
			$scope.style =
				"background-image": if $scope.imageSelected then "url('#{$scope.imageModel.url}')" else ""

		_onError = (err) ->
			NotificationService.error
				title: "Failed to process image"
				message: err.message
				timeout: 10

		$scope.onFileSelect = ($files) ->
			return if $scope.imageSelected or $scope.uploadBusy

			$scope.uploadBusy = true

			UploadService.upload _($files).first()
			.then (result) =>
				UploadService.assign result.data.uid, "app", "application"
				.then =>
					$scope.imageModel =
						url: result.data.blobUri
						uploadUid: result.data.uid

				.catch _onError
			.catch _onError
			.finally =>
				$scope.uploadBusy = false


		$scope.deleteUpload = ->
			DialogService.confirm
				title: "Confirm deletion"
				content: "Are you sure that you want to delete this upload?"
			.then =>
				UploadService.delete $scope.imageModel.uploadUid
				.then =>
					$scope.imageModel = { url: "", uploadUid: "" }
				.catch _onError


		$scope.$watch "imageModel", _updateScope, true
		_updateScope()
