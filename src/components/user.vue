<template>
  <div class="row" v-for="user in users">
    <div class="column1" style="background-color: #aaa">
      <div style="font-size: large; font-weight: 700; height: 25px">
        Employees
      </div>
      <div style="margin-left: -74%; height: 20px; margin-top: -2%">
        <h5>Search Employee</h5>
      </div>
      <div class="custom1">
        <form action="">
          <label style="font-size: 14px" for="fname">User Id: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="userId"
            name="userId"
          />
          <span>&nbsp</span>
          <input type="submit" @onclick="this.getData()" value="Search" />
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
        <form action="currentuser">
          <label style="font-size: 14px; margin-left: 22%" for="fname"
            >Username: &nbsp</label
          >
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="createusername"
            name="createusername"
          />
          <label style="font-size: 14px" for="fname">Email: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="createemail"
            name="createemail"
          />
          <span>&nbsp</span>
          <input type="submit" value="Create" />
        </form>
      </div>
      <div>
        <h4>Update employee</h4>
      </div>
      <div class="custom">
        <form action="currentuser">
          <label style="font-size: 14px; margin-left: 22%" for="fname"
            >User Id: &nbsp</label
          >
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="updateId"
            name="updateId"
          />&nbsp &nbsp &nbsp &nbsp
          <label style="font-size: 14px" for="fname">Username: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="updatename"
            name="updatename"
          />
          <br />
          <br />
          <label style="font-size: 14px" for="fname">Email: &nbsp</label>
          <input
            style="border-radius: 3px; border-style: none; margin-right: 9%"
            type="text"
            id="updateemail"
            name="updateemail"
          />
          <span>&nbsp</span>
          <input type="submit" value="Update" />
        </form>
      </div>
      <div>
        <h4>Delete employee</h4>
      </div>
      <div class="custom">
        <form action="currentuser">
          <label style="font-size: 14px; margin-left: -10%" for="fname"
            >User Id: &nbsp</label
          >
          <input
            style="border-radius: 3px; border-style: none"
            type="text"
            id="useriddel"
            name="useridde"
          />
          <span>&nbsp</span>
          <input type="submit" value="Delete" />
        </form>
      </div>
    </div>
    <div class="column2">
      <div style="flex: 50%; background-color: lightgray"></div>
      <div style="flex: 50%; background-color: gray"></div>
    </div>
  </div>
</template>

<script>
export default {
  name: "User",
  props: { users: Array },

  data() {
    return {
      posts: [],
    };
  },
  methods: {
    // async getData() {
    //   try {
    //     let response = await fetch(
    //       `http://localhost:4000/api/users/${
    //         document.getElementById("userId").value
    //       }`
    //     );
    //     this.posts = await response.json();
    //     console.log(posts);
    //   } catch (error) {
    //     console.log(error);
    //   }
    // },
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
