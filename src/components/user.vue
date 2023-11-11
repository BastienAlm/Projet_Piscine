<template class="row">
  <Header/>
  <NavbarHead />
  <div class="row">
    <!--<div class="column1" style="background-color: #aaa">-->
      <div class="column1">
      <div style="font-size: large; font-weight: 700; height: 25px">
        Employees              
      </div>
      <div style="margin-left: ; height: 20px; margin-top: 3%">
        <h5>Search Employee</h5>                                  
      </div>
      <div class="custom1">
        <form @submit.prevent="getUser">
          <label style="font-size: 14px" for="fname">User Id: &nbsp</label>
          <input
            style="border-radius:; border-style:"
            type="text"
            id="userId"
            name="userId"                  
            v-model="id"
            placeholder="Enter user id"
          />         
          <span>&nbsp</span>
          <input type="submit"/>
        </form>
      </div>

      <div>
        <h4>Current employee</h4>
        <p>User id:&nbsp {{ user.id }}</p>
        <p>Username:&nbsp {{ user.username }}</p>
        <p>Email:&nbsp {{ user.email }}</p>
      </div>

      <div style="margin-top: -2%">
        <h4>Create employee</h4>
      </div>
      <div class="custom">
        <form @submit.prevent="createUser">
          <label style="font-size: 14px; margin-left: 22%" for="fname"
            >Username: &nbsp</label
          >
          <input
            style="border-radius: ; border-style:"
            type="text"
            id="createusername"
            name="createusername"
            v-model="NewUser.user.username"
          />
          <label style="font-size: 14px" for="fname">Email: &nbsp</label>
          <input
            style="border-radius: ; border-style: "
            type="text"
            id="createemail"
            name="createemail"
            v-model="NewUser.user.email"
          />
          <span>&nbsp</span>
          <input type="submit" value="Create" />
        </form>
      </div>
      <div>
        <h4>Update employee</h4>
      </div>
      <div class="custom">
        <form @submit.prevent="updateUser">
          <label style="font-size: 14px; margin-left: 22%" for="fname"
            >User Id: &nbsp</label
          >
          <input
            style="border-radius: ; border-style: "
            type="text"
            id="updateId"
            name="updateId"
            v-model="ReloadUser.id"
          />&nbsp &nbsp &nbsp &nbsp
          <label style="font-size: 14px" for="fname">Username: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="updatename"
            name="updatename"
            v-model="ReloadUser.username"
          />
          <br />
          <br />
          <label style="font-size: 14px" for="fname">Email: &nbsp</label>
          <input
            style="border-radius: ; border-style: ; margin-right: 5%"
            type="text"
            id="updateemail"
            name="updateemail"
            v-model="ReloadUser.email"
          />
          <span>&nbsp</span>
          <input type="submit"/>
        </form>
      </div>
      <div>
        <h4>Delete employee</h4>
      </div>
      <div class="custom">
        <form @submit.prevent="deleteUser">
          <label style="font-size: 14px; margin-left: -10%" for="fname"
            >User Id: &nbsp</label
          >
          <input
            style="border-radius: ; border-style: "
            type="text"
            id="useriddel"
            name="useridde"
            v-model="idDel"
          />
          <span>&nbsp</span>
          <input type="submit" value="Delete" />
        </form>
      </div>
      <div class='timer p-4 rounded shadow-lg hover:shadow-2xl transition ease-in-out text-center flex flex-col justify-center bg-white relative overflow-hidden' @click='globalClick'>
        <div class='w-full rounded-t absolute top-0 left-0'>
          <div class='h-2 bg-black opacity-25' :style="{ width: percentage * 100 + '%' }" v-if='!countingUp'>
          </div>
        </div>
        <div class="mb-2" v-if='displayTitle'>
          <p class='text-2xl cursor-pointer group' @click='rename'>
            <b>
            {{ displayTitle }}
            </b>
            <span class='text-base hidden group-hover:inline'><Icon icon="clarity:pencil-solid" :inline="true" /></span>
          </p>
        </div>
        <div class="display mb-4">
          <p class='text-xl cursor-pointer group' :class="{ 'timer-blinking': isBlinking }" @click='retime'>
            <span class='text-6xl'>{{ display }}</span><span class='text-xl text-gray-500'>.{{ displayMs }}</span>
            <span class='text-xl hidden group-hover:inline ml-1'><Icon icon="clarity:pencil-solid" :inline="true" /></span>
          </p>
        </div>
	</div>
    </div>
    <div class="column2">
      <!-- <div style="flex: 50%; background-color: lightgray"></div>
      <div style="flex: 50%; background-color: gray"></div> -->
      <slot  :events="{ atClickNext: fnNext, atClickClose: fnClose }"></slot> 
      <!-- <WorkingTime @start="console.log('start')"/> -->
     
    </div>
    <div class="controls" >
      <!--<button class='bg-green-600 hover:bg-green-700 text-white focus:ring-2 focus:ring-green-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button'  v-if='!isStarted' @click="start">-->
        <button  class="PlayButton" v-if='!isStarted' @click="fnNext">
        <!-- <Icon icon="clarity:play-solid" :inline="true" /> -->
        <font-awesome-icon icon="fa-solid fa-play" />
        Start
      </button>
      <!--<button class='bg-yellow-600 hover:bg-yellow-700 text-white focus:ring-2 focus:ring-yellow-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button' @click='pause' v-else>-->
        <button class="PauseButton" @click="fnClose">
        <!--<Icon icon="clarity:pause-solid" :inline="true" />-->
        <font-awesome-icon icon="fa-solid fa-pause" />
        Pause
      </button>
      <!--<button class='bg-red-600 hover:bg-red-700 text-white focus:ring-2 focus:ring-red-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button' @click='stop' v-if='!isStopped'>-->
        <button class="StopButton" @click="$parent.$emit('stop')">
        <!--<Icon icon="clarity:stop-solid" :inline="true" />-->
        <font-awesome-icon icon="fa-solid fa-stop" />
        Stop
      </button>
      <!--<button class='bg-blue-700 hover:bg-blue-800 text-white focus:ring-2 focus:ring-blue-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button' @click='countup' v-if='!countingUp'>-->
        <button class="CountUpButton" @click="$parent.$emit('countingUp')">
        <!--<Icon icon="clarity:plus-circle-solid" :inline="true" />-->
        <font-awesome-icon icon="fa-solid fa-circle-plus" />
        Count Up
      </button>
		</div>
  </div>
