angular.module("app").filter "profileSocialIconFilter", ->
	(socialProfile) ->
		switch socialProfile.name
			when "twitter" then "fa-twitter"
			when "github" then "fa-github"
			when "facebook" then "fa-facebook-square"
			when "skype" then "fa-skype"
			when "keybase" then "fa-key"
			when "mail" then "fa-envelope-square"
			else "fa-question"
