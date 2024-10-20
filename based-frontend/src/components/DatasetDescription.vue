<template>
  <div class="dataset-description">
    <h3>Dataset Summary</h3>
    <p class="description-text">{{ description }}</p>
  </div>
</template>
<script setup>
import { defineProps } from 'vue';

const props = defineProps({
  description: {
    type: Object,
    required: true
  }
});
</script>

<style scoped>
.dataset-description {
  text-align: left;
  padding: 20px;
  margin-left: 30px;
  margin-right: 30px;
}

h3 {
  font-size: 25px;
}

.description-text {
  font-size: 22px;
  color: #6f7cb2;
}
</style>