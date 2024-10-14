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
            <label for="quantity" class="col-form-label">Anzahl:</label>
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
            <button
              type="button"
              class="col-md-2 btn btn-danger"
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
          <form @submit.prevent="orderItems" novalidate>
            <div class="modal-header">
              <h5 class="modal-title">Bestellung</h5>
            </div>

            <div class="modal-body">
              <h5>Lieferaddresse</h5>
              <label for="addressCheckbox">Als Rechnungsaddresse übernehmen</label>
              <input
                class="form-check-input"
                style="display: block"
                type="checkbox"
                v-model="useShippingAddressAsBillingAddress"
                id="addressCheckbox"
              />
              <label for="first_name">Vorname:</label>
              <input
                v-model="shipping_address.first_name"
                id="first_name"
                type="text"
                class="form-control"
                required
              />
              <label for="last_name">Nachname:</label>
              <input
                v-model="shipping_address.last_name"
                id="last_name"
                type="text"
                class="form-control"
                required
              />
              <label for="street">Straße:</label>
              <input
                v-model="shipping_address.street"
                id="street"
                type="text"
                class="form-control"
                required
              />
              <label for="city">Stadt:</label>
              <input
                v-model="shipping_address.city"
                id="city"
                type="text"
                class="form-control"
                required
              />
              <label for="country">Land:</label>
              <input
                v-model="shipping_address.country"
                id="country"
                type="text"
                class="form-control"
                required
              />
              <label for="postal_code">PLZ:</label>
              <input
                v-model="shipping_address.postal_code"
                id="postal_code"
                type="text"
                class="form-control"
                required
              />
              <div v-if="!useShippingAddressAsBillingAddress">
                <h5>Zahlungsaddresse</h5>
                <label for="first_name">Vorname:</label>
                <input
                  v-model="billing_address.first_name"
                  id="first_name"
                  type="text"
                  class="form-control"
                  required
                />
                <label for="last_name">Nachname:</label>
                <input
                  v-model="billing_address.last_name"
                  id="last_name"
                  type="text"
                  class="form-control"
                  required
                />
                <label for="street">Straße:</label>
                <input
                  v-model="billing_address.street"
                  id="street"
                  type="text"
                  class="form-control"
                  required
                />
                <label for="city">Stadt:</label>
                <input
                  v-model="billing_address.city"
                  id="city"
                  type="text"
                  class="form-control"
                  required
                />
                <label for="country">Land:</label>
                <input
                  v-model="billing_address.country"
                  id="country"
                  type="text"
                  class="form-control"
                  required
                />
                <label for="postal_code">PLZ:</label>
                <input
                  v-model="billing_address.postal_code"
                  id="postal_code"
                  type="text"
                  class="form-control"
                  required
                />
              </div>
              <label for="email">Email:</label>
              <input
                v-model="customer.email"
                id="email"
                type="email"
                class="form-control"
                required
              />
              <label for="phone">Telefonnummer:</label>
              <input
                v-model="customer.phone_number"
                id="phone"
                type="tel"
                class="form-control"
                required
              />
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" @click="hideModal">schließen</button>
              <button type="submit" class="btn btn-primary">Bestellung abschließen</button>
            </div>
          </form>
        </div>
      </div>
      <div class="fade" @click="hideModal"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import HeaderComponent from '@/components/HeaderComponent.vue'
import { ref, onMounted, computed } from 'vue'
import Product from '@/models/Product'
import Shipment_product from '@/models/Shipment_product'
import Shipment from '@/models/Shipment'
import ShipmentService from '@/services/ShipmentService'
import Address from '@/models/Address'
import Customer from '@/models/Customer'

let cart_items = ref(new Array())
const shipmentService = new ShipmentService()
let isModalVisible = ref(false)
let useShippingAddressAsBillingAddress = ref(true)

let customer = ref({
  email: '',
  phone_number: '',
  billing_address: {}
})

let shipping_address = ref({
  first_name: '',
  last_name: '',
  street: '',
  city: '',
  country: '',
  postal_code: ''
})

let billing_address = ref({
  first_name: '',
  last_name: '',
  street: '',
  city: '',
  country: '',
  postal_code: ''
})

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
  for (const input in shipping_address.value) {
    if (shipping_address.value[input].length == 0) {
      alert('Bitte alle Felder ausfüllen')
      return
    }
  }

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

  if (!emailRegex.test(customer.value.email.toLowerCase())) {
    alert('Ungültige Email-Addresse')
    return
  }

  const phoneRegex = /^\+?[0-9\s\-$$]+$/

  if (!phoneRegex.test(customer.value.phone_number)) {
    alert('Ungültige Telephonnummer')
    return
  }

  if (!useShippingAddressAsBillingAddress.value) {
    for (const input in billing_address.value) {
      if (billing_address.value[input].length == 0) {
        alert('Bitte alle Felder ausfüllen')
        return
      }
    }
    customer.value.billing_address = billing_address
  } else customer.value.billing_address = shipping_address.value

  let data = {
    shipmentProducts: [],
    shipping_address: new Address(shipping_address.value),
    customer: new Customer(customer.value)
  }

  for (const shipmentProduct of cart_items.value) {
    data.shipmentProducts.push(new Shipment_product(shipmentProduct))
  }

  const shipment = new Shipment(data)

  shipmentService.addShipment(shipment).then((response) => {
    console.log(response)
    alert('Bestellung abgeschlossen')
    localStorage.clear()
  })
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

//removes passed product from cart
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
.price {
  float: right;
}
.modal {
  display: block; /* Show the modal */
  background: rgba(0, 0, 0, 0.5); /* Background overlay */
}
</style>
