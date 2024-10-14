<template>
  <div class="view"></div>
  <div v-if="!shipment">Nicht gefunden</div>
  <div v-else>
    {{ shipment }}
  </div>
</template>

<script setup lang="ts">
import ShipmentService from '@/services/ShipmentService'
import Shipment from '@/models/Shipment'
import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'

let route = useRoute()
let shipment = ref()
let shipmentService = new ShipmentService()

onMounted(() => {
  getShipmentById(route.params.id)
})

function getShipmentById(id: number) {
  shipmentService.getShipmentById(id).then((response) => (shipment.value = response))
}
</script>
