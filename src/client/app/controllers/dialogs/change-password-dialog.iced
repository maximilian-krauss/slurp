angular.module("app").controller "ChangePasswordDialogCtrl", ($scope, $modalInstance, UserService) ->
	$scope.isBusy = false
	$scope.form =
		vm: {}
		options:
			hideSubmit: true
		fields: [
			{
				key: "currentPassword"
				type: "password"
				label: "Current password"
				required: true
			}
			{
				key: "newPassword"
				type: "password"
				label: "New password"
				required: true
			}
			{
				key: "confirmation"
				type: "password"
				label: "Confirm new password"
				required: true
			}
		]

	$scope.changePassword = ->
		$scope.isBusy = true
		UserService.changePassword $scope.form.vm
			.then $modalInstance.close
			.catch $modalInstance.dismiss

	$scope.cancel = ->
		$modalInstance.dismiss()
