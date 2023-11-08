import { createApp } from 'vue'
import App from './App.vue'
import router from "./router";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import { FontAwesomeIcon } from './plugin/font-awesome';
import store from "./store";

createApp(App).use(router).use(store).component("font-awesome-icon", FontAwesomeIcon).mount('#app')
