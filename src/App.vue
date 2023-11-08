<template>
  <main>
    <component :is="$route.meta.layout || 'div'">
      <router-view></router-view>
    </component>
  </main>
</template>

<script>
import User from "./components/user";

export default {
  name: "App",
  components: {
    User,
  },
  data() {
    return {
      users: [],
    };
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

div {
    /* display: flex;
    justify-content: center; */
    align-items: center;
    /* min-height: 100vh; */
    /* background: #eceffc; */
  }
  

</style>
