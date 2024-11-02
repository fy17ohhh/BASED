<template>
  <div class="home-container">
    <h1>BASED</h1>
    <h3>Bias Assessment <br />for SpEech Dataset</h3>
    <p>
      Uncover the potential bias in audio datasets used in various fields
      including Speech To Text(STT) and Automatic Speech Recognition(ASR)
      <br />
      Gain valuable insights from the project to assess the biases in your
      training data
    </p>
    <el-carousel
      indicator-position="outside"
      arrow="always"
      class="carousel-wrapper"
    >
      <el-carousel-item v-for="item in carouseData" :key="item">
        <img :src="item.url" alt="" class="carousel-item-img" />
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script setup>
const carouseData = [
  { url: require("../assets/img/image1.png") },
  { url: require("../assets/img/image2.png") },
];
</script>

<style scoped>
.home-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 20px;
}

h1 {
  font-size: 100px;
  line-height: 1.5;
  margin: 30px 0;
  color: #443f85;
}

h3 {
  font-size: 60px;
  line-height: 1.2;
  margin: 20px 0;
  color: #443f85;
}

p {
  font-size: 25px;
  padding-right: 80px;
  padding-left: 80px;
  color: #6f7cb2;
}

.carousel-wrapper {
  width: 800px;
  height: w00px;
  margin-top: 80px;
}

.carousel-item-img {
  height: 100%;
  width: 100%;
  object-fit: cover;
  border-radius: 30px;
}
</style>
