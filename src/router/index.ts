import { createRouter, createWebHistory } from '@ionic/vue-router';
import { RouteRecordRaw } from 'vue-router';
import Onboarding from '../views/onboarding.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/onboarding',
    name: 'onboarding',
    component: Onboarding,
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
