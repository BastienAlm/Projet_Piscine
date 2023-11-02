<template>
  <div class="row">
    <div class="column1" style="background-color: #aaa">
      <div style="font-size: large; font-weight: 700; height: 25px">
        Employees              
      </div>
      <div style="margin-left: -74%; height: 20px; margin-top: -2%">
        <h5>Search Employee</h5>                                  
      </div>
      <div class="custom1">
        <form @submit.prevent="getData">
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
        <form @submit.prevent="ReloadUser">
          <label style="font-size: 14px; margin-left: 22%" for="fname"
            >User Id: &nbsp</label
          >
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="updateId"
            name="updateId"
            v-model="UpdateUser.id"
          />&nbsp &nbsp &nbsp &nbsp
          <label style="font-size: 14px" for="fname">Username: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="updatename"
            name="updatename"
            v-model="UpdateUser.username"
          />
          <br />
          <br />
          <label style="font-size: 14px" for="fname">Email: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none; margin-right: 9%"
            type="text"
            id="updateemail"
            name="updateemail"
            v-model="UpdateUser.email"
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
    </div>
    <div class="column2">
      <!-- <div style="flex: 50%; background-color: lightgray"></div>
      <div style="flex: 50%; background-color: gray"></div> -->
      <router-view />
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  name: "User",
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
      UpdateUser: {
        id: "",
        email: "",
        username: "",
      }
    };
  },
  methods: {
    async getData() {
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
    ReloadUser() {
      try {
        axios.put(`http://localhost:4000/api/users/${this.UpdateUser.id}`, 
        {
          "user": {
            "username": this.UpdateUser.username,
            "email": this.UpdateUser.email,
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
  },
};
</script>

<style scoped>
.row {
  display: flex;
  flex-direction: row;
}

.column1 {
  flex: 35%;
  padding: 10px;
  border-radius: 5px;
  height: auto;
  position: relative;
}
.column2 {
  display: flex;
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
</style>
