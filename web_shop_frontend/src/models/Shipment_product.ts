import Product from './Product'

export default class Shipment_product {
  id: Number
  product: Product
  quantity: Number

  constructor(data: any) {
    this.id = data.id
    this.product = new Product(data.product)
    this.quantity = data.quantity
  }
}
