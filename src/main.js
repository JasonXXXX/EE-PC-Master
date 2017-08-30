// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-default/index.css'
import Icon from 'vue-awesome/components/Icon'

import App from './App'
import router from './router'
import store from './store'
import common from './common'

Vue.use(ElementUI)
Vue.component('icon', Icon)
Vue.config.productionTip = false
Vue.prototype.$common = common

new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>',
  render: h => h(App)
})
