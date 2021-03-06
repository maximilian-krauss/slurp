angular.module("app").directive "slActivity", ($sce, directiveTemplateUri, PostService, AuthService, DialogService, NotificationService, RealtimeService, socketEvents) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-activity.html"
	scope:
		model: "="
	controller: ($scope) ->
		$scope.removed = false
		$scope.isAuthenticated = AuthService.isAuthenticated
		$scope.isLink = $scope.model.type is "link"

		_hitcountIncreased = (data) ->
			return if data.uid isnt $scope.model.uid
			$scope.$apply ->
				$scope.model.hitCount++;

		$scope.$on "$destroy", ->
			RealtimeService.removeListener socketEvents.post.hitcountIncreased, _hitcountIncreased

		$scope.renderHtmlBody = ->
    	return $sce.trustAsHtml($scope.model.rendered);

		$scope.renderDate = ->
			return moment($scope.model.date).fromNow()

		$scope.delete = ->
			DialogService.confirm
				title: "Confirm deletion"
				content: "Are you sure that you want to delete this post?"
			.then ->
				PostService.delete $scope.model.uid
					.catch (err) ->
						NotificationService.error
							title: "Failed to remove post"
							message: err.data.message

		$scope.trackClick = ->
			PostService.trackClick $scope.model.uid

		$scope.rerender = ->
			postUid = $scope.model.uid
			DialogService.blockUi
				title: "Rendering..."
				message: "Please wait while your post is being rendered..."
				promise: PostService.rerender [ postUid ]
			.then (result) =>
				$scope.model = _(result.data).find uid: postUid
				NotificationService.success message: "Post rerendered!"
			.catch (err) =>
				NotificationService.error
					title: "Failed to rerender post"
					message: err.data.message
					timeout: 10

		RealtimeService.on socketEvents.post.hitcountIncreased, _hitcountIncreased
