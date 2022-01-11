import BootstrapVue from 'bootstrap-vue';
import VueApexCharts from 'vue-apexcharts';
import Vue from 'vue';
import App from './App.vue';
import router from './router';
import 'bootstrap/dist/css/bootstrap.css';

Vue.use(VueApexCharts);

Vue.component('apexchart', VueApexCharts);

Vue.use(BootstrapVue);

Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
