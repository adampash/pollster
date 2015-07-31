// Run like this:
// cd client && node server.js

const path = require('path');
const config = require('./webpack.common.config');
const webpack = require('webpack');

if (config.home) {
  url = "http://192.168.1.212"
} else {
  url = "http://localhost"
}

config.entry.push('webpack-dev-server/client?' + url + ':3000',
  'webpack/hot/dev-server');
config.output = {

  // this file is served directly by webpack
  filename: 'client-bundle.self.js',
  path: __dirname,
  publicPath: url + ':3000/assets/components'
};
config.plugins = [
  new webpack.HotModuleReplacementPlugin()
];
config.devtool = 'eval-source-map';

// All the styling loaders only apply to hot-reload, not rails
config.module.loaders.push(
      {
        test: /\.scss$/,
        loader: "style!css?sourceMap!autoprefixer-loader!ruby-sass"
      }, // loaders: ['style', 'css', 'sass', 'autoprefixer']},
      { test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx']},
      { test: /\.coffee$/, loader: 'coffee' }
)

module.exports = config;
