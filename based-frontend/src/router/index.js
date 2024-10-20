// router/index.js
import { createRouter, createWebHistory } from "vue-router";
import Home from "../components/Home.vue";
import About from "../components/About.vue";
import BASEDHome from "../components/BASEDHome.vue";
import AccentClassifier from "../components/AccentClassifier.vue";

const routes = [
  { path: "/", component: Home },
  { path: "/about", component: About },
  { path: "/BASEDHome", component: BASEDHome },
  { path: "/AccentClassifier", component: AccentClassifier}
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
