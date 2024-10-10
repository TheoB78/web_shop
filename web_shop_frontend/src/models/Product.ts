import Product_property from "./Product_property"

export default class Product {
    id: Number
    product_name: String
    price: Number
    description: String
    image_path: String
    properties: Product_property[]

    constructor(data: any) {
        this.id = data.id
        this.product_name = data.product_name
        this.price = data.price
        this.description = data.description
        this.image_path = data.image_path
        this.properties = new Array<Product_property>

        for(const property of data.properties)
            this.properties.push(new Product_property(property))
    }
}