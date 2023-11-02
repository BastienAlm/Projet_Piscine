<template>
  <div class="container">
    <Header />
    <User :users="users" />
  </div>
</template>

<script>
import Header from "./components/Header";
import User from "./components/user";
export default {
  name: "App",
  components: {
    Header,
    User,
  },
  data() {
    return {
      users: [],
    };
  },
  async created() {
    try {
      let response = await fetch(`http://localhost:4000/api/users`);
      const user = await response.json();
      this.users = [user.data[0]];
    } catch (error) {
      console.log(error);
    }
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px;*/
}

</style>
