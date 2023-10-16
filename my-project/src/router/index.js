import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";

const routes = [
  // {
  //   path: "/",
  //   name: "home",
  //   component: HomeView,
  // },
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/about",
    name: "about",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/AboutView.vue"),
  },
  {
    path: "/detail/:id",
    name: "detailproduct",
    component: () => import("../components/DetailProduct.vue"),
  },
  {
    path: "/cart",
    name: "cartPage",
    component: () => import("../components/Cart.vue"),
  },
// {
//     path: "/search/:search",
//     name: "searchProduct",
//     component: () => import("../components/Search.vue"),
//   },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
