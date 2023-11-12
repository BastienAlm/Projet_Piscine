<template>
    <Bar
      id="my-chart-id"
      :options="chartOptions"
      :data="chartData"
    />
  </template>
  
  <script>
  import axios from 'axios'
  import moment from 'moment';
  import { Bar } from 'vue-chartjs'
  import { getLabel, dataItems, workingTimes, dateFormat,getDayName} from '../event-utils'
  import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'
import { createRef } from '@fullcalendar/core/preact';
  
  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
  
  export default {
    name: 'BarChart',
    components: { Bar },
    data() {
      return {
        chartOptions: {
          responsive: true
        },
        labels : [],
        items : []
      }
    },
    methods:{
      getMonth(datetime) {
        const date = new Date(datetime); // Replace this with your actual date object
        const month = date.getMonth();
        const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        this.labels.push(monthNames[month])
        return monthNames[month];
      },
      getMinute(datetime) {
        const date = new Date(datetime); // Replace this with your actual date object
        const minute = date.getMinutes();
        return minute;
      },
      dateFormat(date) {
        return moment(date).format('MM/DD/YYYY hh:mm');
      },
      async getDatas(){
        const value = await workingTimes();
        let datas = value.data.data.map((rep) => rep.start);
        let dataEnd = value.data.data.map((rep) => rep.end);
        const date = datas.map((rep) => new Date(rep)) 
        const date2 = dataEnd.map((rep) => new Date(rep))
        let dateFinal = date2.map((rep, index) => rep.getHours() - date[index].getHours());
        console.log({dateFinal});     
        const month = date.map((rep) => rep.getMonth());
        const minutes = date.map((rep) => rep.getMinutes());
        const heures = date.map((rep) => rep.getHours());
        const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        this.labels = month.map((rep, index) => monthNames[rep])
        console.log(this.labels)
        this.items = dateFinal
        console.log({heures});
      }
    },
    computed:{
      chartData(){
        this.getDatas();
        const final = {
          labels: [],
          datasets: [ 
          {
            data: [],
            label: 'WorkingTimes'
          }
          ]
        }
        final.labels = this.labels;
        final.datasets[0].data = this.items;
        console.log({final});
        return final;
      }
      
    },
     
    
  }
  </script>