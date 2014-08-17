app = angular.module "app", [
		"ngRoute"
		"classy"
		"formly"
	]

app.config ($routeProvider, $locationProvider) ->
	templateUri = "/static/html/views"
	$locationProvider.html5Mode true


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

		.when "/signup",
			controller: "SignupCtrl"
			templateUrl: [ templateUri, "signup.html" ].join("/")
			title: "Signup"
			authRequired: false

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
