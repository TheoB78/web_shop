import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/:pathMatch(.*)*',
      redirect: '/products'
    },
    {
      path: '/products',
      name: 'products',
      component: () => import('../views/ProductsView.vue')
    },
    {
      path: '/product/:id',
      component: () => import('../views/SingleProductView.vue')
    },
    {
      path: '/cart',
      component: () => import('../views/CartView.vue')
    },
    {
      path: '/statistics',
      component: () => import('../views/StatisticsView.vue')
    }
  ]
})

export default router
