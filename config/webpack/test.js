const environment = require('./environment')
const preactCompat = require('./preact-compat')
const merge = require('webpack-merge')

module.exports = merge(environment.toWebpackConfig(), preactCompat);
