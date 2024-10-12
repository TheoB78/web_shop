package com.lap.web_shop_backend.service;

import com.lap.web_shop_backend.model.Product;
import com.lap.web_shop_backend.model.ProductStatisticResult;
import com.lap.web_shop_backend.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public Optional<Product> findById(Integer id) {
        return productRepository.findById(id);
    }

    public Product save(Product product) {
        return productRepository.save(product);
    }

    public List<ProductStatisticResult> getTopProducts(boolean ascending, Integer limit, Integer offset) {
        Sort sort;

        if(ascending)
            sort = Sort.by(Sort.Direction.ASC, "amount");
        else
            sort = Sort.by(Sort.Direction.DESC, "amount");

        if (limit == null)
            limit = 100;

        if (offset == null)
            offset = 0;

        Pageable pageable;
        pageable = PageRequest.of(offset, limit, sort);

        return productRepository.getTopProducts(pageable);
    }

    public List<Integer> getTest() {
        return productRepository.getTest();
    }
}
