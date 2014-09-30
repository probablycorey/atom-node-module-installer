childProcess = require('child_process')
os = require 'os'
path = require 'path'

_ = require 'underscore'
{Promise} = require 'es6-promise'

CUSTOM_NODE_URL = 'https://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist'

moduleInstaller =
  install: (appPath, atomShellVersion, npmCachePath, {debug, verbose}={}) ->
    cwd = appPath
    env =
      HOME: npmCachePath
      PATH: path.resolve(__dirname, '..', 'bin') + path.delimiter + process.env['PATH'] # Npm requires node, so add the downloaded node bin to the PATH env var.
      npm_config_disturl: CUSTOM_NODE_URL
      npm_config_target: atomShellVersion
      npm_config_arch: process.arch

    _.defaults(env, process.env)

    new Promise (resolve, reject) ->
      args = ['install']
      args.push '--debug' if debug

      npm = childProcess.spawn(moduleInstaller.getNpmPath(), args, {env, cwd})
      npm.on 'error', (error) ->
        reject(moduleInstaller.createError(error.message, npm))
      npm.on 'exit', (code, signal) ->
        if code == 0
          resolve()
        else
          reject(moduleInstaller.createError("Failed to install node modules (code:#{code})", npm))

      if verbose
        npm.stdout.pipe(process.stdout)
        npm.stderr.pipe(process.stderr)

  getNpmPath: ->
    path.join(__dirname, '../node_modules/.bin/npm')

  createError: (message, proc) ->
    message = "#{message}.\n"
    message += "stdout:\n#{proc.stdout.read()}\n\n"
    message += "stderr:\n#{proc.stderr.read()}"

    new Error(message)

module.exports = moduleInstaller.install
