<template id="app">
  <AppHeader />
  <RouterView />
  <AppFooter />
</template>

<script setup>
import AppFooter from "./components/AppFooter.vue";
import AppHeader from "./components/AppHeader.vue";
</script>

<style>
body {
  margin: 0px;
}

#app {
  font-family: "Roboto-Regular";
  text-align: center;
  background-color: #f3f5ff;
}
</style>
