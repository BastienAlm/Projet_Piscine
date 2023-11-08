<template>

<div class="login-page">
   <transition name="fade">
      <div v-if="!registerActive" class="wallpaper-login"></div>
   </transition>
   <div class="wallpaper-register"></div>

   <div class="container">
      <div class="row">
         <div class="col-lg-4 col-md-6 col-sm-8 mx-auto">
            <div v-if="!registerActive" class="card login" v-bind:class="{ error: emptyFields }">
               <h1>Sign In</h1>
               <form class="form-group" @submit.prevent="doLogin">
                  <!-- <input v-model="emailLogin" type="email" class="form-control" placeholder="Email" required> -->
                  <input v-model="idLogin" type="number" class="form-control" placeholder="Id" required>
                  <!-- <input v-model="passwordLogin" type="password" class="form-control" placeholder="Password" required> -->
                  <input type="submit" class="btn btn-primary">
                  <p>Don't have an account? <a href="#" @click="registerActive = !registerActive, emptyFields = false">Sign up here</a>
                  </p>
                  <p><a href="#">Forgot your password?</a></p>
               </form>
            </div>

            <div v-else class="card register" v-bind:class="{ error: emptyFields }">
               <h1>Sign Up</h1>
               <form class="form-group">
                  <input v-model="emailReg" type="email" class="form-control" placeholder="Email" required>
                  <input v-model="passwordReg" type="password" class="form-control" placeholder="Password" required>
                  <input v-model="confirmReg" type="password" class="form-control" placeholder="Confirm Password" required>
                  <input type="submit" class="btn btn-primary" @click="doRegister">
                  <p>Already have an account? <a href="#" @click="registerActive = !registerActive, emptyFields = false">Sign in here</a>
                  </p>
               </form>
            </div>
         </div>
      </div>

   </div>
</div>

</template>

<script>

export default {
  name: "Login",
  data(){
    return {
      registerActive: false,
      emailLogin: "",
      idLogin:"",
      passwordLogin: "",
      emailReg: "",
      passwordReg: "",
      confirmReg: "",
      emptyFields: false
    }
  },
  methods:{
    doLogin() {
      // if (this.emailLogin === "" || this.passwordLogin === "") {
        if (this.idLogin === "" ) {
        this.emptyFields = true;
      } else {
        this.getUser();
      }
    },
    doRegister() {
      if (this.emailReg === "" || this.passwordReg === "" || this.confirmReg === "") {
        this.emptyFields = true;
      } else {
        alert("You are now registered");
      }
    },
    async getUser() {
      try {
        let response = await fetch(
          `http://localhost:4000/api/users/${
            this.idLogin
          }`);
          const data = await response.json(); 
                 // ).then((data) => {
        //     console.log( await data.json());
        localStorage.setItem('user', JSON.stringify(data.data));
        console.log(data.data);
        this.$router.push("workingTimes/1")
      } catch (error) {
        console.log(error);
      }
      
    },
  }
}
</script>

<style scoped lang="scss">
p {
   line-height: 1rem;
}

.card {
   padding: 20px;
}

.form-group {
   input {
      margin-bottom: 20px;
   }
}

.login-page {
   align-items: center;
   display: flex;
   height: 100vh;

   .wallpaper-login {
      background: url(https://images.unsplash.com/photo-1561487767-1f32d174cce0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)
         no-repeat center center;
      background-size: cover;
      height: 100%;
      position: absolute;
      width: 100%;
   }
   
   .fade-enter-active,
   .fade-leave-active {
  transition: opacity .5s;
}
   .fade-enter,
   .fade-leave-to {
      opacity: 0;
   }
   
   .wallpaper-register {
      background: url(https://images.pexels.com/photos/533671/pexels-photo-533671.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260)
         no-repeat center center;
      background-size: cover;
      height: 100%;
      position: absolute;
      width: 100%;
      z-index: -1;
   }

   h1 {
      margin-bottom: 1.5rem;
   }
}

.error {
   animation-name: errorShake;
   animation-duration: 0.3s;
}

@keyframes errorShake {
   0% {
      transform: translateX(-25px);
   }
   25% {
      transform: translateX(25px);
   }
   50% {
      transform: translateX(-25px);
   }
   75% {
      transform: translateX(25px);
   }
   100% {
      transform: translateX(0);
   }
}

</style>