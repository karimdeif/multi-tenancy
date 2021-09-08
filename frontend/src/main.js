import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false

import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
import store from './store'
import router from './router';



//import { MwcTopAppBarFixed } from 'vue-material/dist/components'
//Vue.use(MwcTopAppBarFixed)


//import { MdButton } from 'vue-material/dist/components'
//Vue.use(MdButton)

Vue.use(VueMaterial)

new Vue({
  store,
  router,
  render: h => h(App)
}).$mount('#app')


export { default as Messaging } from "./messaging.js";
