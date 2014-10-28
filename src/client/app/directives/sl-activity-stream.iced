angular.module("app").directive "slActivityStream", (StreamService, NotificationService, RealtimeService, directiveTemplateUri, events, socketEvents) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	controller: ($scope) ->
		$scope.isStreamBusy = false
		$scope.noMorePosts = false
		$scope.activities = []

		streamOffset = 0

		$scope.fetchActivities = () ->
			return if $scope.isStreamBusy or $scope.noMorePosts

			$scope.isStreamBusy = true
			StreamService.fetch(streamOffset++)
				.then (result) =>
					_(result.data).each (activity) ->
						$scope.activities.push(activity)

					$scope.noMorePosts = true if result.data.length is 0
					$scope.isStreamBusy = false
				.catch (err) =>
					console.log err

		$scope.$on "$destroy", ->
			$(window).off "scroll", _updateStream
			RealtimeService.removeListener socketEvents.post.created, _postCreated
			RealtimeService.removeListener socketEvents.post.deleted, _postDeleted

		_updateStream = ->
			if $(window).scrollTop() is ($(document).height() - $(window).height())
				$scope.fetchActivities()

		_postCreated = (data) ->
			if data and not _($scope.activities).find(uid: data.uid)
				$scope.$apply ->
					$scope.activities.splice 0, 0, data

		_postDeleted = (uid) ->
			$scope.$apply ->
				_($scope.activities).remove (post) -> post.uid is uid

		RealtimeService.on socketEvents.post.created, _postCreated
		RealtimeService.on socketEvents.post.deleted, _postDeleted

		$scope.fetchActivities()

		$(window).on "scroll", _updateStream
