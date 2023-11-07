<template>
    <div>
        <h1>Chart Manager</h1>
        <ul class="container">     
            <li><router-link to='/chartManager/1'>Bar</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/:userid/bubble'>Bubble</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/:userid/dognhut'>Dognhut</router-link></li>
            <li>&nbsp;</li>
            <li><router-link to='/chartManager/:userid/line'>Line</router-link></li>
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
  color: #42b983;
}
  

</style>