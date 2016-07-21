require! {
  gulp
  'gulp-util': gutil
  'run-sequence'
  'yamljs': YAML
}

is-darwin = /darwin/i.test process.platform
is-ubuntu = !!process.env.IS_UBUNTU


# ---------------------------------------------------------
# package
# ---------------------------------------------------------

gulp.task \pre-apt, (cb) ->
  YAML.load './config/pre-apt.yaml' (config) ->
    require('./tasks/pre-apt')(config, cb)

gulp.task \apt, [\pre-apt], (cb) ->
  YAML.load './config/apt.yaml' (config) ->
    require('./tasks/apt')(config, cb)

gulp.task \pre-brew, (cb) ->
  YAML.load './config/pre-brew.yaml' (config) ->
    require('./tasks/pre-brew')(config, cb)

gulp.task \brew, [\pre-brew], (cb) ->
  YAML.load './config/brew.yaml' (config) ->
    require('./tasks/brew')(config, cb)

do ->
  tasks = []
  tasks.push \apt  if is-ubuntu
  tasks.push \brew if is-darwin
  gulp.task \package tasks

# ---------------------------------------------------------
# rc
# ---------------------------------------------------------

gulp.task \rc []


# ---------------------------------------------------------
# entry point
# ---------------------------------------------------------

gulp.task \test []

gulp.task \default (cb)->
  run-sequence(
    \package
    \rc
    cb
  )
