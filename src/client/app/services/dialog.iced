angular.module("app").service "DialogService", ($modal, dialogTemplateUri) ->
	service = {}
	defaultConfirmationOptions =
		title: ""
		content: ""

	defaultBlockUiOptions =
		title: ""
		message: ""
		promise: null

	service.confirm = (args) ->
		mergedArgs = _.extend angular.copy(defaultConfirmationOptions), args

		instance = $modal.open
			templateUrl: "#{dialogTemplateUri}confirmation.html"
			controller: "ConfirmationDialogCtrl"
			backdrop: true
			resolve:
				options: -> mergedArgs

		instance.result

	service.blockUi = (args) ->
		mergedArgs = _.extend angular.copy(defaultBlockUiOptions), args

		instance = $modal.open
			templateUrl: "#{dialogTemplateUri}block-ui.html"
			controller: "BlockUiDialogCtrl"
			backdrop: "static"
			keyboard: false
			resolve:
				options: -> mergedArgs

		mergedArgs.promise.then instance.close, instance.dismiss
		
		return mergedArgs.promise

	return service
