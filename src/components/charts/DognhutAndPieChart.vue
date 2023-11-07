<template>
   <Doughnut :data="data" :options="options" />
</template>

<script>
import { Doughnut } from 'vue-chartjs';
import * as config from '../event-utils'
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
ChartJS.register(ArcElement, Tooltip, Legend)
export default {
  name: 'DognhutAndPieChart',
  components: {
    Doughnut
  },
  data() {
      return {
      options: {
        responsive: true,
      },
      labels : [],
      minutes : [],
      colors : []
    }
  },
  methods:{
    async getData(){
      const value = await config.workingTimes();
      let datas = value.data.data.map((rep) => rep.start);
      const date = datas.map((rep) => new Date(rep))      
      this.labels = date.map((rep) => config.getMonth(rep));
      this.minutes = date.map((rep) => config.getMinute(rep))
      this.colors = date.map((rep) => this.generateRandomColor())
      // console.log(this.labels);
    },
    generateRandomColor(){
      return  '#'+(Math.random()*0xFFFFFF<<0).toString(16);
    }
  },
  computed:{
    data(){
      this.getData();
      const data = {
        labels: [],
        datasets: [
          {
          backgroundColor: ['#41B883', '#E46651', '#00D8FF', '#DD1B16','#53e482', '#8dcc1d'],
          data: []
          }
        ]
      }
      data.labels = this.labels
      data.datasets[0].data = this.minutes
      return data;
    }
  }
}
</script>

<style>

</style>