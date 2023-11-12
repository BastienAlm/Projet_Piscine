<template>
<div class="login-page">
  <PWAPrompt />
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
                  <input v-model="user.email" type="email" class="form-control" placeholder="Email" required>
                  <!-- <input v-model="idLogin" type="number" class="form-control" placeholder="Id" required> -->
                  <input v-model="user.password" type="password" class="form-control" placeholder="Password" required>
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
import PWAPrompt from './PWAPrompt.vue';
import axios from 'axios';
export default {
  name: "Login",
  components:{
    PWAPrompt
  },
  data(){
    return {
      registerActive: false,
      emailLogin: "",
      idLogin:"",
      passwordLogin: "",
      emailReg: "",
      passwordReg: "",
      confirmReg: "",
      emptyFields: false,
      user: {
        email:"",
        password:""
      }
    }
  },
  methods:{
    doLogin() {
      if (this.user.email === "" || this.user.password === "") {
        // if (this.idLogin === "" ) {
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
        axios.post(
          "http://13.51.249.253/api/users/sign_in", this.user
          ).then(async (response) => {
          
          //console.log( await data.json());
          localStorage.setItem('token', JSON.stringify(response.data.token));
          console.log(response);
          this.$router.push("workingTimes/1")
          })
         
      } catch (error) {
        console.log(error);
      }

      // try{
      //   fetch('URL_GOES_HERE', { 
      //     method: 'post', 
      //     headers: new Headers({
      //         'Authorization': 'Basic '+btoa('username:password'), 
      //         'Content-Type': 'application/x-www-form-urlencoded'
      //     }), 
      //     body: 'A=1&B=2'
      // });
      // }catch (error) {
      //   console.log(error);
      // }
      
    },
  }
}
</script>

<style scoped >
p {
	 line-height: 1rem;
}
 .card {
	 padding: 20px;
}
 .form-group input {
	 margin-bottom: 20px;
}
 form.form-group {
	 display: unset;
}
 .login-page {
	 align-items: center;
	 display: flex;
	 height: 100vh;
}
 .login-page .wallpaper-login {
	 background: url(https://images.unsplash.com/photo-1561487767-1f32d174cce0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D) no-repeat center center;
	 background-size: cover;
	 height: 100%;
	 position: absolute;
	 width: 100%;
}
 .login-page .fade-enter-active, .login-page .fade-leave-active {
	 transition: opacity 0.5s;
}
 .login-page .fade-enter, .login-page .fade-leave-to {
	 opacity: 0;
}
 .login-page .wallpaper-register {
	 background: url(https://images.unsplash.com/photo-1561487767-1f32d174cce0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D) no-repeat center center;
	 background-size: cover;
	 height: 100%;
	 position: absolute;
	 width: 100%;
	 z-index: -1;
}
 .login-page h1 {
	 margin-bottom: 1.5rem;
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