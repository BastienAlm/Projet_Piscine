<template>
  <div>
    <h1>Working Times</h1>
    <div class="first">
      <div class="second">
        <div class="third">
          <div class="month">
            March
          </div>
          <div class="monthNumber">
            <span class="monthText">
                    17
                  </span>
          </div>
          <div class="day">
            <span class="textsm">
                    Sunday
                  </span>
          </div>
          <div class="hour ">
            <span class="hourtext">
                    8:00 am to 5:00 pm
                  </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style scoped>
.div { font-family: 'Courier New', Courier, monospace;
    
}

.first {
  padding: 0.75rem; 
  margin-bottom: 1rem; 
  font-weight: 500; 
  background-color: #ffffff; 
}

.second {
  flex: none; 
  border-top-left-radius: 0.25rem;
  border-top-right-radius: 0.25rem; 
  width: 8rem; 
  text-align: center; 
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05); 

  @media (min-width: 1024px) { 
  border-top-left-radius: 0;
  border-top-right-radius: 0; 
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem; 
 }
}

.third {
  display: block; 
  overflow: hidden; 
  border-top-left-radius: 0.25rem;
  border-top-right-radius: 0.25rem; 
  text-align: center; 
}

.month {
  padding-top: 0.25rem;
  padding-bottom: 0.25rem; 
  color: #ffffff; 
  background-color: #3B82F6; 
}

.monthNumber {
  padding-top: 0.25rem; 
  border-right-width: 1px; 
  border-left-width: 1px; 
  border-color: #ffffff; 
  background-color: #ffffff; 
}

.monthText {
  font-size: 3rem;
  line-height: 1; 
  font-weight: 700; 
  line-height: 1.25; 
}

.day {
  margin-bottom: -0.25rem; 
  border-bottom-right-radius: 0.5rem;
  border-bottom-left-radius: 0.5rem; 
  border-right-width: 1px; 
  border-bottom-width: 1px; 
  border-left-width: 1px; 
  border-color: #ffffff; 
  text-align: center; 
  background-color: #ffffff;
}

.textsm {
  font-size: 0.875rem;
  line-height: 1.25rem; 
}

.hour{
  padding-bottom: 0.5rem; 
  border-bottom-right-radius: 0.5rem;
  border-bottom-left-radius: 0.5rem; 
  border-right-width: 1px; 
  border-bottom-width: 1px; 
  border-left-width: 1px; 
  border-color: #ffffff; 
  text-align: center; 
  background-color: #ffffff; 
}

.hourtext {
  font-size: 0.75rem;
  line-height: 1rem; 
  line-height: 1.5;
}
</style>