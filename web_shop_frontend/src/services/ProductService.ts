import Product from "@/models/Product"
import axios from 'axios'

export default class ProductService {
    baseHref = 'http://localhost:8080'

    async getAllProducts() {
        const products: Product[] = []
    
        try {
          await axios
            .get(`${this.baseHref}/products`)
            .then((response) => {
              for (const item of response.data) {
                products.push(new Product(item))
              }
            })
            .catch((error) => {
              alert(`Error message: ${error.message}\nCode: ${error.code}`)
            })
        } catch (error: any) {
          alert(`Error message: ${error.message}\nCode: ${error.code}`)
        }
        return products;
      }

      async getProductById(id: Number) {
        let product
        try {
          await axios
            .get(`${this.baseHref}/product`, { params: { id: id } })
            .then((response) => {
              product = new Product(response.data)
            })
            .catch((error) => {
              console.log(error)
              alert(`Error message: ${error.message}\nCode: ${error.code}`)
            })
        } catch (error: any) {
          alert(`Error message: ${error.message}\nCode: ${error.code}`)
        }
        return product
      }
}