/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.js'
import Router from 'vue-router'
import App from '../App'
import router from '../router'

Vue.use(Router)
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  router,
  template: '<App/>',
  components: { App }
}).$mount('App')

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
