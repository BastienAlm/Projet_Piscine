import axios from 'axios'
import moment from 'moment';
let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today
export const workingsTable = []

export let INITIAL_EVENT = []
export const dataItems = []

//export const 


export function createEventId() {
  return String(eventGuid++)
}

export async function workingTimes() {
    try {
       const result =  await axios.get("http://localhost:4000/api/workingtimes/1")
       INITIAL_EVENT=  result.data.data.map((rep, index) => ({"id": rep.id, "title":"workingtime", "start": rep.start}));
       console.log("resultat", result.data.data);
        return result;
       
      //  .then(async (response) => {

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