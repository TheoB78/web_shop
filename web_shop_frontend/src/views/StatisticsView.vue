<template>
  <HeaderComponent></HeaderComponent>
  <div class="view">
    <button @click="debug"></button>
    <div v-if="!top5Products">Laden</div>
    <div v-else>
      <h3>Die 5 beliebtesten Produkte</h3>
      <div
        @click="goToSingleView(topProduct.product_id)"
        class="item-row row"
        v-for="(topProduct, index) in top5Products.data"
        v-bind:key="topProduct.product_id"
      >
        <div class="col-md-3">
          <img class="img-fluid" :src="`/src/assets/${topProduct.image_path}`" />
        </div>
        <div class="col-md-6">
          <h4>{{ index + 1 }}. {{ topProduct.product_name }}</h4>
          <h5 class="">{{ topProduct.amount }} Käufe</h5>
          <div class="row"></div>
        </div>
      </div>
    </div>
    <div v-if="!top5Products">Laden</div>
    <div v-else>
      <h3>Die 5 unbeliebtesten Produkte</h3>
      <div
        @click="goToSingleView(bottomProduct.product_id)"
        class="item-row row"
        v-for="(bottomProduct, index) in bottom5Products.data"
        v-bind:key="bottomProduct.product_id"
      >
        <div class="col-md-3">
          <img class="img-fluid" :src="`/src/assets/${bottomProduct.image_path}`" />
        </div>
        <div class="col-md-6">
          <h4>{{ index + 1 }}. {{ bottomProduct.product_name }}</h4>
          <h5 class="">{{ bottomProduct.amount }} Käufe</h5>
          <div class="row"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import HeaderComponent from '@/components/HeaderComponent.vue'
import router from '@/router'
import ProductService from '@/services/ProductService'
import { onMounted, ref } from 'vue'

let productService = new ProductService()
let top5Products = ref()
let bottom5Products = ref()

onMounted(() => {
  getStatistics()
})

function debug() {
  console.log(top5Products.value)
  console.log(bottom5Products.value)
}

function getStatistics() {
  productService.getProductStatistics().then((response) => (top5Products.value = response))

  productService.getProductStatistics(true).then((response) => (bottom5Products.value = response))

  //todo alle bestellungen letzten 4 wochen
}

function goToSingleView(id: number) {
  router.push(`/product/${id}`)
}
</script>
