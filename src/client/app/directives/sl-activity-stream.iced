angular.module("app").directive "slActivityStream", (StreamService, NotificationService, directiveTemplateUri, events) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	link: (scope, elem, attrs) ->
		scope.isStreamBusy = false
		scope.noMorePosts = false
		scope.activities = []

		streamOffset = 0

		scope.fetchActivities = () ->
			return if scope.isStreamBusy or scope.noMorePosts

			scope.isStreamBusy = true
			StreamService.fetch(streamOffset++)
				.then (result) =>
					_(result.data).each (activity) ->
						scope.activities.push(activity)

					scope.noMorePosts = true if result.data.length is 0
					scope.isStreamBusy = false
				.catch (err) =>
					console.log err

		scope.$on events.activity.new, (ev, arg) ->
			scope.activities.splice 0, 0, arg

		_updateStream = () ->
			if $(window).scrollTop() is ($(document).height() - $(window).height())
				scope.fetchActivities()

		scope.fetchActivities()

		$(window).scroll =>
			_updateStream()

		$(window).on
			"touchmove": () =>
				_updateStream()
