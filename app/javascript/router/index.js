import Vue from 'vue'
import Router from 'vue-router'
import Index from '../components/Index'
import Problems from '../components/Problems'

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index
    },
    {
      path: '/problems',
      name: 'Problems',
      component: Problems
    }
  ]
})
