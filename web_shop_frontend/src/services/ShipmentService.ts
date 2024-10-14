import Shipment from '@/models/Shipment'
import axios from 'axios'

export default class ShipmentService {
  baseHref = 'http://localhost:8080'

  async addShipment(shipment: Shipment) {
    try {
      await axios
        .post(`${this.baseHref}/addShipment`, shipment)
        .then((response) => {
          alert(response.data)
        })
        .catch((error) => {
          alert(`Error message: ${error.message}\nCode: ${error.code}`)
        })
    } catch (error: any) {
      alert(`Error message: ${error.message}\nCode: ${error.code}`)
    }
  }

  async getShipmentById(id: Number) {
    let shipment
    try {
      await axios
        .get(`${this.baseHref}/shipment`, { params: { id: id } })
        .then((response) => {
          shipment = new Shipment(response.data)
        })
        .catch((error) => {
          console.log(error)
          alert(`Error message: ${error.message}\nCode: ${error.code}`)
        })
    } catch (error: any) {
      alert(`Error message: ${error.message}\nCode: ${error.code}`)
    }
    return shipment
  }

  async getShipmentAfterDays(days: number) {
    const shipments: Shipment[] = []
    try {
      await axios
        .get(`${this.baseHref}/shipmentAfterDate`, { params: { days: days } })
        .then((response) => {
          for (const shipment of response.data) shipments.push(new Shipment(shipment))
        })
        .catch((error) => {
          console.log(error)
          alert(`Error message: ${error.message}\nCode: ${error.code}`)
        })
    } catch (error: any) {
      alert(`Error message: ${error.message}\nCode: ${error.code}`)
    }
    console.log(shipments)
    return shipments
  }
}
