<template>
  <HeaderComponent />
  <div class="view">
    <div class="single-view container">
      <div v-if="!product">Nicht gefunden</div>
      <div v-else class="row">
        <div class="col-md-5">
          <img class="img-fluid" :src="`/src/assets/${product.image_path}`" />
        </div>
        <div class="col-md-6">
          <h1>{{ product.product_name }}</h1>
          <table class="table table-striped">
            <tbody>
              <tr>
                <th scope="row">Beschreibung:</th>
                <td>{{ product.description }} €</td>
              </tr>
              <tr>
                <th scope="row">Preis:</th>
                <td>{{ product.price }} €</td>
              </tr>
              <tr v-bind:key="property.id" v-for="property in product.properties">
                <th>{{ property.property_key }}:</th>
                <td>{{ property.property_value }}</td>
              </tr>
            </tbody>
          </table>
          <button type="button" class="btn btn-primary" @click="addToCart">In den Warenkorb</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import ProductService from '@/services/ProductService'
import Shipment_product from '@/models/Shipment_product'
import { useRoute } from 'vue-router'
import HeaderComponent from '@/components/HeaderComponent.vue'

const productService = new ProductService()

let product = ref()
let route = useRoute()

onMounted(() => {
  getProductById(route.params.id)
})

function getProductById(id: any) {
  productService.getProductById(id).then((response) => (product.value = response))
}

function addToCart() {
  let items

  if (JSON.parse(localStorage.getItem('items')!)) items = JSON.parse(localStorage.getItem('items')!)
  else items = new Array()

  for (const item of items) {
    if (item.product.id == product.value.id) {
      item.quantity += 1

      localStorage.setItem('items', JSON.stringify(items))
      return
    }
  }

  let data = {
    product: product.value,
    quantity: 1
  }
  items.push(new Shipment_product(data))

  localStorage.setItem('items', JSON.stringify(items))
}
</script>

<style>
.single-view {
  display: grid;
}

.single-view-image {
  height: 250px;
  width: 250px;
}
</style>
