import Address from './Address'
import Shipment_product from './Shipment_product'
import Customer from './Customer'

export default class Shipment {
  id: Number
  shipmentDate: Date
  shipmentProducts: Shipment_product[]
  shipping_address: Address
  customer: Customer

  constructor(data: any) {
    this.id = data.id
    this.shipmentDate = data.date
    this.shipping_address = new Address(data.shipping_address)
    this.customer = new Customer(data.customer)

    this.shipmentProducts = []
    for (const shipment_product of data.shipmentProducts)
      this.shipmentProducts.push(new Shipment_product(shipment_product))
  }
}
