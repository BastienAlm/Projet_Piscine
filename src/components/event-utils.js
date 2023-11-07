import axios from 'axios'
import moment from 'moment';
let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today
export const workingsTable = []

export const dataItems = []

// const increment = Number(localStorage.getItem('length'));

// for (var i = 0; i < increment; i++){
//   console.log(localStorage.length);
//   const value = JSON.parse(localStorage.getItem('workingtime'))
//   console.log(value);
//   INITIAL_EVENTS.push({
//     id: value[i].id,
//     title: 'workingTime',
//     start: value[i].start
//   })
// }

export function createEventId() {
  return String(eventGuid++)
}

export async function workingTimes() {
    try {
       const result =  await axios.get("http://localhost:4000/api/workingtimes/1")
       //let datas = result.data.data.map((rep, index) => ({"id": rep.id, "title":"workingtime", "start": rep.start}));
        return result;
       
      //  .then(async (response) => {


      //    console.log(data)
      //   // return   data;
      //       // const data =  response.data;
      //     // console.log(data);
      //     // for(let i = 0; i < response.data.data.length; i++){
      //     //     let myObj = {
      //     //       // id: response.data.data[i].id,
      //     //       id: response.data.data[i].id+'',
      //     //       title: 'workingTime',
      //     //       start: response.data.data[i].start,
      //     //     }
      //     //     INITIAL_EVENTS.push(myObj)
      //     //     const test = dateFormat(response.data.data[i].end);
      //     //     //labels.push(getMonth(test))
      //     //     console.log(getMinute(test));
      //     //     labels.push(getDayName(test))
      //     //     dataItems.push(getMinute(test))
      //     //    response.data.data[i].end = dateFormat(response.data.data[i].end);
      //     //    response.data.data[i].start = dateFormat(response.data.data[i].start);
      //     //    workingsTable.push(response.data.data[i]);
      //     // }
      //     //console.log(labels);
      //     //console.log(INITIAL_EVENTS);
      //     // console.log(workingsTable);
      //     // console.log(INITIAL_EVENTS);
      //     // workingsTable.push(response.data.data);
      //   }).catch((error) => {
      //     console.log(error);
      //   })
    } catch (error) {
        console.log(error)
    }
}

export async function getLabel(){
      
  const data = await workingTimes()

  const labelsItems  = data.map((label,index) => labels.push((getDayName(dateFormat(label.start)))))
   console.log({labelsItems});
 }

 
export function getMonth(datetime) {
  const date = new Date(datetime); // Replace this with your actual date object
  const month = date.getMonth();
  const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  labels.push(monthNames[month])
  return monthNames[month];
}

export function getDayName(datetime) {
  const date = new Date(datetime); // Replace this with your actual date object
  const day = date.getDay();
  const dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  return dayNames[day];
}

export function dateFormat(date) {
  return moment(date).format('MM/DD/YYYY hh:mm');
}

export function getMinute(datetime) {
  const date = new Date(datetime); // Replace this with your actual date object
  const minute = date.getMinutes();
  return minute;
}
export const labels = []
workingTimes()