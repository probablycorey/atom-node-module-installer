# atom-node-module-installer

Install node modules for atom-shell applications. This is needed because native
node modules used by atom-shell need to be compiled against a forked version of
[node.js](https://github.com/atom/node).

## Installing

```sh
npm install atom-node-module-installer
```

## Usage

```javascript
installNodeModules = require('atom-node-module-installer')
installNodeModules(appPath, atomShellVersion, npmCachePath, [options])
```

Returns: an ES6 Promise.

**appPath**: A string containing the path where the atom-shell application is
located.

**atomShellVersion**: A string containing the atom-shell version to compile
against (example: '0.16.2') versions can be found https://github.com/atom/atom-shell/releases

**npmCachePath**: A string containing a path to store an atom-shell specific
npm cache (example: './.atom-npm')

**options**:

  * `debug`: A Boolean that will build the debug version of node modules.
  * `vebose`: A Boolean that will display npm's stdout and stderr

## Development

There are no tests... ¯\_(ツ)_/¯

To build publish the module run the default `gulp` command.
