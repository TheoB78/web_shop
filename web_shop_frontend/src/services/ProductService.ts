import Product from '@/models/Product'
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
    return products
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

  async getProductStatistics(ascending: boolean = false, limit: Number = 5, offset: Number = 0) {
    let results = {}

    try {
      await axios
        .get(`${this.baseHref}/topProducts`, {
          params: { ascending: ascending, limit: limit, offset: offset }
        })
        .then((response) => {
          results = response
        })
        .catch((error) => {
          console.log(error)
          alert(`Error message: ${error.message}\nCode: ${error.code}`)
        })
    } catch (error: any) {
      alert(`Error message: ${error.message}\nCode: ${error.code}`)
    }
    return results
  }
}
