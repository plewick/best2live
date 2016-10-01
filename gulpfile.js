/* Enviroment settings */ 
var jspath = "resources/assets/js/", //destination of scripts to be compiled to
    coffeePath = "resources/assets/coffee/", //If you prefer coffee with your scripts
    jsdest = "www/js", //destination compiled scripts
    lessPath = "resources/assets/less/", // less main file destination
    lessDest = "www/css", // path to compile less
    bowerPath = "resources/assets/bower_components/", // path to include bower files
    phpFiles = "resources/**/*.php"; // additional autoreload watch destination

/* Gulp dependencies */ 
var gulp = require('gulp'),
    gutil = require('gulp-util'),
    less = require('gulp-less'),
    uglify = require('gulp-uglify'),
    concat = require('gulp-concat'),
    rename = require('gulp-rename'),
    jshint = require('gulp-jshint'),
    autoprefixer = require('gulp-autoprefixer'),
    livereload = require('gulp-livereload'),
    stripDebug = require('gulp-strip-debug'),
    cssmin = require('gulp-cssmin'),
    coffee = require('gulp-coffee'),
    gulpif = require('gulp-if');
    server = livereload();

gulp.task('less', function() {
    gulp.src([
        lessPath+'main.less'])
        .pipe(less().on("error",gutil.log))
        .pipe(concat("main.css").on("error",gutil.log))
        .pipe(autoprefixer())
        .pipe(cssmin())
        .pipe(gulp.dest(lessDest))
        .pipe(livereload());
});

gulp.task('compress', function() {
    return gulp.src([        
        bowerPath+'jquery/dist/jquery.min.js',
        bowerPath+'jquery-migrate/jquery-migrate.min.js',
        coffeePath+'main.coffee',
        jspath+'main.js',
        ])
        .pipe(gulpif(/[.]coffee$/, coffee({bare: true}).on('error', gutil.log)))
        .pipe(jshint().on("error",gutil.log))
        .pipe(concat("app.min.js").on("error",gutil.log))
        // Uncomment following lines on deploy and compile
        //.pipe(stripDebug())
        //.pipe(uglify().on("error",gutil.log))
        .pipe(gulp.dest(jsdest))
        .pipe(livereload());
});

gulp.task('coffee', function() {
  gulp.src([
        bowerPath+'jquery/dist/jquery.min.js',
        bowerPath+'jquery-migrate/jquery-migrate.min.js',
        coffeePath+'main.coffee'
    ])
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(concat("app.cf.min.js").on("error",gutil.log))
    .pipe(gulp.dest(jsdest))
    .pipe(livereload());
});

gulp.task('change', function() {
    return gulp.src(phpFiles)
        .pipe(livereload.reload());
});
gulp.task('default',['less', 'compress']);
gulp.task('watch', function() {
    livereload.listen();
    gulp.watch(lessPath+'*.less', ['less']);
    gulp.watch(jspath+'*.js', ['compress']);
    gulp.watch(coffeePath+'*.coffee', ['compress']);
    gulp.watch(phpFiles).on('change', function(file) {
        livereload.changed(file.path);
    });
});