</template>

<script>
import axios from 'axios';
import Header from './Header.vue';
import NavbarHead from './NavbarHead.vue';
import { ref, computed } from 'vue';
import {useRoute} from 'vue-router'
import WorkingTime from './WorkingTime.vue';
export default {
  name: "User",
  components: {
    Header,
    NavbarHead,
    WorkingTime
  },
  props: { users: Array },

  data() {
    return {
      id: "",
      idDel: "",
      posts: [],
      user: {
        id: "",
        email: "",
        username: "",
      },
      NewUser: {
        user:{
            email:"",
            username:"",
            role: "employee"
        }
      },
      ReloadUser: {
        id: "",
        email: "",
        username: "",
      },
    };
  },
  methods: {
    async getUser() {
      try {
        let response = await fetch(
          `http://13.51.249.253/api/users/${
            this.id
          }`);
          const data = await response.json(); 
                 // ).then((data) => {
        //     console.log( await data.json());
           this.user.id = data.data.id;
           this.user.email = data.data.email;
           this.user.username = data.data.username;

          this.UpdateUser.id = data.data.id;
          this.UpdateUser.email = data.data.email;
          this.UpdateUser.username = data.data.username;
          console.log(data);
        
      } catch (error) {
        console.log(error);
      }
      
    },
    createUser() {
      try {
        axios.post("http://localhost:4000/api/users", this.NewUser)
        .then((response) => {
          
          alert("User created");
          this.NewUser.user.email = "";
          this.NewUser.user.username = "";
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
    UpdateUser() {
      try {
        axios.put(`http://localhost:4000/api/users/${this.ReloadUser.id}`, 
        {
          "user": {
            "username": this.ReloadUser.username,
            "email": this.ReloadUser.email,
          }
        }
        )
        .then((response) => {
          
          alert("User updated");
          // this.user.email = "";
          // this.user.username = "";
        }).catch(
          (error) =>
          alert("check fields and unique email"));
          // window.location.reload("500"));
      }catch (error) {
        console.log(error);
      }
    },
    deleteUser() {
      try {
        axios.delete(`http://localhost:4000/api/users/${this.idDel}`)
        .then((response) => {
          
          alert("User deleted");
          this.idDel = "";
        }).catch(
          (error) =>
          alert("check fields "));
          // window.location.reload("500"));
      }catch (error) {
        console.log(error);
      }
    },
    fnNext(){
      console.log("next");
    }
  },
  setup() {

    const route =useRoute();
    // const path = computed(() =>route.path)
    const timeUnitSeconds = [
      1,
      60,
      60 * 60,
      24 * 60 * 60,
    ];
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

    }}

    let displayTitle = ref('TIMER'),
    display = ref('00:00:00'),
    displayMs = ref('000'),
    percentage = ref(0),
    defaultSeconds = 0,
    isStarted = ref(false),
    isStopped = ref(true),
    countingUp = ref(true),
    targetTimestamp = 0,
    pausedDifference = 0,
    isBlinking = false,
    frameInterval = () => {}
    

    // const isRunning = ref (path.value == "/workingTime/1/1" ? true : false)

    function start() {
      console.log("je start");
      clockIn();
      let nowTimestamp = Date.now()
      let targetTime = defaultSeconds
      if (pausedDifference) {
        console.log("test");
        targetTime = pausedDifference
        pausedDifference = 0
      }
      if (countingUp.value) targetTimestamp = nowTimestamp - targetTime
      else targetTimestamp = nowTimestamp + targetTime
      frameInterval = () => {
        if (!countingUp.value && targetTimestamp - Date.now() < 1) {
          stop()
          updateDisplay(0)
          isBlinking = true
          if (defaultSeconds === 0) countingUp.value = true
        } else updateDisplay()
        requestAnimationFrame(frameInterval)
      }
      frameInterval()
      console.log("jarrive au frameInterval");
      isStarted.value = true
      isStopped.value = false
      isBlinking = false
    }

    function pause() {
      console.log("je pause");
      let nowTimestamp = Date.now()
      pausedDifference = Math.abs(targetTimestamp - nowTimestamp)
      frameInterval = () => {}
      updateDisplay()
      isStarted.value = false
    }

    function stop() {
      console.log("je stop");
      clockOut()
      if (isStarted.value) pause()
      reset()
      updateDisplay()
      isStopped.value = true
    }

    function reset() {
      console.log("je reset");
      let nowTimestamp = Date.now()
      if (countingUp.value) targetTimestamp = nowTimestamp - defaultSeconds
      else targetTimestamp = nowTimestamp + defaultSeconds
      pausedDifference = 0
    }

    /**
     * Update both display (hh:mm:ss and miliseconds)
     * @param {number} targetTime 
     */

     function updateDisplay(targetTime) {
      if (isStopped.value) return
      let nowTimestamp = Date.now()
      if (targetTime) {
        if (countingUp.value) targetTimestamp = nowTimestamp - targetTime
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
      display.value = displayTemp
      displayMs.value = ("000" + numMs).slice(-3)
      if (!countingUp.value && defaultSeconds) {
        percentage.value = time * 1000 / defaultSeconds
      }
      // console.log(display)
    }

    async function rename() {
      // To change the title
      let { value: title } = await Swal.fire({
        title: 'Enter the new title',
        input: 'text',
        inputValue: displayTitle.value,
        showCancelButton: true
      })
      if (title !== undefined) displayTitle.value = title
    }

    function countup() {
      // Switch to counting up
      countingUp.value = true
      let nowTimestamp = Date.now()
      let difference = Math.abs(targetTimestamp - nowTimestamp)
      targetTimestamp = nowTimestamp - difference
      // updateDisplay()
    }

    function countdown() {
      console.log("je countdown");
      if (!countingUp.value && defaultSeconds) {
        percentage.value = time * 1000 / defaultSeconds
      }
      countingUp.value = false
      let nowTimestamp = Date.now()
      let difference = Math.abs(targetTimestamp - nowTimestamp)
      targetTimestamp = nowTimestamp + difference
      // updateDisplay()
    }

    async function retime() {
      console.log("je retime");
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

    function globalClick() {
      isBlinking = false
    }

    function clockIn(){
      try {
        axios.post("http://localhost:4000/api/clocks/1", clockObject)
        .then((response) => {
          
          console.log("clock created");
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

    return {
      display,
      displayTitle,
      displayMs,
      percentage,
      defaultSeconds,
      isStarted,
      isStopped,
      countingUp,
      targetTimestamp,
      pausedDifference,
      isBlinking,
      // isRunning,
      start,
      frameInterval,
      updateDisplay,
      countup,
      countdown,
      retime,
      globalClick,
      clockIn,
      clockOut,
    }
  }
};
</script>

<style scoped>
.row {
  display: flex;
  flex-direction: row;
  flex-wrap: unset;
  margin-right: unset;
}

.column1 {
  flex: 35%;
  padding: 10px;
  border-radius: 5px;
  height: auto;
  position: relative;
}
.column2 {
  /* display: flex; */
  flex-direction: column;
  flex: 65%;
  padding: 10px;
  height: auto; /* Should be removed. Only for demonstration */
}

.custom {
  margin-top: 2%;
  margin-left: -32%;
}
.custom1 {
  margin-top: 2%;
  margin-left: -40%;
}

.currentuser {
}
.title {
  margin-top: 15px;
}

p {
  text-align: left;
  align-self: left;
  margin-top: -15px;
  margin-left: 10px;
}

.PlayButton {
  background-color: rgb(43, 194, 43);
  margin-right: 20px;
  margin-top: 15px;
}

.PauseButton {
  background-color: rgb(255, 234, 0);
  margin-right: 20px;
}

.StopButton {
  background-color: rgb(230, 0, 0);
  margin-right: 20px;
}

.CountUpButton {
  background-color: rgb(70, 118, 249);
}

.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
  margin-top: 2%;
}
</style>
