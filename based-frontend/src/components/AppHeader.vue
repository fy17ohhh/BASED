<template>
  <header>
    <nav class="header-router">
      <div class="left-links">
        <RouterLink to="/" class="nav-item-1">Home</RouterLink>
        <RouterLink to="/about" class="nav-item-1">About</RouterLink>

      </div>
      <div class="right-links">
        <RouterLink to="/AccentClassifier" class="nav-item-2">Accent Classifier</RouterLink>
        <RouterLink to="/BASEDHome" class="nav-item-2">BASED</RouterLink>
      </div>
    </nav>
  </header>
</template>

<script>
export default {
  name: "Header",
};
</script>

<style scoped>
nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  a {
    font-weight: bold;
    color: #2c3e50;
    text-decoration: none;
    margin: 0 10px;
    padding: 10px;

    &.router-link-exact-active {
      text-decoration: underline;
    }
    &.nav-item-1:hover {
      color: black;
    }
    &.nav-item-2:hover {
      color: #fff4d1;
    }
  }
}

.left-links {
  display: flex;
  gap: 20px;
  margin-left: 10px;
}

.right-links {
  display: flex;
  gap: 20px;
  padding: 5px 10px;
  margin-top: 10px;
  margin-right: 15px;
}

.header-router {
  list-style: none;
  display: flex;
  gap: 20px;
  font-family: "Roboto-Medium";
}

.nav-item-1 {
  padding: 10px;
  color: #505f98;
}

.nav-item-2 {
  padding: 10px;
  color: white;
  background-color: #111b47;
  border-radius: 7px;
}
</style>
