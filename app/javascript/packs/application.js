import Vue from 'vue'
import 'babel-polyfill'

// Vuex
import store from '../store'

// Vue Router
import router from '../router'

// Axios & Vue Axios
import VueAxios from 'vue-axios'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
Vue.use(VueAxios, axios)

// Vuefity
import 'vuetify/dist/vuetify.min.css'
import Vuetify from 'vuetify'
Vue.use(Vuetify)

// Bootstrap
// import 'expose-loader?$!expose-loader?jQuery!jquery'
// import 'bootstrap'
// import 'bootstrap/dist/css/bootstrap.min.css'
// import BootstrapVue from 'bootstrap-vue'
// Vue.use(BootstrapVue)

import App from '../App'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    router,
    store,
    render: h => h(App)
  }).$mount('App')
})

// $(document).on('turbolinks:load', function() {
//   var err_vue = new Vue({
//     data: { msgs: [] },
//     watch: {
//       msgs: function(msgs) {
//         _.each(msgs, function(msg, index) {
//           $('body').highlight('$' + msg + '$', { element: 'mark', className: 'bg-danger text-light' });
//         });
//         new Noty({
//           type: 'error',
//           text: '<div class="text-center pr-2"><i class="fa fa-exclamation-triangle"></i> 현재 페이지에 <b>' + msgs.length + '개</b>의 수식 에러가 있습니다</div>',
//           layout: 'bottomRight',
//           closeWith: ['click', 'button'],
//           timeout: 5000,
//           progressBar: true,
//           animation: {
//             open: 'noty_effects_open',
//             close: 'noty_effects_close'
//           }
//         }).show();
//       }
//     }
//   });
//
//   renderMathInElement(document.body, {
//     delimiters: [ { left: "$",  right: "$",  display: false } ],
//     errorCallback: function(msg, err) {
//       err_vue.msgs.push(msg.split('`')[1]);
//       // console.error(err);
//     }
//   });
// });
