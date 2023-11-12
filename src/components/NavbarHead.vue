<template>
    <div class="nav">
        <router-link v-for="page in currentRouteName" :key="page.id" :to=page.path>{{page.name}}</router-link>
        <router-link @click="logout" to="#">Logout</router-link>
    </div>
</template>
<script>
export default {
    name: 'Navbar',
    methods: {
        logout(){
            localStorage.removeItem('token');
        }
    },
    computed: {
        currentRouteName() {
            const storage = JSON.parse(localStorage.getItem('token'));
            const generalManagerPages = [
                {
                    id: 1,
                    name: 'workingtimes',
                    path: '/workingTimes/1',
                },
                {
                    id: 2,
                    name: 'workingtime',
                    path: '/workingTime/1/1',
                },
                {
                    id: 3,
                    name: 'chartManager',
                    path: '/chartManager/1',
                }
            ];
            const managerPages = [
                {
                    id: 1,
                    name: 'workingtimes',
                    path: '/workingTimes/1',
                },
                {
                    id: 2,
                    name: 'workingtime',
                    path: '/workingTime/1/1',
                },
                {
                    id: 3,
                    name: 'chart',
                    path: '/chartManager/1',
                }
            ];
            const userPages = [
                {
                    id: 1,
                    name: 'user',
                    path: '/user',
                },
                {
                    id: 2,
                    name: 'test',
                    path: '/test',
                }
            ];
            switch (storage.user_role) {
                case "user":
                    return userPages;
                    break;
                case "manager":
                    return managerPages;
                    break;
                case "general-manager":
                    return generalManagerPages;
                    break;
                default:
                    break;
            }
        },

    }   
}
</script>
<style>
.nav{
    display: flex;
    background-color: #333;
    overflow: hidden;
    margin-bottom: 15px;
    justify-content: space-around;
}
.nav a {
    float: left;
    color: lightblue;
    padding: 14px 16px;
    text-align: center;
    font-size: 15px;
    text-decoration: none;
}
.nav a:hover{
    background-color: lightblue;
    color: #333
}

a.router-link-active {
    color: #000 !important;
    text-transform: uppercase;
    font-weight: bold;
    background-color: lightblue;
}

a.router-link-exact-active{
    color: #000 !important;
    text-transform: uppercase;
    font-weight: bold;
    background-color: lightblue;
}
</style>