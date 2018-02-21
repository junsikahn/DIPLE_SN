const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

const config = require('@rails/webpacker/package/config')
const ManifestPlugin = require('webpack-manifest-plugin')
environment.plugins.append('Manifest', new ManifestPlugin({
  publicPath: config.publicPath,
  writeToFileEmit: true,
  filter: f => {
    f.name = f.name.replace(/\\/g, '/')
    f.path = f.path.replace(/\\/g, '/')
    return f
  }
}))

environment.loaders.append('vue', vue)
module.exports = environment
