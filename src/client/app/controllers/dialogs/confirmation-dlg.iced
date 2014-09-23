angular.module("app").controller "ConfirmationDialogCtrl", ($modalInstance, $scope, options) ->
	$scope.options = options

	$scope.ok = ->
		$modalInstance.close()

	$scope.cancel = ->
		$modalInstance.dismiss()
