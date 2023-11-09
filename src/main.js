import { createApp } from 'vue'
import App from './App.vue'
import router from "./router";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import { FontAwesomeIcon } from './plugin/font-awesome';
import store from "./store";
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';


createApp(App).use(router).use(store).use(VueSweetalert2).component("font-awesome-icon", FontAwesomeIcon).mount('#app')
