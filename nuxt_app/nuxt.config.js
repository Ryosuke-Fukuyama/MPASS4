export default {
  server: {
    port: 8080
  },

  head: {
    title: 'nuxt_app',
    htmlAttrs: {
      lang: 'en'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  css: [
  ],

  plugins: [
  ],

  components: true,

  buildModules: [
  ],

  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/proxy',
  ],

  axios: {
    baseURL: '/',
  },

  proxy: {
    '/': {
      target: 'http://localhost:3000/',
      // pathRewrite: {'^/api/': ''}
    }
  },

  env: {
  },

  build: {
  }
}
