<template>
  <Header/>
  <NavbarHead/>
  <div class="row">
    <div class="column1" style="background-color: #aaa">
      <div style="font-size: large; font-weight: 700; height: 25px">
        Employees              
      </div>
      <div style="margin-left: -74%; height: 20px; margin-top: -2%">
        <h5>Search Employee</h5>                                  
      </div>
      <div class="custom1">
        <form @submit.prevent="getUser">
          <label style="font-size: 14px" for="fname">User Id: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
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
            style="border-radius: 3px; border-style: none"
            type="text"
            id="createusername"
            name="createusername"
            v-model="NewUser.user.username"
          />
          <label style="font-size: 14px" for="fname">Email: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
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
            style="border-radius: 3px; border-style: none"
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
            style="border-radius: 3px; border-style: none; margin-right: 9%"
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
            style="border-radius: 3px; border-style: none"
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
      <slot  />
      <div class="controls">
			<!--<button class='bg-green-600 hover:bg-green-700 text-white focus:ring-2 focus:ring-green-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button'  v-if='!isStarted' @click="start">-->
        <button class="PlayButton">
				<!-- <Icon icon="clarity:play-solid" :inline="true" /> -->
        <font-awesome-icon icon="fa-solid fa-play" />
				Start
			</button>
			<!--<button class='bg-yellow-600 hover:bg-yellow-700 text-white focus:ring-2 focus:ring-yellow-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button' @click='pause' v-else>-->
        <button class="PauseButton">
				<!--<Icon icon="clarity:pause-solid" :inline="true" />-->
        <font-awesome-icon icon="fa-solid fa-pause" />
				Pause
			</button>
			<!--<button class='bg-red-600 hover:bg-red-700 text-white focus:ring-2 focus:ring-red-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button' @click='stop' v-if='!isStopped'>-->
        <button class="StopButton">
				<!--<Icon icon="clarity:stop-solid" :inline="true" />-->
        <font-awesome-icon icon="fa-solid fa-stop" />
				Stop
			</button>
			<!--<button class='bg-blue-700 hover:bg-blue-800 text-white focus:ring-2 focus:ring-blue-200 transition ease-in-out rounded p-2 text-sm font-semibold mr-1' type='button' @click='countup' v-if='!countingUp'>-->
        <button class="CountUpButton">
				<!--<Icon icon="clarity:plus-circle-solid" :inline="true" />-->
        <font-awesome-icon icon="fa-solid fa-circle-plus" />
				Count Up
			</button>
		</div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Header from './Header.vue';
import NavbarHead from './NavbarHead.vue';
import * as config from './event-utils';
import { ref } from 'vue';
export default {
  name: "User",
  components: {
    Header,
    NavbarHead
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
      percentage : config.percentage,
      countingUp : config.countingUp,
      isBlinking : config.isBlinking,
      displayMs : config.displayMs,
    };
  },
  methods: {
    async getUser() {
      try {
        let response = await fetch(
          `http://localhost:4000/api/users/${
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
    globalClick() {
      config.globalClick();
    },
    rename() {
      config.rename();
    },
    retime() {
      config.retime();
    }
  },
  computed: {
    convertTimeFromString(string = '')  {
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
    },
    displayTitle() {
      return config.displayTitle;
    },
  },
  setup() {
    const display = ref(config.display);
    return {
      display
    };
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
  background-color: rgb(27, 185, 27);
}

.PauseButton {
  background-color: rgb(255, 234, 0);
}

.StopButton {
  background-color: rgb(230, 0, 0);
}

.CountUpButton {
  background-color: rgb(0, 68, 255);
}
</style>
