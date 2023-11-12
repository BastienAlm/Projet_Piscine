import { createRouter, createWebHistory } from "vue-router";
import { isAuthenticated } from "./_helpers/auth-gard";
import user from "./components/user.vue";
import WorkingTimes from "./components/WorkingTimes.vue";
import WorkingTime from "./components/WorkingTime.vue";
import Clock from "./components/ClockManager.vue";
import ChartManager from "./components/ChartManager.vue";
import Barchart from "./components/charts/BarChart.vue";
import LineChart from "./components/charts/LineChart.vue";
import BubbleChart from "./components/charts/BubbleChart.vue";
import RadarChart from "./components/charts/RadarChart.vue";
import PolarChart from "./components/charts/PolarChart.vue";
import DoughnutChart from "./components/charts/DognhutAndPieChart.vue";

const routes = [
    {
        path: '/workingTimes/:userId',
        meta: {layout: user},
        name: 'workingTimesCreation',
        component: WorkingTimes
    },
    {
        path: '/workingTime/:userid',
        meta: {layout: user},
        name: 'workingTimeCreation',
        component: WorkingTime
    },
    {
        path: '/workingTime/:userid/:workingtimeid',
        meta: {layout: user},
        name: 'workingTime',
        component: WorkingTime
    },
    {
        path: '/clock/:username',
        meta: {layout: user},
        name: 'clock',
        component: Clock
    },
    {
        path: '/chartManager/:userid',
        meta: {layout: user},
        name: 'chartManager',
        component: ChartManager,
        children: [
            {
                path: '',
                name: "BarChart",
                component: Barchart,

            },
            {
                path: "bubble",
                name: "BubbleChart",
                component: BubbleChart,
            },
            {
                path: "dognhut",
                name: "DogNhutChart",
                component: DoughnutChart,
            },
            {
                path: "line",
                name: "LineChart",
                component: LineChart,
            },
            {
                path: "polar",
                name: "PolarChart",
                component: PolarChart,
            },
            {
                path: "radar",
                name: "RadarChart",
                component: RadarChart,
            }

            
        ],
    },
    {
        path: '/login',
        name: 'Login',
        component: () => import('./components/Login.vue')
    }
]


const router = createRouter({
    history: createWebHistory(''),
    routes,
});

// Vérouillage de la partie admin (token)
// router.beforeEach((to) => {
//    console.log(to.matched[0].name);
//    if (
//     // make sure the user is authenticated
//     !isAuthenticated() 
//   ) {
//     // redirect the user to the login page
//     return { name: 'Login' }
// }});

router.beforeEach((to, from, next) => {
  const publicPages = ['/login'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('token');
  // trying to access a restricted page + not logged in
  // redirect to login page
  if (authRequired && !loggedIn) {
    next('/login');
  } else {
    next();
  }
});
  
export default router;