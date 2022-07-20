# ssBootstrap5

A SilverStripe theme using [Bootstrap 5](https://getbootstrap.com/docs/5.0/getting-started/introduction/) & [HTML5 Boilerplate](http://html5boilerplate.com/).  Uses [Sass](http://sass-lang.com/documentation/_index.html) for compiling CSS and [Bower](http://bower.io) to upgrade libraries.

## Aims
* to be able to upgrade Bootstrap and other javascript libraries to the latest version using Bower
* to use the Sass for the generation of CSS (including customisations)
* to minimise bloat by commenting out Bootstrap's javascript and Sass files

## Instructions
1. Download and copy the `bs5` folder, under themes, into your `themes` folder
2. Set the theme to `'bs5'` in your `themes.yml` file
3. Open `app/PageController.php` and add
```php
    use SilverStripe\View\Requirements;
    ...
    Requirements::css("public/css/main.css");

    Requirements::javascript('//unpkg.com/@popperjs/core@2');

    Requirements::combine_files(
        'combine.js',
        [
            'thirdparty/bower_components/bootstrap/js/dist/dom/data.js',
            'thirdparty/bower_components/bootstrap/js/dist/dom/event-handler.js',
            'thirdparty/bower_components/bootstrap/js/dist/dom/manipulator.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/config.js',
            'thirdparty/bower_components/bootstrap/js/dist/dom/selector-engine.js',
            'thirdparty/bower_components/bootstrap/js/dist/base-component.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/component-functions.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/index.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/backdrop.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/focustrap.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/sanitizer.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/scrollbar.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/swipe.js',
            'thirdparty/bower_components/bootstrap/js/dist/util/template-factory.js',
            'thirdparty/bower_components/bootstrap/js/dist/alert.js',
            'thirdparty/bower_components/bootstrap/js/dist/button.js',
            'thirdparty/bower_components/bootstrap/js/dist/carousel.js',
            'thirdparty/bower_components/bootstrap/js/dist/collapse.js',
            'thirdparty/bower_components/bootstrap/js/dist/dropdown.js',
            'thirdparty/bower_components/bootstrap/js/dist/modal.js',
            'thirdparty/bower_components/bootstrap/js/dist/offcanvas.js',
            'thirdparty/bower_components/bootstrap/js/dist/tooltip.js',
            'thirdparty/bower_components/bootstrap/js/dist/popover.js',
            'thirdparty/bower_components/bootstrap/js/dist/scrollspy.js',
            'thirdparty/bower_components/bootstrap/js/dist/tab.js',
            'thirdparty/bower_components/bootstrap/js/dist/toast.js'
        ]
    );
```
4. At the command line cd to `/public/thirdparty/` and `bower install bootstrap --save`
5. If using the dropdown, tooltip or popovers get a copy of [Popper.js](https://popper.js.org) or use a CDN.
5. Run `/dev/build`.
6. Optional
 * Favicon/icon: upload your icon through http://realfavicongenerator.net/ and copy the generated icons to your project root.

## Requirements
Use software to convert Sass into CSS.  Gulp example below includes browser-sync for page reloading.
```js
// npm install gulp gulp-dart-sass gulp-sourcemaps gulp-if gulp-autoprefixer browser-sync --save-dev

const { gulp, watch, series, parallel, src, dest } = require('gulp');
const sass = require('gulp-dart-sass');
const sourcemaps = require("gulp-sourcemaps");
const gulpif = require('gulp-if');
const autoprefixer = require('gulp-autoprefixer');

// Browser Sync (https://www.browsersync.io/docs/gulp)
const browserSync = require('/usr/local/lib/node_modules/browser-sync').create();

/**
 * Static Server + watching scss/html files
 */
function serve() {

	// Serve files from the root of this project
	// https://www.browsersync.io/docs/options
	browserSync.init({
		proxy: PROXY_URL,
		files: [
			// Patterns for static files to watch.
			// We're watching js and php files within mysite
			// and SilverStripe template files within themes
            "app/**/*.*",
            "public/css/*.css",
            "public/javascript/*.js",
			"themes/bs5/**/*.**"
		],
		notify: false,
		browser: "firefox",
		port: 3003,
        open: "local",
        online: false
	});

    watch("./themes/bs5/scss/*.scss", sassTask);
	watch("./themes/bs5/templates/**/*.ss").on('change', browserSync.reload);
    watch("./app/src/**/*.php").on('change', browserSync.reload);
	watch("./public/javascript/*.js").on('change', browserSync.reload);
};

/**
 * [sassTask description]
 * @return {function} [description]
 */
 function sassTask() {
 	return src(["./themes/bs5/scss/main.scss"])
 		.pipe(gulpif(!isLive, sourcemaps.init()))
 		.pipe(sass().on('error', sass.logError))
 		.pipe(autoprefixer({
             browsers: [
                 ">= 0.5%",
                 "last 2 major versions",
                 "not dead",
                 "not Explorer <= 11",
                 "Chrome >= 60",
                 "Firefox >= 60",
                 "Safari >= 12",
                 "iOS >= 12"
             ]
         }))
 		.pipe(gulpif(!isLive, sourcemaps.write()))
 		.pipe(dest("./public/css"))
 		.pipe(browserSync.stream());
 };

exports.sass = series(sassTask);
exports.serve = series(sassTask, serve);
```

## Structure of the theme's Sass files
* Bootstrap's base variables are overridden by `custom.scss`.
* File `main.scss` adds additional customisations

## Useful Pattern
 A pattern that can be used is to copy Bootstrap's style, in a new class, and customise.  Example below.
 ```css
    .current {
        @extend .active;
    }
 ```

## Changelog
* Updated to Bootstrap 5.20
* Initial release Bootstrap 5.01

## License
[MIT](LICENSE)
