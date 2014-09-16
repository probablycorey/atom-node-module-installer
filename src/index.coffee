childProcess = require('child_process')
os = require 'os'
path = require 'path'

_ = require 'underscore'
{Promise} = require 'es6-promise'

CUSTOM_NODE_URL = 'https://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist'

moduleInstaller =
  install: (appPath, atomShellVersion, npmCachePath, {debug}={}) ->
    cwd = appPath
    env = _.extend {}, process.env,
      HOME: npmCachePath
      npm_config_disturl: CUSTOM_NODE_URL
      npm_config_target: atomShellVersion
      npm_config_arch: moduleInstaller.getNodeArch

    new Promise (resolve, reject) ->
      args = ['install']
      args.push '--debug' if debug
      npm = childProcess.spawn(moduleInstaller.getNpmPath(), args, {env, cwd})
        .on 'error', (error) ->
          reject(moduleInstaller.createError(error.message, npm))
        .on 'exit', (code, signal) ->
          if code == 0
            resolve()
          else
            reject(moduleInstaller.createError("Failed to install node modules (code:#{code})", npm))

  getNodeArch: ->
    nodeArch = switch process.platform
      when 'darwin' then 'x64'
      when 'win32' then 'ia32'
      else process.arch

  getNpmPath: ->
    path.join(__dirname, '../node_modules/.bin/npm')

  createError: (message, proc) ->
    message = "#{message}.\n"
    message += "stdout:\n#{proc.stdout.read()}\n\n"
    message += "stderr:\n#{proc.stderr.read()}"

    new Error(message)

module.exports = moduleInstaller.install
