import axios from 'axios'
import router from '../../router'
import { AUTH_REQUEST, AUTH_ERROR, AUTH_SUCCESS, AUTH_LOGOUT } from '../actions/auth'
import { USER_REQUEST } from '../actions/user'

const state = {
  token: localStorage.getItem('user-token') || '',
  status: '',
}

const getters = {
  isAuthenticated: state => !!state.token,
  authStatus: state => state.status,
}

const mutations = {
  [AUTH_REQUEST]: (state) => {
    state.status = 'loading'
  },
  [AUTH_SUCCESS]: (state, token) => {
    state.status = 'success'
    state.token = token
  },
  [AUTH_ERROR]: (state) => {
    state.status = 'error'
  },
  [AUTH_LOGOUT]: (state) => {
    state.token = ''
  }
}

const actions = {
  [AUTH_REQUEST]: ({commit, dispatch}, payload) => {
    return new Promise((resolve, reject) => {
      commit(AUTH_REQUEST)
      axios({ url: `/api/${payload.url}.json`, data: { user: payload.user }, method: 'POST' })
        .then(res => {
          const token = res.data.token
          localStorage.setItem('user-token', token)
          commit(AUTH_SUCCESS, token)
          dispatch(USER_REQUEST)
          resolve(res)
        })
        .catch(err => {
          commit(AUTH_ERROR, err)
          localStorage.removeItem('user-token')
          reject(err)
        })
    })
  },
  [AUTH_LOGOUT]: ({commit, dispatch}) => {
    return new Promise((resolve, reject) => {
      axios({ url: '/api/sign_out.json', method: 'DELETE' })
        .then(res => {
          localStorage.removeItem('user-token')
          commit(AUTH_LOGOUT)
          router.push('/')
          resolve(res)
        })
        .catch(err => {
          reject(err)
        })
    })
  }
}

export default { state, getters, mutations, actions }
