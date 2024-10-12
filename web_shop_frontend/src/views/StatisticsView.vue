<template>
  <HeaderComponent></HeaderComponent>
  <div class="view">
    <div>{{ top5Products }}</div>
    <div>{{ bottom5Products }}</div>
  </div>
</template>

<script setup lang="ts">
import HeaderComponent from '@/components/HeaderComponent.vue'
import ProductService from '@/services/ProductService'
import { onMounted, ref } from 'vue'

let productService = new ProductService()
let top5Products = ref()
let bottom5Products = ref()

onMounted(() => {
  getStatistics()
})

function getStatistics() {
  productService.getProductStatistics().then((response) => (top5Products.value = response))

  productService.getProductStatistics(true).then((response) => (bottom5Products.value = response))

  //todo alle bestellungen letzten 4 wochen
}
</script>
