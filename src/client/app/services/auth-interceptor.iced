angular.module("app").factory "AuthInterceptor", ($q, $rootScope, events) ->
	response: (response) ->
		response or $q.when response

	responseError: (rejection) ->
		if rejection.status is 401
			$rootScope.$broadcast events.auth.unauthorized

		$q.reject rejection
