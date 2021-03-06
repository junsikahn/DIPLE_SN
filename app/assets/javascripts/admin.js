// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery_nested_form
//= require axios
//= require underscore
//= require vue
//= require vue-router
//= require vue-resource
//= require vuex
//= require turbolinks
//= require popper.min
//= require bootstrap.min
//= require bowser
//= require validator
//= require summernote
//= require summernote-ko-KR
//= require katex
//= require katex/contrib/auto-render.min
//= require jquery.highlight
//= require chartjs
//= require noty
//= require KeyboardJS
//= require FileAPI
//= require sortablejs
//= require local_time_ko
//= require vex
//= require_tree ./admin

// init underscore.js Template
_.templateSettings = {
  interpolate: /\{\{\=(.+?)\}\}/g,
  evaluate: /\{\{(.+?)\}\}/g
};

// summernote 기본 설정
$.extend(true, $.summernote, {
  dom: {
    emptyPara: '<div><br></div>'
  },
  options: {
    lang: 'ko-KR',
    styleTags: ['div', 'blockquote', 'pre', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']
  }
});

// vex 기본 설정
$.extend(true, vex.defaultOptions, {
  className: 'vex-theme-default',
  overlayClosesOnClick: false,
});

// Simple Vue Validator 등록
Vue.use(SimpleVueValidator);
var Validator = SimpleVueValidator.Validator;
