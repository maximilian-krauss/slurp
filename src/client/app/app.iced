app = angular.module "app", [
		"ngRoute"
		"ngSanitize"
		"classy"
		"formly"
		"ui.bootstrap"
	]

app.config ($routeProvider, $locationProvider) ->
	templateUri = "/static/html/views"
	$locationProvider.html5Mode true

	nonActionController = ->
		return

	$routeProvider
		.when "/",
			controller: "HomeCtrl"
			templateUrl: [ templateUri, "home.html" ].join("/")
			authRequired: false

		.when "/login",
			controller: "LoginCtrl"
			templateUrl: [ templateUri, "login.html" ].join("/")
			title: "Login"
			authRequired: false

		.when "/logout",
			controller: "LogoutCtrl"
			templateUrl: [ templateUri, "logout.html" ].join("/")
			title: "Logout"
			authRequired: true

		.when "/signup",
			controller: "SignupCtrl"
			templateUrl: [ templateUri, "signup.html" ].join("/")
			title: "Signup"
			authRequired: false

		.when "/settings",
			controller: "SettingsCtrl"
			templateUrl: [ templateUri, "settings.html" ].join("/")
			title: "Settings"
			authRequired: true

		.when "/404",
			controller: nonActionController
			templateUrl: [ templateUri, "errors", "http404.html" ].join("/")
			title: "Page not found"
			authRequired: false

		.when "/posts/:id",
			controller: "PostCtrl"
			templateUrl: [ templateUri, "post.html" ].join("/")
			title: "Post"
			authRequired: false
			resolve:
				postModel: ($route, PostService) ->
					return PostService.get $route.current.params.id

		.otherwise
			redirectTo: "/404"

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.value "directiveTemplateUri", "/static/html/directives/"
app.value "dialogTemplateUri", "/static/html/dialogs/"
app.value "tabsTemplateUri", "/static/html/tabs/"

app.run ($rootScope, $location) ->

	$rootScope.$on "$routeChangeError", (err) ->
		$location.path "/404"

	defaultTitle = window.application?.title
	$rootScope.$on "$routeChangeStart", (event, nextRoute, currentRoute) ->
		#TODO: Verify access

		if nextRoute.title
			$rootScope.title = "#{nextRoute.title} - #{defaultTitle}"
		else
			$rootScope.title = defaultTitle
