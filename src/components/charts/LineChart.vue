<template>
  <Line :data="data" :options="options" />
</template>

<script>
import * as config from '../event-utils'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js';
import { Line } from 'vue-chartjs';
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);
export default {
  name: 'LineChart',
  components: {
    Line
  },
  methods:{
    async getData(){
      const value = await config.workingTimes();
      let datas = value.data.data.map((rep) => rep.start);
      let datasEnd = value.data.data.map((rep) => rep.end);
      const date = datas.map((rep) => new Date(rep))
      const date2 = datasEnd.map((rep) => new Date(rep))
      let dateFinal = date2.map((rep, index) => rep.getHours() - date[index].getHours());      
      this.labels = date.map((rep) => config.getMonth(rep));
      // this.minutes = date.map((rep) => config.getHour(rep))
      this.minutes = dateFinal
    }
  },
  computed:{
    data(){
      this.getData()
      const data = {
        labels: [],
        datasets: [
        {
        label: 'Working Time',
        backgroundColor: '#f87979',
        data: []
        }]
      }
      data.labels = this.labels
      data.datasets[0].data = this.minutes
      return data;
    }
  },
  data() {
    return {
      options: {
        responsive: true,
      },
      labels: [],
      minutes : []
    }
  }

}
</script>

<style>

</style>