# atom-node-module-installer

Install node modules for atom-shell applications. This is needed because
atom-shell uses a custom version of node.js which native node modules need to be
compiled against.

## Installing

```sh
npm install atom-node-module-installer
```

## Usage

```javascript
installNodeModules = require('atom-node-module-installer')
installNodeModules(atomShellVersion, npmCachePath, appPath, [options])
```

**atomShellVersion**: A string containing the atom-shell to compile against (example: '0.16.2') versions can be found https://github.com/atom/atom-shell/releases

**npmCachePath**: A string containing the path of a atom-shell specific npm cache (example: './.atom-npm')

**appPath**: A string containing the path where the atom-shell application is located.

**options**: An optional object containing a `debug` key. Used if a debug version of a native module is needed.

## Development

There are not tests ¯\_(ツ)_/¯
To build publish the module run the default `gulp` command.
