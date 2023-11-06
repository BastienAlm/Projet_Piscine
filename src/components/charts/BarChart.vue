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
  import { labels, data } from '../event-utils'
  import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'
  
  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
  
  export default {
    name: 'BarChart',
    components: { Bar },
    data() {
      return {
        chartData: {
          labels: labels,
          datasets: [ 
            { data: data,
                label: 'WorkingTimes'
            }]
        },
        chartOptions: {
          responsive: true
        },
      }
    },
    methods:{
      getWorkingTimes(){
      console.log(this.$route.params.userid );
      axios.get(`http://localhost:4000/api/workingtimes/${this.$route.params.userid}`)
      .then((response) => {
        console.log(response.data.data);
        console.log(this.dateFormat(response.data.data[0].end));
        for(let i = 0; i < response.data.data.length; i++){
          // console.log(this.getMonthName(response.data.data[i].end));
          // const test = this.dateFormat(response.data.data[i].end);
          // this.labels.push(this.getMonth(test))
          response.data.data[i].start = this.dateFormat(response.data.data[i].start);
          //this.workingsTable.push(response.data.data[i]);
        }
        // console.log(this.labels);
        //console.log(this.workingsTable);
        // this.workingsTable.push(response.data.data);
      }).catch((error) => {
        console.log(error);
      });
      },
      getMonth(datetime) {
        const date = new Date(datetime); // Replace this with your actual date object
        const month = date.getMonth();
        const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        this.labels.push(monthNames[month])
        return monthNames[month];
      },
      dateFormat(date) {
        return moment(date).format('MM/DD/YYYY hh:mm');
      },
    },
    created(){
      console.log(labels);
    }
    
  }
  </script>