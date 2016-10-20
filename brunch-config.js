module.exports = {
  paths: {
    watched: [process.env.npm_package_config_src], // read from package.json config
    public: process.env.npm_package_config_dist // read from package.json config
  },
  modules: {
    definition: false,
    wrapper: false
  },
  files: {
    javascripts: {
      joinTo: {
        'index.js': /^src/
      }
    }
  },
  npm: {
    enabled: false
  },
  plugins: {
    coffeescript: {
      bare: true
    }
  }
};

