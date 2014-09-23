angular.module("app").service "DialogService", ($modal, dialogTemplateUri) ->
	service = {}
	defaultConfirmationOptions =
		title: ""
		content: ""

	service.confirm = (args) ->
		mergedArgs = _.extend angular.copy(defaultConfirmationOptions), args

		instance = $modal.open
			templateUrl: "#{dialogTemplateUri}confirmation.html"
			controller: "ConfirmationDialogCtrl"
			backdrop: true
			resolve:
				options: -> mergedArgs

		instance.result

	return service
