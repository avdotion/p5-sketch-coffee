gulp = require 'gulp'
connect = require 'gulp-connect'
jade = require 'gulp-jade'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
clean = require 'gulp-clean'
sequence = require 'run-sequence'

gulp.task 'connect', ->
  connect.server
    port: 1337
    livereload: on
    root: './dist'

gulp.task 'jade', ->
  gulp.src 'jade/*.jade'
    .pipe jade pretty: on
    .pipe gulp.dest 'dist'
    .pipe do connect.reload

gulp.task 'stylus', ->
  gulp.src 'stylus/*.styl'
    .pipe do stylus
    .pipe gulp.dest 'dist/css'
    .pipe do connect.reload

gulp.task 'develop', ->
  sequence 'coffee', 'concat', 'clean'

gulp.task 'coffee', ->
  gulp.src 'coffee/*.coffee'
    .pipe do coffee
    .on 'error', console.log
    .pipe gulp.dest 'js'

gulp.task 'concat', ->
  gulp.src ['js/sketch.js', 'js/*.js']
    .pipe concat 'sketch.js'
    .pipe gulp.dest 'dist/js'
    .pipe do connect.reload

gulp.task 'clean', ->
  gulp.src 'js', read: no
    .pipe do clean

gulp.task 'develop', ->
  sequence 'coffee', 'concat', 'clean'

gulp.task 'watch', ->
  gulp.watch 'jade/*.jade', ['jade']
  gulp.watch 'stylus/*.styl', ['stylus']
  gulp.watch 'coffee/*.coffee', ['develop']

gulp.task 'default', ['jade', 'stylus', 'develop', 'connect', 'watch']
