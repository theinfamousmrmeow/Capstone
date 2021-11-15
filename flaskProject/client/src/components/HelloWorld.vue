<template>
  <div class="hello">
    <h1>{{ msg }}</h1>

    <h3>Capstone Dashboard</h3>
    <ul>
      <li><a href="./about" target="_blank" rel="noopener">About</a></li>
      <li><a href="./sessions" target="_blank" rel="noopener">Sessions CRUD</a></li>
      <li><a href="./brains" target="_blank" rel="noopener">Brains CRUD</a></li>
      <li><a href="./chart1" target="_blank" rel="noopener">
        Chart 1: Brain Fitness Over Time</a></li>
      <li><a href="./chart2" target="_blank" rel="noopener">
        Chart 2: Session Length Over Time</a></li>
    </ul>

  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
