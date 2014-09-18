angular.module("app").filter "profileSocialUrlFilter", ($sce) ->
	(socialProfile) ->
		switch socialProfile.name
			when "twitter" then "https://twitter.com/#{socialProfile.handle}"
			when "github" then "https://github.com/#{socialProfile.handle}"
			when "facebook" then "https://www.facebook.com/#{socialProfile.handle}"
			when "keybase" then "https://keybase.io/#{socialProfile.handle}"
			when "skype" then $sce.trustAsHtml("skype:#{socialProfile.handle}?chat")
			else ""
