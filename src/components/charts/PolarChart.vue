<template>
  <PolarArea :data="data" :options="options" />
</template>

<script>
import {
  Chart as ChartJS,
  RadialLinearScale,
  ArcElement,
  Tooltip,
  Legend
} from 'chart.js';
import { PolarArea } from 'vue-chartjs';
import * as config from '../event-utils'
ChartJS.register(RadialLinearScale, ArcElement, Tooltip, Legend);
export default {
  name: 'PolarChart',
  components: {
    PolarArea
  },
  data() {
    return {
      options: {
          responsive: true
      }, 
      labels: [],
      minutes: []
    }
  },
  methods:{
    async getData(){
      const value = await config.workingTimes();
      let datas = value.data.data.map((rep) => rep.start);
      const date = datas.map((rep) => new Date(rep));   
      this.labels = date.map((rep) => config.getMonth(rep)).filter((value, index, self) => self.indexOf(value) === index);
      //this.minutes = date.getMonth().filter((value, index, self) => self.indexOf(value) === index).date.map(item => item * array.filter(val => val === item).length);
      this.minutes = date.filter((value, index, self) => self.findIndex(date => date.getMonth() === value.getMonth()) === index)
        .map((date, index, self) => {
          const count = self.filter(d => d.getMonth() === date.getMonth()).length;
          date.setMinutes(date.getMinutes() + count);
          console.log({date});
          return date;
        });

        console.log(this.minutes);
    }
  },
  computed:{
    data(){
      this.getData()
      const data = {
        labels: [],
        datasets: [
            {
            label: 'My First dataset',
             backgroundColor: 'rgba(179,181,198,0.2)',
            data: [65, 59, 90, 81, 56, 55, 40]
            },
            {
            label: 'My Second dataset',
            backgroundColor: 'rgba(255,99,132,0.2)',
            data: [28, 48, 40, 19, 96, 27, 100]
            }
        ]
      }

      data.labels = this.labels
      for (let index = 0; index < this.labels.length; index++) {
        data.datasets[index].label = this.labels[index]
        data.datasets[index].data = this.minutes.map((rep) => config.getMinute(rep))
        
      }
      return data;
    }
  }
}
</script>

<style>

</style>