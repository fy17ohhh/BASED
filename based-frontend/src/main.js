import { createApp } from "vue";
import App from "./App.vue";

import "./assets/fonts/fonts.css";
import router from "./router/index.js";
import ElementUI from "element-plus";
import "element-ui/lib/theme-chalk/index.css";

import { library } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { faEnvelope } from "@fortawesome/free-regular-svg-icons";
import { faLinkedin, faGithub } from "@fortawesome/free-brands-svg-icons";

library.add(faEnvelope, faLinkedin, faGithub);

createApp(App)
  .use(router)
  .use(ElementUI)
  .component("font-awesome-icon", FontAwesomeIcon)
  .mount("#app");
