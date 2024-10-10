<template>
  <HeaderComponent />
  <div class="view">
    <h1>Warenkorb</h1>
    <!-- <button type="button" class="btn btn-primary" @click="getItems">Teste</button> -->
    <!-- <button type="button" class="btn btn-primary" @click="debugItems">Teste</button> -->
    <div v-if="!cart_items">Ladet</div>
    <div v-else-if="!cart_items.length">Einkaufswagen leer</div>
    <div v-else>
      <div v-bind:key="item.product" v-for="item in cart_items" class="row item-row">
        <div class="col-md-3">
          <img class="img-fluid" :src="`/src/assets/${item.product.image_path}`" />
        </div>
        <div class="col-md-6">
          <h4>{{ item.product.product_name }}</h4>
          <h5 class="">{{ item.product.price }} €</h5>
          <div class="row">
            <label for="quantity" class="col-sm-1 col-form-label">Anzahl:</label>
            <div class="col-md-2">
              <input
                v-model="item.quantity"
                type="number"
                class="form-control"
                id="quantity"
                placeholder="Bitte Angeben"
                min="1"
              />
            </div>
          </div>
          <div class="row">
            <button
              type="button"
              class="col-md-2 btn btn-primary"
              @click="removeFromCart(item.product)"
            >
              Entfernen
            </button>
          </div>
        </div>
      </div>

      <button type="button" class="btn btn-primary" @click="showModal">Bestellen</button>

      <h3>Gesamtkosten: {{ totalCosts.toFixed(2) }} €</h3>
    </div>
    <div class="modal" tabindex="-1" role="dialog" v-if="isModalVisible">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Modal title</h5>
            <button type="button" class="close" @click="hideModal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <p>This is a Bootstrap modal in Vue.js!</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="hideModal">Close</button>
            <button type="button" class="btn btn-primary">Bestellung abschließen</button>
          </div>
        </div>
      </div>
      <div class="modal-backdrop fade" @click="hideModal"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import HeaderComponent from '@/components/HeaderComponent.vue'
import { ref, onMounted, computed } from 'vue'
import ProductService from '@/services/ProductService'
import Product from '@/models/Product'
import Shipment_product from '@/models/Shipment_product'
import Shipment from '@/models/Shipment'
import ShipmentService from '@/services/ShipmentService'

let cart_items = ref(new Array())
const shipmentService = new ShipmentService()
let isModalVisible = ref(false)

onMounted(() => {
  getItems()
})

//gets all items for the shopping cart
function getItems() {
  if (!localStorage.getItem('items')) {
    return
  }
  // creates a json object from the localstorage string of all the cart items
  for (let item of JSON.parse(localStorage.getItem('items')!)) {
    // adds Shipment_item object to reactive list of cart items
    cart_items.value.push(new Shipment_product(item))
  }
}

function orderItems() {
  let shipment
  let data = {
    date: new Date(),
    shipment_items: cart_items.value
  }

  shipment = new Shipment(data)

  shipmentService.addShipment(shipment)
  console.log(shipment)
}

// calculates total cost of items and their quantity
// in reactive variable
const totalCosts = computed(() => {
  let costs = 0
  // multiplies each cart item with its quantity
  for (const item of cart_items.value) {
    costs += item.product.price * item.quantity
  }
  return costs
})

function removeFromCart(product: Product) {
  cart_items.value = cart_items.value.filter((item) => item.product.id !== product.id)

  localStorage.setItem('items', JSON.stringify(cart_items.value))
}

//shows modal dialog
function showModal() {
  isModalVisible.value = true
}

// hides modal dialog
function hideModal() {
  isModalVisible.value = false
}
</script>

<style>
.item-row {
  border-bottom: solid 1px grey;
  margin-bottom: 30px;
}
.price {
  float: right;
}
.modal {
  display: block; /* Show the modal */
  background: rgba(0, 0, 0, 0.5); /* Background overlay */
}
</style>
