<template>
    <div>
        <h1>Chart Manager</h1>
        <ul class="container">     
            <li><router-link to='/chartManager/1'>Bar</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/1/bubble'>Bubble</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/1/dognhut'>Dognhut</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/1/line'>Line</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/:userid/polar'>Polar</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/:userid/radar'>Radar</router-link></li>
        </ul>
        <!-- <BarChartVue/> -->
        <router-view></router-view>
    </div>
</template>

<script>
import BarChartVue from './charts/BarChart.vue';
export default {
    components:{
        BarChartVue
    }
}
</script>

<style scoped>
 ul{
    list-style: none;
}
ul li{
    text-align:center;
}

.container {
  display: flex;
  justify-content: center;
}

a.router-link-exact-active {
  color: #42b983 !important;
}

a.router-link-active  {
    /* color: unset !important;
    text-transform: unset;
    font-weight: unset;
    background-color: unset; */
}
  

</style>