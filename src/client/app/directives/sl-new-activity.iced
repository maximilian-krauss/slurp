angular.module("app").directive "slNewActivity", ($rootScope, directiveTemplateUri, events, AuthService, PostService, NotificationService) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-new-activity.html"
	scope: true
	link: (scope) ->
		scope.isSubmitBusy = false
		scope.authenticated = AuthService.isAuthenticated
		scope.newActivityVM =
			title: ""
			content: ""

		_resetNewActivityForm = () ->
			scope.newActivityVM.title = ""
			scope.newActivityVM.content = ""

		scope.submitPost = ->
			scope.isSubmitBusy = true

			PostService.create(scope.newActivityVM)
				.then (result) ->
					$rootScope.$broadcast events.activity.new, result.data
					_resetNewActivityForm()
				.catch (err) ->
					NotificationService.error message: err.data.message
				.finally ->
					scope.isSubmitBusy = false
