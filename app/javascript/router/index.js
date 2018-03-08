import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

import store from '../store'
const isAdmin = (to, from, next) => {
  if (!store.getters.isAuthenticated) {
    alert('로그인해주세요')
    next('/')
  } else {
    store.dispatch('USER_REQUEST').then(res => {
      if (store.getters.isAdmin) {
        next()
        return
      }
      alert('접근 권한이 없습니다')
      next('/')
    })
  }
}

const routes = [
  // {
  //   path: '/admin',
  //   name: 'AdminHome',
  //   component: () => import(`../components/layout/Admin.vue`),
  //   beforeEnter: isAdmin,
  //   children: [
  //     {
  //       path: '/admin/problems',
  //       name: 'AdminProblems',
  //       component: () => import(`../components/Problems.vue`),
  //     },
  //     {
  //       path: '/admin/problem_sources',
  //       name: 'AdminProblemSources',
  //       component: () => import(`../components/admin/ProblemSources.vue`)
  //     }
  //   ]
  // },
  {
    path: '/',
    component: () => import(`../components/layout/App.vue`),
    redirect: { name: 'Home' },
    children: [
      {
        path: '/home',
        name: 'Home',
        component: () => import(`../components/app/Home.vue`),
      },
      {
        path: '/problems',
        name: 'Problems',
        component: () => import(`../components/Problems.vue`),
      }
    ]
  },
  { path: '/*', component: () => import(`../components/etc/NotFound.vue`) }
]

export default new Router({
 mode: 'history',
 routes
})
