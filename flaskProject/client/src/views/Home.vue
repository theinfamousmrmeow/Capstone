<template>
  <div class="home">
    <img alt="logo" src="../assets/logo.png">
    <HelloWorld msg="Welcome to the 'Attack Of the Ai-nimals' Dashboard"/>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/DashboardHeader.vue';

export default {
  name: 'Home',
  components: {
    HelloWorld,
  },
};
</script>
