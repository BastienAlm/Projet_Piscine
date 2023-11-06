<script>
import { defineComponent } from 'vue'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import { INITIAL_EVENTS, createEventId, workingTimes, workingsTable } from './event-utils'
import axios from 'axios'

export default defineComponent({
  components: {
    FullCalendar,
  },
  data() {
    return {
      calendarOptions: {
        plugins: [
          dayGridPlugin,
          timeGridPlugin,
          interactionPlugin // needed for dateClick
        ],
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        initialView: 'dayGridMonth',
        // initialEvents: INITIAL_EVENTS, // alternatively, use the `events` setting to fetch from a feed
        initialEvents: INITIAL_EVENTS,
        editable: true,
        selectable: true,
        selectMirror: true,
        dayMaxEvents: true,
        weekends: true,
        select: this.handleDateSelect,
        eventClick: this.handleEventClick,
        eventsSet: this.handleEvents
        /* you can update a remote database when these fire:
        eventAdd:
        eventChange:
        eventRemove:
        */
      },
      currentEvents: [],
      workingTimesObject:{
        workingtime:{

        }
      }

    }
  },
  methods: {
    handleWeekendsToggle() {
      this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
    },
    handleDateSelect(selectInfo) {
      let title = prompt('Please enter a new title for your working time')
      let calendarApi = selectInfo.view.calendar

      calendarApi.unselect() // clear date selection

      if (title) {
        this.createWorkingTime();
        calendarApi.addEvent({
          id: createEventId(),
          title,
          start: selectInfo.startStr,
          end: selectInfo.endStr,
          // allDay: selectInfo.allDay
        })
        this.$router.go();
      }
      
    },
    handleEventClick(clickInfo) {
      if (confirm(`Are you sure you want to delete the event '${clickInfo.event.title}'`)) {
        clickInfo.event.remove()
        this.removeWorkingTime(clickInfo.event.id)
        
      }
    },
    handleEvents(events) {
      this.currentEvents = events
    },
    createWorkingTime() {
      try {
        axios.post("http://localhost:4000/api/workingtimes/1", this.workingTimesObject)
        .then((response) => {
          
          alert("workingTimes created");
          workingTimes();
        }).catch(
          (error) =>
          alert("check fields and unique email"));
          //window.location.reload("500"));
          
      }
      catch (error) {
        console.log(error);
        alert("Error", error); 
      }
    },
    removeWorkingTime(id) {
      try {
        axios.post(`http://localhost:4000/api/workingtimes/${id}`)
        .then((response) => {
         
          alert("workingTimes deleted");
          workingTimes();
        }).catch(
          (error) =>
          alert("check id"));
          //window.location.reload("500"));
          
      }
      catch (error) {
        console.log(error);
        alert("Error", error); 
      }
    },

  },
  // mounted(){
  //   console.log(INITIAL_EVENTS);
  //   console.log(workingsTable);
  //   this.test = localStorage.getItem("workingtime");
  //   console.log(this.test);
  // },
  // created(){
  //   workingTimes();
  // },
  // updated(){
  //   workingTimes();
  // }
})

</script>

<template>
  <div class='demo-app'>
    <div class='demo-app-sidebar'>
      <div class='demo-app-sidebar-section'>
        <h2>Instructions</h2>
        <ul>
          <li>Select dates and you will be prompted to create a new clockTime</li>
          <li>Drag, drop, and resize worksTimes / clockTimes</li>
          <li>Click an workingTime to delete it</li>
        </ul>
      </div>
      <div class='demo-app-sidebar-section'>
        <label>
          <input
            type='checkbox'
            :checked='calendarOptions.weekends'
            @change='handleWeekendsToggle'
          />
          toggle weekends
        </label>
      </div>
      <div class='demo-app-sidebar-section'>
        <h2>All workingTimes ({{ currentEvents.length }})</h2>
        <ul>
          <li v-for='event in currentEvents' :key='event.id'>
            <b>{{ event.startStr }}</b>
            <i>{{ event.title }}</i>
          </li>
        </ul>
      </div>
    </div>
    <div class='demo-app-main'>
      <FullCalendar
        class='demo-app-calendar'
        :options='calendarOptions'
      >
        <template v-slot:eventContent='arg'>
          <b>{{ arg.timeText }}</b>
          <i>{{ arg.event.title }}</i>
        </template>
      </FullCalendar>
    </div>
  </div>
</template>

<style lang='css'>

/* * {
    margin: 0;
    padding: 0;
    height: 100%;
} */

.demo-app {
    margin: 0;
    padding: 0;
    height: 100%;
}

h2 {
  margin: 0;
  font-size: 16px;
}

ul {
  margin: 0;
  padding: 0 0 0 1.5em;
}

li {
  margin: 1.5em 0;
  padding: 0;
}

b { /* used for event dates/times */
  margin-right: 3px;
}

.demo-app {
  display: flex;
  min-height: 100%;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}

.demo-app-sidebar {
  width: 300px;
  line-height: 1.5;
  background: #eaf9ff;
  border-right: 1px solid #d3e2e8;
}

.demo-app-sidebar-section {
  padding: 2em;
}

.demo-app-main {
  flex-grow: 1;
  padding: 3em;
}

.fc { /* the calendar root */
  max-width: 1100px;
  margin: 0 auto;
}

.fc .fc-view-harness-active > .fc-view {
    position: inherit;
}

.fc .fc-view-harness-active > .fc-view {
    height: 100%;
    margin: 0;
    padding: 0;   
}
</style>