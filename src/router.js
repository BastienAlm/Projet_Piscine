import { createRouter, createWebHistory } from "vue-router";

const routes = [
    {
        path: '/workingTimes/:userId',
        name: 'workingTimesCreation',
        component: () => import('./components/WorkingTimes.vue')
    },
    {
        path: '/workingTime/:userid',
        name: 'workingTimeCreation',
        component: () => import('./components/WorkingTime.vue')
    },
    {
        path: '/workingTime/:userid/:workingtimeid',
        name: 'workingTime',
        component: () => import('./components/WorkingTime.vue')
    },
    {
        path: '/clock/:username',
        name: 'clock',
        component: () => import('./components/ClockManager.vue')
    },
    {
        path: '/chartManager/:userid',
        name: 'chartManager',
        component: () => import('./components/ChartManager.vue'),
        children: [
            // {
            //     path: '', // Route vide pour la redirection par défaut
            //     redirect: '/merchants/list', // Rediriger par défaut vers la route "list"
            //   },
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
            },
            
        ],
    }
]


const router = createRouter({
    history: createWebHistory(''),
    routes,
});

// Vérouillage de la partie admin (token)
router.beforeEach((to) => {
    // if(to.matched[0].name == 'admin'){
    //   authGuard()
    // }
    return true;
})
  
export default router;