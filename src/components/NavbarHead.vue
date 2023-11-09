<template>
    <div class="nav">
        <router-link to="/workingTimes/1">WorkingTimes</router-link>
        <router-link to="/workingTime/1/1">WorkingTime</router-link>
        <router-link to="/chartManager/1">chart</router-link>
    </div>
</template>
<script>
export default {
    name: 'Navbar'
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