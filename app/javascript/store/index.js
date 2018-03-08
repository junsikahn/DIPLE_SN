import Vue from 'vue'
import Vuex from 'vuex'
import auth from './modules/auth.js'
import user from './modules/user.js'
Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    auth,
    user,
  },
  strict: debug
})
