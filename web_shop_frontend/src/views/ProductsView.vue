<template>
  <HeaderComponent></HeaderComponent>
  <div class="view">
    <h1 class="margin-top">Produkte:</h1>
    <div class="grid-view">
      <div v-if="!products">Laden</div>
      <div v-else-if="!products.length">keine Produkte</div>
      <div
        v-bind:key="product.id"
        v-else
        v-for="product in products"
        class="card"
        @click="goToSingleView(product.id)"
      >
        <img class="img-fluid" :src="`/src/assets/${product.image_path}`" />
        <div class="card-header">
          {{ product.product_name }}
        </div>
        <div class="card-body">
          <ul class="list-group list-group-flush">
            <li class="list-group-item">{{ product.price }}€</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import ProductService from '@/services/ProductService'
import { useRouter } from 'vue-router'
import HeaderComponent from '@/components/HeaderComponent.vue'

const productService = new ProductService()

let products = ref()
let router = useRouter()

onMounted(() => {
  getAllPcs()
})

function getAllPcs() {
  productService.getAllProducts().then((response) => (products.value = response))
}

function goToSingleView(id: number) {
  router.push(`/product/${id}`)
}
</script>

<style>
.margin-top {
  margin-top: 25px;
}

/*     */
</style>
