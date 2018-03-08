import axios from 'axios'
import { USER_REQUEST, USER_ERROR, USER_SUCCESS } from '../actions/user'
import { AUTH_LOGOUT } from '../actions/auth'

const state = {
  profile: {},
  status: '',
}

const getters = {
  currentUser: state => state.profile,
  isProfileLoaded: state => !!state.profile.id,
  isAdmin: state => _.includes([1,2,69,70], state.profile.id)
}

const mutations = {
  [USER_REQUEST]: (state) => {
    state.status = 'loading'
  },
  [USER_SUCCESS]: (state, profile) => {
    state.status = 'success'
    state.profile = profile
  },
  [USER_ERROR]: (state) => {
    state.status = 'error'
  },
  [AUTH_LOGOUT]: (state) => {
    state.profile = {}
  }
}

const actions = {
  [USER_REQUEST]: ({commit, dispatch}) => {
    return new Promise((resolve, reject) => {
      commit(USER_REQUEST)
      axios({ url: `/api/me.json` })
        .then(res => {
          const profile = res.data.profile
          commit(USER_SUCCESS, profile)
          resolve(res)
        })
        .catch(err => {
          commit(USER_ERROR)
          // if resp is unauthorized, logout, to
          dispatch(AUTH_LOGOUT)
          reject(err)
        })
    })
  },
}

export default { state, getters, mutations, actions }
