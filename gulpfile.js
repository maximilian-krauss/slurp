var _             = require('lodash'),
    crypto        = require('crypto'),
    gulp  				= require('gulp'),
    gutil					= require('gulp-util'),
		iced					= require('gulp-iced'),
    coffee        = require('gulp-coffee'),
		concat				= require('gulp-concat'),
		clean					= require('gulp-clean'),
    stylus        = require('gulp-stylus'),
    path          = require('path'),
    bower         = require('gulp-bower'),
    htmlreplace   = require('gulp-html-replace'),
    htmlmin       = require('gulp-htmlmin'),
    bowerPath     = './bower_components',
		thirdPartyJs	= [
      'jquery/dist/jquery.min.js',
      'angular/angular.min.js',
      'angular-route/angular-route.min.js',
      'angular-sanitize/angular-sanitize.min.js',
      'lodash/dist/lodash.min.js',
      'angular-classy/angular-classy.min.js',
      'angular-formly/dist/formly.bootstrap.min.js',
      'angular-bootstrap/ui-bootstrap.min.js',
      'angular-bootstrap/ui-bootstrap-tpls.min.js',
      'moment/min/moment.min.js',
      'alertify.js/lib/alertify.min.js',
      'ng-file-upload/angular-file-upload.min.js',
      'marked/lib/marked.js'
		],
		thirdPartyCss	= [
      'normalize.css/normalize.css',
      'bootstrap/dist/css/bootstrap.min.css',
      'bootstrap/dist/css/bootstrap-theme.min.css',
      'alertify.js/themes/alertify.core.css',
      'alertify.js/themes/alertify.bootstrap.css'
		],
		directories		= {
      clean: {
        server: './app/**/*.js',
        client: ['./public/**/*.js', './public/**/*.css']
      },
			server: {
				iced: { src: './src/server/**/*.iced', dest: './app' }
			},
			client: {
				iced: { src: ['./src/client/app/app.iced', './src/client/app/**/*.iced'], dest: './public/js' },
				styles: { src: ['./src/client/styles/app.styl', './src/client/styles/*.styl'], dest: './public/css' },
				images: { src: './src/client/images/**/*', dest: './public/images' },
        html: { src: './src/client/html/**/*.html', dest: './public/html' }
			}
		};

var idgen = function() {
  var seed = crypto.randomBytes(20);
  return crypto.createHash('sha1').update(seed).digest('hex');
};

// Clean
gulp.task('clean', [ 'clean:server', 'clean:client' ]);

gulp.task('clean:server', function() {
	gulp.src(directories.clean.server)
		.pipe(clean());
});

gulp.task('clean:client', function() {
	gulp.src(directories.clean.client)
		.pipe(clean());
});

// Bower
gulp.task('bower', function() {
  return bower();
});

// Server
gulp.task('server:compile', function() {
	gulp.src(directories.server.iced.src)
		.pipe(iced({ bare: false }).on('error', gutil.log))
		.pipe(gulp.dest(directories.server.iced.dest));
});

// Client
gulp.task('client:compile', function() {
  var hash = idgen(),
      appConfig = '/' + hash + '/application-config.js'
      appjs = 'app-' + hash + '.js',
      vendorjs = 'vendor-' + hash + '.js',
      appcss = 'app-' + hash + '.css',
      vendorcss = 'vendor-' + hash + '.css';

  gulp.src(directories.clean.client)
    .pipe(clean());

  gulp.src(directories.client.iced.src)
    .pipe(coffee({ bare: false }).on('error', gutil.log))
    .pipe(concat(appjs))
    .pipe(gulp.dest(directories.client.iced.dest));

  gulp.src(_(thirdPartyJs).chain().map(function(s) { return [ bowerPath, s ].join('/') }).value())
    .pipe(concat(vendorjs))
    .pipe(gulp.dest(directories.client.iced.dest));

  gulp.src(directories.client.styles.src)
    .pipe(stylus({set: ['compress']}))
    .pipe(concat(appcss))
    .pipe(gulp.dest(directories.client.styles.dest));

  gulp.src(_(thirdPartyCss).chain().map(function(s) { return [ bowerPath, s ].join('/') }).value())
    .pipe(concat(vendorcss))
    .pipe(gulp.dest(directories.client.styles.dest));

  gulp.src(directories.client.html.src)
    .pipe(htmlreplace({
      'css': [ '/static/css/' + vendorcss, '/static/css/' + appcss ],
      'js': [ appConfig, '/static/js/' + vendorjs, '/static/js/' + appjs ]
    }))
    .pipe(htmlmin({ collapseWhitespace: true, removeComments: true }))
    .pipe(gulp.dest(directories.client.html.dest));

  gulp.src(directories.client.images.src)
    .pipe(gulp.dest(directories.client.styles.dest));
});


gulp.task('default', [ 'server:compile', 'client:compile' ]);
gulp.task('production', [ 'bower' ], function() {
  gulp.start('default');
});

// Development
gulp.task('dev:client', function() {
  gulp.watch('./src/client/**/*', ['default']);
});
