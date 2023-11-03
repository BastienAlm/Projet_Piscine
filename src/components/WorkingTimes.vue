<template>
  <div>
    <h1 @click="getWorkingTimes">Working Times</h1>
    <div v-for="(working, index) in workingsTable" :key="index" class="first">
      <div class="second">
        <div class="third">
          <div class="month">
             {{ getMonth(working.end) }}
          </div>
          <div class="monthNumber">
            <span class="monthText">
              {{ getDay(working.end) }}
              </span>
          </div>
          <div class="day">
            <span class="textsm">
              {{ getDayName(working.end) }}
            </span>
          </div>
          <div class="hour ">
            <span class="hourtext">
                    {{ getHour(working.start) }}:{{ getMinute(working.start) }} - {{ getHour(working.end) }}:{{ getMinute(working.end) }}
                  </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
export default {
  name: 'WorkingTimes',
  data() {
    return {
      workingsTable: [],
    }
  },
  methods: {
    getWorkingTimes(){
      console.log(this.$route.params.userId );
      axios.get(`http://localhost:4000/api/workingtimes/${this.$route.params.userId}`)
      .then((response) => {
        console.log(response.data.data);
        console.log(this.dateFormat(response.data.data[0].end));
        for(let i = 0; i < response.data.data.length; i++){
          // console.log(this.getMonthName(response.data.data[i].end));
          response.data.data[i].end = this.dateFormat(response.data.data[i].end);
          response.data.data[i].start = this.dateFormat(response.data.data[i].start);
          this.workingsTable.push(response.data.data[i]);
        }
        console.log(this.workingsTable);
        // this.workingsTable.push(response.data.data);
      }).catch((error) => {
        console.log(error);
      });
    },
    dateFormat(date) {
      return moment(date).format('MM/DD/YYYY hh:mm');
    },
    getMonth(datetime) {
      const date = new Date(datetime); // Replace this with your actual date object
      const month = date.getMonth();
      const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      //return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear();
      return monthNames[month];
    },
    getDay(datetime) {
      const date = new Date(datetime); // Replace this with your actual date object
      const day = date.getDay();
      return day;
    },
    getDayName(datetime) {
      const date = new Date(datetime); // Replace this with your actual date object
      const day = date.getDay();
      const dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

      return dayNames[day];
    },
    getHour(datetime) {
      const date = new Date(datetime); // Replace this with your actual date object
      const hour = date.getHours();
      return hour;
    },
    getMinute(datetime) {
      const date = new Date(datetime); // Replace this with your actual date object
      const minute = date.getMinutes();
      return minute;
    }
  },
  computed: {
    formattedDate() {
      const date = new Date(this.workingsTable[0].end); // Replace this with your actual date object
      const month = date.getMonth();
      const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      //return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear();
      return monthNames[month];
    }
  },
  created() {
    this.getWorkingTimes();
  }
  
}
</script>

<style scoped>
.div { font-family: 'Courier New', Courier, monospace;
    
}

.first {
  padding: 0.75rem; 
  margin-bottom: 1rem; 
  font-weight: 500; 
  background-color: #ffffff; 
}

.second {
  flex: none; 
  border-top-left-radius: 0.25rem;
  border-top-right-radius: 0.25rem; 
  width: 8rem; 
  text-align: center; 
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05); 

  @media (min-width: 1024px) { 
  border-top-left-radius: 0;
  border-top-right-radius: 0; 
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem; 
 }
}

.third {
  display: block; 
  overflow: hidden; 
  border-top-left-radius: 0.25rem;
  border-top-right-radius: 0.25rem; 
  text-align: center; 
}

.month {
  padding-top: 0.25rem;
  padding-bottom: 0.25rem; 
  color: #ffffff; 
  background-color: #3B82F6; 
}

.monthNumber {
  padding-top: 0.25rem; 
  border-right-width: 1px; 
  border-left-width: 1px; 
  border-color: #ffffff; 
  background-color: #ffffff; 
}

.monthText {
  font-size: 3rem;
  line-height: 1; 
  font-weight: 700; 
  line-height: 1.25; 
}

.day {
  margin-bottom: -0.25rem; 
  border-bottom-right-radius: 0.5rem;
  border-bottom-left-radius: 0.5rem; 
  border-right-width: 1px; 
  border-bottom-width: 1px; 
  border-left-width: 1px; 
  border-color: #ffffff; 
  text-align: center; 
  background-color: #ffffff;
}

.textsm {
  font-size: 0.875rem;
  line-height: 1.25rem; 
}

.hour{
  padding-bottom: 0.5rem; 
  border-bottom-right-radius: 0.5rem;
  border-bottom-left-radius: 0.5rem; 
  border-right-width: 1px; 
  border-bottom-width: 1px; 
  border-left-width: 1px; 
  border-color: #ffffff; 
  text-align: center; 
  background-color: #ffffff; 
}

.hourtext {
  font-size: 0.75rem;
  line-height: 1rem; 
  line-height: 1.5;
}
</style>