import Address from './Address'

export default class Customer {
  id: number
  email: String
  phone_number: String
  billing_address: Address

  constructor(data: any) {
    this.id = data.id
    this.email = data.email
    this.phone_number = data.phone_number
    this.billing_address = new Address(data.billing_address)
  }
}
