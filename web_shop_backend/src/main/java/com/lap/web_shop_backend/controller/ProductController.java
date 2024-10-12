package com.lap.web_shop_backend.controller;

import com.lap.web_shop_backend.model.Product;
import com.lap.web_shop_backend.model.ProductStatisticResult;
import com.lap.web_shop_backend.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping(path = "/products")
    public List<Product> getAllProducts() {
        return productService.findAll();
    }

    @GetMapping(path = "product")
    public Optional<Product> getProductById(@RequestParam Integer id) {
        Optional<Product> product = productService.findById(id);
        return product;
    }

    @PostMapping(path = "addProduct")
    public Product addProduct(@RequestBody Product product) {
        product.getProperties().forEach(property -> property.setProduct(product));

        return productService.save(product);
    }

    @GetMapping(path = "/topProducts")
    public List<ProductStatisticResult> getTopProducts(@RequestParam(required = false) boolean ascending, @RequestParam(required = false) Integer limit, @RequestParam(required = false) Integer offset) {
        return productService.getTopProducts(ascending, limit, offset);
    }

    @GetMapping(path = "/getTest")
    public List<Integer> getTest() {
        return productService.getTest();
    }
}
