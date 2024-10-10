export default class Product_property {
    id: Number
    property_key: String
    property_value: String

    constructor(data: any) {
        this.id = data.id
        this.property_key = data.property_key
        this.property_value = data.property_value
    }
}
