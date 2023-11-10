<template>
  <main class="row">
    <component :is="$route.meta.layout || 'div'" @start="console.log('start')">
      <install-prompt></install-prompt>
      <router-view></router-view>
    </component>
  </main>
</template>

<script>
import installPrompt from "./components/PWAPrompt.vue";

export default {
  name: "App",
  components: {
    installPrompt
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
    /* min-height: 100vh; */
    /* background: #eceffc; */
  }
  
</style>
