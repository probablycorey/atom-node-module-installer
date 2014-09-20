childProcess = require 'child_process'
fs = require 'fs'
http = require 'http'
path = require 'path'
zlib = require 'zlib'

tar = require 'tar'

NODE_VERSION = '0.10.32'
NODE_PATH = path.join(__dirname, '../bin/node')

# Because machines running atom-shell may not have node.js installed, this insures
# that a node.js binary will be installed for npm.
downloadNode = ->
  writeStream = fs.createWriteStream(NODE_PATH)
    .on 'error', (error) ->
      exit 1, "Failed to write #{NODE_PATH}: #{error}"
    .on 'finish', ->
      fs.chmodSync NODE_PATH, "0755"
      exit 0

  request = http.get getNodeUrl(), (response) ->
    response
      .pipe(zlib.createGunzip())
        .on 'error', (error) ->
          exit 1, "Failed to unzip #{getNodeUrl()}: #{error}"
      .pipe(tar.Parse())
        .on 'error', (error) ->
          exit 1, "Failed to untar #{getNodeUrl()}: #{error}"
        .on 'entry', (entry) ->
          entry.pipe(writeStream) if /\/bin\/node$/.test(entry.path)

exit = (code, message) ->
  console.error message if message
  process.exit code

getNodeUrl = ->
  "http://nodejs.org/dist/v#{NODE_VERSION}/node-v#{NODE_VERSION}-#{process.platform}-#{process.arch}.tar.gz"

getInstalledVersion = (callback) ->
  childProcess.exec NODE_PATH + ' -v', (error, stdout) ->
    version = stdout[1..].trim() # Remove v prefix
    callback(version)

getInstalledVersion (version) ->
  downloadNode() if version != NODE_VERSION
