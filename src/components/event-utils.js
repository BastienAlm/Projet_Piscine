import axios from 'axios'
let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today
export const workingsTable = []
workingTimes()
export const INITIAL_EVENTS = [
]

const increment = Number(localStorage.getItem('length'));

for (var i = 0; i < increment; i++){
  console.log(localStorage.length);
  const value = JSON.parse(localStorage.getItem('workingtime'))
  console.log(value);
  INITIAL_EVENTS.push({
    id: value[i].id,
    title: 'workingTime',
    start: value[i].start
  })
}

export function createEventId() {
  return String(eventGuid++)
}

export async function workingTimes () {
    try {
        await axios.get(`http://localhost:4000/api/workingtimes/1`)
        .then(async (response) => {
            const data = await response.data.data;
          console.log(response.data.data);
          for(let i = 0; i < response.data.data.length; i++){
              let myObj = {
                id: response.data.data[i].id,
                title: 'workingTime',
                start: response.data.data[i].start,
              }
             workingsTable.push(myObj);
          //   response.data.data[i].end = this.dateFormat(response.data.data[i].end);
          //   response.data.data[i].start = this.dateFormat(response.data.data[i].start);
          //   this.workingsTable.push(response.data.data[i]);
          }
          const value = JSON.stringify(workingsTable)
          const length = workingsTable.length
          localStorage.setItem('workingtime', value)
          localStorage.setItem('length', length)
          console.log(workingsTable);
          console.log(INITIAL_EVENTS);
          // this.workingsTable.push(response.data.data);
        }).catch((error) => {
          console.log(error);
        })
    } catch (error) {
        console.log(error)
    }
}