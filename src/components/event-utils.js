import axios from 'axios'
import moment from 'moment';
let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today
export const workingsTable = []

export const Storage = JSON.parse(localStorage.getItem('token')) ? JSON.parse(localStorage.getItem('token')) : {token: ""}

export let INITIAL_EVENT = []
export const dataItems = []

export var options = {  
	method: 'GET',
	headers: {
	  'Accept': 'application/json',
	  'Content-Type': 'application/json',
	  'Authorization': `Bearer ${Storage.token}`, // Storage.token
	},
};
//export const 


export function createEventId() {
  return String(eventGuid++)
}

export async function workingTimes() {

    try {
       const result =  await axios.get(`http://13.51.249.253/api/workingtimes/${Storage.user_id}`, options)
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

const timeUnitSeconds = [
	1,
	60,
	60 * 60,
	24 * 60 * 60,
]

const convertTimeFromString = (string = '') => {
	const timeUnits = string.split(':').reverse()
	let seconds = 0
	let isNotNaN = false
	timeUnits.forEach((unit, index) => {
		if (timeUnitSeconds[index] && !isNaN(unit)) {
			seconds += unit * timeUnitSeconds[index]
			isNotNaN = true
		}
	})
	if (isNotNaN) return seconds
	else return NaN
}

const clockObject = {
	clock:{}
}

const workingTimesObject = {
workingtime:{

}
}


export let displayTitle = 'TIMER',
	display = '00:00:00',
	displayMs = '000',
	percentage = 0,
	defaultSeconds = 0,
	isStarted = false,
	isStopped = true,
	countingUp = true,
	targetTimestamp = 0,
	pausedDifference = 0,
	isBlinking = false,
	frameInterval = () => {}

export function start() {
	let nowTimestamp = Date.now()
	let targetTime = defaultSeconds
	clockIn();
	if (pausedDifference) {
		console.log("test");
		targetTime = pausedDifference
		pausedDifference = 0
	}
	if (countingUp) targetTimestamp = nowTimestamp - targetTime
	else targetTimestamp = nowTimestamp + targetTime
	frameInterval = () => {
		if (!countingUp && targetTimestamp - Date.now() < 1) {
			stop()
			updateDisplay(0)
			isBlinking = true
			if (defaultSeconds === 0) countingUp = true
		} else updateDisplay()
		requestAnimationFrame(frameInterval)
	}
	frameInterval()
	isStarted = true
	isStopped = false
	isBlinking = false
}

function pause() {
	let nowTimestamp = Date.now()
	pausedDifference = Math.abs(targetTimestamp - nowTimestamp)
	frameInterval = () => {}
	updateDisplay()
	isStarted = false
}

function stop() {
	clockOut()
	if (isStarted) pause()
	reset()
	updateDisplay()
	isStopped = true
}

function reset() {
	let nowTimestamp = Date.now()
	if (countingUp) targetTimestamp = nowTimestamp - defaultSeconds
	else targetTimestamp = nowTimestamp + defaultSeconds
	pausedDifference = 0
}

/**
 * Remove the timer from parent component
 */
export function remove() {
	emit('remove', props.id)
}

/**
 * Update both display (hh:mm:ss and miliseconds)
 * @param {number} targetTime 
 */
function updateDisplay(targetTime) {
	if (isStopped) return
	let nowTimestamp = Date.now()
	if (targetTime) {
		if (countingUp) targetTimestamp = nowTimestamp - targetTime
		else targetTimestamp = nowTimestamp + targetTime
	}
	const time = Math.abs(nowTimestamp - targetTimestamp) / 1000
	const numMs = Math.floor((time % 1) * 1000)
	const numS = Math.floor(time % 60)
	const numM = Math.floor(time/60) % 60
	const numH = Math.floor(time/3600) % 24
	const numD = Math.floor(time/86400)
	let displayTemp = numS.toString().padStart(2, '0')
	displayTemp = numM.toString().padStart(2, '0') + ':' + displayTemp
	displayTemp = numH.toString().padStart(2, '0') + ':' + displayTemp
	if (numD) displayTemp = numD.toString().padStart(2, '0') + ':' + displayTemp
	display = displayTemp
	displayMs = ("000" + numMs).slice(-3)
	if (!countingUp && defaultSeconds) {
		percentage = time * 1000 / defaultSeconds
	}
	// console.log(display)
}

/**
 * Change the title
 */
export async function rename() {
	// To change the title
	let { value: title } = await Swal.fire({
		title: 'Enter the new title',
		input: 'text',
		inputValue: displayTitle,
		showCancelButton: true
	})
	if (title !== undefined) displayTitle = title
}

export function countup() {
	// Switch to counting up
	countingUp = true
	let nowTimestamp = Date.now()
	let difference = Math.abs(targetTimestamp - nowTimestamp)
	targetTimestamp = nowTimestamp - difference
	// updateDisplay()
}

/**
 * Switch timer to counting down
 */
export function countdown() {
	if (!countingUp && defaultSeconds) {
		percentage = time * 1000 / defaultSeconds
	}
	countingUp = false
	let nowTimestamp = Date.now()
	let difference = Math.abs(targetTimestamp - nowTimestamp)
	targetTimestamp = nowTimestamp + difference
	// updateDisplay()
}

/**
 * Change the timer's time
 */
export async function retime() {
	let { value: input } = await Swal.fire({
		title: 'Enter the new time',
		input: 'text',
		inputValue: defaultSeconds / 1000,
		showCancelButton: true,
		inputValidator: (input) => {
			let inputSecs = convertTimeFromString(input)
			console.log(inputSecs)
			if (Number.isNaN(Number(inputSecs))) {
				return 'Enter a valid value!'
			} else if (inputSecs < 0) {
				return 'Enter a positive number!'
			}
		}
	})

	if (!input) return

	defaultSeconds = convertTimeFromString(input) * 1000
	updateDisplay(defaultSeconds)
	if (pausedDifference) pausedDifference += defaultSeconds
}

export function globalClick() {
	isBlinking = false
}

function clockIn(){
	try {
        axios.post("http://localhost:4000/api/clocks/1", clockObject)
        .then((response) => {
          
          alert("clock created");
        }).catch(
          (error) =>
          alert("check fields and unique email"));
          //window.location.reload("500"));
          
      }
      catch (error) {
        console.log(error);
        alert("Error", error); 
      }
}

async function clockOut(){
	try {
        await axios.post(`http://localhost:4000/api/workingtimes/1`, workingTimesObject)
        .then(async (response) => {
			alert("workingTime cretaed")
        }).catch((error) => {
          console.log(error);
        })
    } catch (error) {
        console.log(error)
    }
}
export const labels = []
// workingTimes()