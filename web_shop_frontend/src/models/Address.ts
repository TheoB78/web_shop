export default class Address {
    id: Number
    first_name: String
    last_name: String
    street: String
    city: String
    country: String
    postal_code: Number

    constructor(data: any) {
        this.id = data.id
        this.first_name = data.first_name
        this.last_name = data.last_name
        this.street = data.street
        this.city = data.city
        this.country = data.country
        this.postal_code = data.postal_code
    }
}