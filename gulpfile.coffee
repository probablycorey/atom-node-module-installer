coffee = require 'gulp-coffee'
del = require 'del'
gulp = require 'gulp'

gulp.task 'default', ['clean'], ->
  gulp.src('./src/*.coffee')
    .pipe(coffee())
    .on 'error', console.error
    .pipe(gulp.dest('./lib'))

gulp.task 'clean', ->
  del 'lib/*'

gulp.task 'watch', ->
  gulp.watch './src/*.coffee', ['default']
