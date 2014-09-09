app = angular.module "app", [
		"ngRoute"
		"ngSanitize"
		"classy"
		"formly"
	]

app.config ($routeProvider, $locationProvider) ->
	templateUri = "/static/html/views"
	$locationProvider.html5Mode true

	nonActionController = ->
		return

	$routeProvider
		.when "/",
			controller: "HomeCtrl"
			templateUrl: [templateUri, "home.html"].join("/")
			authRequired: false

		.when "/login",
			controller: "LoginCtrl"
			templateUrl: [templateUri, "login.html"].join("/")
			title: "Login"
			authRequired: false

		.when "/logout",
			controller: "LogoutCtrl"
			templateUrl: [templateUri, "logout.html"].join("/")
			title: "Logout"
			authRequired: true

		.when "/signup",
			controller: "SignupCtrl"
			templateUrl: [ templateUri, "signup.html" ].join("/")
			title: "Signup"
			authRequired: false

		.when "/404",
			controller: nonActionController
			templateUrl: [ templateUri, "errors", "http404.html" ].join("/")
			title: "Page not found"
			authRequired: false

		.otherwise
			redirectTo: "/404"

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true;

app.value "directiveTemplateUri", "/static/html/directives/"

app.run ($rootScope) ->
	defaultTitle = "slurp:beta"
	$rootScope.$on "$routeChangeStart", (event, nextRoute, currentRoute) ->
		#TODO: Verify access

		if nextRoute.title
			$rootScope.title = "#{nextRoute.title} - #{defaultTitle}"
		else
			$rootScope.title = defaultTitle
