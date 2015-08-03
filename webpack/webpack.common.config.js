// Common webpack configuration used by webpack.hot.config and webpack.rails.config.

const path = require('path');

module.exports = {
  // turn to false if not on home network
  home: false,

  // the project dir
  context: __dirname,
  entry: [
    './assets/javascripts/app.cjsx',
    './assets/stylesheets/app.scss'
  ],

  // plugins: [
  //   new webpack.ProvidePlugin({
  //     'fetch': 'imports?this=>global!exports?global.fetch!./assets/javascripts/fetch',
  //   })
  // ],

  // In case you wanted to load jQuery from the CDN, this is how you would do it:
  // externals: {
  //   jquery: 'var jQuery'
  // },
  resolve: {
    root: [path.join(__dirname, 'scripts'),
           path.join(__dirname, 'assets/javascripts'),
           path.join(__dirname, 'assets/stylesheets')],
    extensions: ['', '.webpack.js', '.web.js', '.js', '.jsx', '.scss', '.css', 'config.js', '.cjsx', '.coffee'],
    alias: {
      // 'fetch': path.join(NPM, 'whatwg-fetch', 'fetch.js')
    }
  },
  module: {
    loaders: []
  }
};
