var gulp  				= require('gulp'),
    gutil					= require('gulp-util'),
		iced					= require('gulp-iced'),
		concat				= require('gulp-concat'),
		clean					= require('gulp-clean'),
		thirdPartyJs	= [

		],
		thirdPartyCss	= [

		],
		directories		= {
			server: {
				iced: { src: './src/server/**/*.iced', dest: './app' }
			},
			client: {
				iced: { src: ['./src/client/app/app.iced', './src/client/app/**/*.iced'], dest: './public/js' },
				styles: { src: './src/client/styles/*.styl', dest: './public/css' },
				images: { src: './src/client/images/**/*', dest: './public/images' }
			}
		};

// Clean
gulp.task('clean', [ 'clean:server', 'clean:client' ]);

gulp.task('clean:server', function() {
	gulp.src(directories.server.iced.dest)
		.pipe(clean({ read: false, force: true }));
});

gulp.task('clean:client', function() {
	gulp.src(directories.client.iced.dest)
		.pipe(clean({ read: false, force: true }));

	gulp.src(directories.client.styles.dest)
		.pipe(clean({ read: false, force: true }));

	gulp.src(directories.client.images.dest)
		.pipe(clean({ read: false, force: true }));
});

// Server
gulp.task('server:compile', function() {
	gulp.src(directories.server.iced.src)
		.pipe(iced({ bare: false }).on('error', gutil.log))
		.pipe(gulp.dest(directories.server.iced.dest));
});


// Client
gulp.task('client:compile', function() {

});


gulp.task('default', [ 'server:compile', 'client:compile' ]);
gulp.task('production', [ 'clean', 'default' ]);
