import { createRouter, createWebHistory } from "vue-router";
import { isAuthenticated } from "./_helpers/auth-gard";
import user from "./components/user.vue"

const routes = [
    {
        path: '/workingTimes/:userId',
        meta: {layout: user},
        name: 'workingTimesCreation',
        component: () => import('./components/WorkingTimes.vue')
    },
    {
        path: '/workingTime/:userid',
        meta: {layout: user},
        name: 'workingTimeCreation',
        component: () => import('./components/WorkingTime.vue')
    },
    {
        path: '/workingTime/:userid/:workingtimeid',
        meta: {layout: user},
        name: 'workingTime',
        component: () => import('./components/WorkingTime.vue')
    },
    {
        path: '/clock/:username',
        meta: {layout: user},
        name: 'clock',
        component: () => import('./components/ClockManager.vue')
    },
    {
        path: '/chartManager/:userid',
        meta: {layout: user},
        name: 'chartManager',
        component: () => import('./components/ChartManager.vue'),
        children: [
            {
                path: '',
                name: "BarChart",
                component: () => import("./components/charts/BarChart.vue"),

            },
            {
                path: "bubble",
                name: "BubbleChart",
                component: () => import("./components/charts/BubbleChart.vue"),
            },
            {
                path: "dognhut",
                name: "DogNhutChart",
                component: () => import("./components/charts/DognhutAndPieChart.vue"),
            },
            {
                path: "line",
                name: "LineChart",
                component: () => import("./components/charts/LineChart.vue"),
            },
            {
                path: "polar",
                name: "PolarChart",
                component: () => import("./components/charts/PolarChart.vue"),
            },
            {
                path: "radar",
                name: "RadarChart",
                component: () => import("./components/charts/RadarChart.vue"),
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
  const loggedIn = localStorage.getItem('user');
  next();
  // trying to access a restricted page + not logged in
  // redirect to login page
//   if (authRequired && !loggedIn) {
//     next('/login');
//   } else {
//     next();
//   }
});
  
export default router;