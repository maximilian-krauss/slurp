var _             = require('lodash'),
    gulp  				= require('gulp'),
    gutil					= require('gulp-util'),
		iced					= require('gulp-iced'),
		concat				= require('gulp-concat'),
		clean					= require('gulp-clean'),
    stylus        = require('gulp-stylus'),
    path          = require('path'),
    bowerPath     = './bower_components',
		thirdPartyJs	= [
      'jquery/dist/jquery.min.js',
      'angular/angular.min.js',
      'angular-route/angular-route.min.js',
      'lodash/dist/lodash.min.js'
		],
		thirdPartyCss	= [

		],
		directories		= {
      clean: {
        server: './app/**/*.js',
        client: './public/**/*'
      },
			server: {
				iced: { src: './src/server/**/*.iced', dest: './app' }
			},
			client: {
				iced: { src: ['./src/client/app/app.iced', './src/client/app/**/*.iced'], dest: './public/js' },
				styles: { src: './src/client/styles/*.styl', dest: './public/css' },
				images: { src: './src/client/images/**/*', dest: './public/images' },
        html: { src: '/src/client/html/**/*.html', dest: './public/html' }
			}
		};

// Clean
gulp.task('clean', [ 'clean:server', 'clean:client' ]);

gulp.task('clean:server', function() {
	gulp.src(directories.clean.server)
		.pipe(clean());
});

gulp.task('clean:client', function() {
	gulp.src(directories.client.iced.dest)
		.pipe(clean());

	gulp.src(directories.client.styles.dest)
		.pipe(clean());

	gulp.src(directories.client.images.dest)
		.pipe(clean());

  gulp.src(directories.client.html.dest)
    .pipe(clean());
});

// Server
gulp.task('server:compile', function() {
	gulp.src(directories.server.iced.src)
		.pipe(iced({ bare: false }).on('error', gutil.log))
		.pipe(gulp.dest(directories.server.iced.dest));
});

// Client
gulp.task('client:compile', function() {
  gulp.src(directories.client.iced.src)
    .pipe(iced({ bare: false, runtime: 'window' }))
    .pipe(concat('app.js'))
    .pipe(gulp.dest(directories.client.iced.dest));

  gulp.src(_(thirdPartyJs).chain().map(function(s) { return [ bowerPath, s ].join('/') }).value())
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest(directories.client.iced.dest));

  gulp.src(directories.client.styles.src)
    .pipe(stylus({set: ['compress']}))
    .pipe(concat('app.css'))
    .pipe(gulp.dest(directories.client.styles.dest));

  /*gulp.src(_(thirdPartyCss).chain().map(function(s) { return [ bowerPath, s ].join('/') }).value())
    .pipe(concat('vendor.css'))
    .pipe(gulp.dest(directories.client.styles.dest));*/

  gulp.src(directories.client.html.src)
    .pipe(gulp.dest(directories.client.html.dest));

  gulp.src(directories.client.images.src)
    .pipe(gulp.dest(directories.client.styles.dest));
});


gulp.task('default', [ 'server:compile', 'client:compile' ]);
gulp.task('production', [ 'clean', 'default' ]);
