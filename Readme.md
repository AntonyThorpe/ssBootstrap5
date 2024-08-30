# ssBootstrap5

A SilverStripe theme using [Bootstrap 5](https://getbootstrap.com/docs/5.0/getting-started/introduction/) & [HTML5 Boilerplate](http://html5boilerplate.com/).  Uses [Sass](http://sass-lang.com/documentation/_index.html) for compiling CSS and npm to update Bootstrap.

## Aims
* to be able to upgrade Bootstrap to the latest version using npm
* to use the Sass for the generation of CSS (including customisations)
* to minimise bloat by commenting out Bootstrap's javascript and Sass files

## Instructions
1. Download and copy the `bs5` folder, under themes, into your `themes` folder
2. Set the theme to `'bs5'` in your `themes.yml` file
3. Open the command line in the project root and install Popperjs & Bootstrap: `npm install @popperjs/core bootstrap`
4. In `public/javascript/src` add:
```js
    import * as Popper from '@popperjs/core';  // if using tooltip or popovers
    import 'bootstrap/js/dist/dom/data.js';
    import 'bootstrap/js/dist/dom/event-handler.js';
    import 'bootstrap/js/dist/dom/manipulator.js';
    import 'bootstrap/js/dist/util/config.js';
    import 'bootstrap/js/dist/dom/selector-engine.js';
    import 'bootstrap/js/dist/base-component.js';
    import 'bootstrap/js/dist/util/component-functions.js';
    import 'bootstrap/js/dist/util/index.js';
    import 'bootstrap/js/dist/util/backdrop.js';
    import 'bootstrap/js/dist/util/focustrap.js';
    import 'bootstrap/js/dist/util/sanitizer.js';
    import 'bootstrap/js/dist/util/scrollbar.js';
    import 'bootstrap/js/dist/util/swipe.js';
    import 'bootstrap/js/dist/util/template-factory.js';
    import 'bootstrap/js/dist/alert.js';
    import 'bootstrap/js/dist/button.js';
    import 'bootstrap/js/dist/carousel.js';
    import 'bootstrap/js/dist/collapse.js';
    import 'bootstrap/js/dist/dropdown.js';
    import 'bootstrap/js/dist/modal.js';
    import 'bootstrap/js/dist/offcanvas.js';
    import 'bootstrap/js/dist/tooltip.js';   // Needs popper.js
    import 'bootstrap/js/dist/popover.js';  // Needs tooltip.js
    import 'bootstrap/js/dist/scrollspy.js';
    import 'bootstrap/js/dist/tab.js';
    import 'bootstrap/js/dist/toast.js';
```
5. Open `app/PageController.php` and add
```php
    use SilverStripe\View\Requirements;
    ...
    Requirements::css("public/css/main.css");
    Requirements::javascript('//cdnjs.cloudflare.com/polyfill/v3/polyfill.js?version=4.8.0&features=Array.prototype.find%2CPromise%2CObject.assign%2CString.prototype.startsWith');  // for IE11 Popper
    Requirements::javascript('public/javascript/dist/main.js');
```
6. Run your js bundle, saving to `public/javascript/dist` folder.  Example below from `package.json` using [esbuild](https://esbuild.github.io/getting-started/#your-first-bundle): 
```javascript
    "scripts": {
        "esbuild": "esbuild public/javascript/src/main.js --bundle --minify --sourcemap=inline --outfile=public/javascript/dist/main.js"
    }
```
7. Run `/dev/build`.
8. Optional
 * Favicon/icon: upload your icon through http://realfavicongenerator.net/ and copy the generated icons to your public folder.

## Requirements
Use software to convert Sass into CSS & bundle javascript.  [Gulpjs](https://gulpjs.com) example below includes browser-sync for page reloading.
```js
// npm install gulp gulp-dart-sass gulp-sourcemaps gulp-if gulp-autoprefixer browser-sync esbuild --save-dev

import gulp from 'gulp';
import * as esbuild from 'esbuild';  //https://esbuild.github.io/getting-started/

import browserSync from 'browser-sync';  // Browser Sync (https://www.browsersync.io/docs/gulp)
import sassDart from 'gulp-dart-sass';
import sourcemaps from 'gulp-sourcemaps';
import gulpif from 'gulp-if';
import autoprefixer from 'gulp-autoprefixer';

// Variables
const isLive = false;
const PROXY_URL = 'http://yourwebsite:port_number/';

/**
 * @return {function}
 */
function sassTask() {
	return gulp.src(["./themes/bs5/scss/main.scss"])
		.pipe(gulpif(!isLive, sourcemaps.init()))
		.pipe(sassDart().on('error', sassDart.logError))
		.pipe(autoprefixer())
		.pipe(gulpif(!isLive, sourcemaps.write()))
		.pipe(gulp.dest("./public/css"))
		.pipe(browserSync.stream());
};

/**
 * @return {function} bundle javascript
 */
async function esbuildTask() {
    if (isLive) {
        await esbuild.build({
            entryPoints: ['./public/javascript/src/main.js'],
            bundle: true,
            minify: true,
            outfile: 'public/javascript/dist/main.js'
        });
    } else {
        await esbuild.build({
            entryPoints: ['./public/javascript/src/main.js'],
            bundle: true,
            sourcemap: true,
            sourcemap: 'inline',
            outfile: 'public/javascript/dist/main.js'
        });
    }
};

/**
 * Open site & watch
 */
function serveTask() {

	// Serve files from the root of this project
	// https://www.browsersync.io/docs/options
	browserSync.init({
		proxy: PROXY_URL,
        // Files to watch
		files: [
            "app/**/*.*",
            "public/css/*.css",
            "public/javascript/dist/main.js",
			"themes/bs5/**/*.**"
		],
		notify: false,
		browser: "firefox",
		port: 3003,
        open: "local",
        online: false
	});

    gulp.watch("./public/javascript/src/main.js", esbuildTask);
    gulp.watch("./themes/bs5/scss/*.scss", sassTask);
};

let js = gulp.series(await esbuildTask);
let sass = gulp.series(sassTask);
let serve = gulp.series(gulp.parallel(sassTask, esbuildTask), serveTask);

export { sass, js, serve };
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
* Updated to use Bootstrap 5.3.3, dropped Bower, added NPM & bundler example
* Updated to Bootstrap 5.20
* Initial release Bootstrap 5.01

## License
[MIT](LICENSE)
