coffee = require 'gulp-coffee'
del = require 'del'
gulp = require 'gulp'

gulp.task 'default', ['clean'], ->
  gulp.src('./*.coffee')
    .pipe(coffee())
    .on 'error', console.error
    .pipe(gulp.dest('.'))

gulp.task 'clean', ->
  del '*.js'

gulp.task 'watch', ->
  gulp.watch '*.coffee', ['default']
