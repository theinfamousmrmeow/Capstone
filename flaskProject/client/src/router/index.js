import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../views/Home.vue';
import Books from '../components/Books.vue';
import Ping from '../components/Ping.vue';
import Brains from '../components/Brains.vue';
import Sessions from '../components/Sessions.vue';
import Chart1 from '../components/Chart1.vue';
import Chart2 from '../components/Chart2.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/ping',
    name: 'Ping',
    component: Ping,
  },
  {
    path: '/sessions',
    name: 'Sessions',
    component: Sessions,
  },
  {
    path: '/chart1',
    name: 'Chart 1',
    component: Chart1,
  },
  {
    path: '/chart2',
    name: 'Chart 2',
    component: Chart2,
  },
  {
    path: '/books',
    name: 'Books',
    component: Books,
  },
  {
    path: '/brains',
    name: 'Brains CRUD',
    component: Brains,
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
