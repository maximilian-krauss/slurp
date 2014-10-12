module.exports =
	mongo:
		server: process.env["MONGO_DB_SERVER"]
		user: process.env["MONGO_DB_USER"]
		password: process.env["MONGO_DB_PASSWORD"]

	azure:
		account: process.env["AZURE_STORAGE_ACCOUNT"]
		key: process.env["AZURE_STORAGE_ACCESS_KEY"]
		container: process.env["AZURE_CONTAINER_NAME"]

	server:
		cookieSecret: process.env["SERVER_COOKIE_SECRET"]
		sessionSecret: process.env["SERVER_SESSION_SECRET"]
		token: process.env["SERVER_AUTH_TOKEN"]
