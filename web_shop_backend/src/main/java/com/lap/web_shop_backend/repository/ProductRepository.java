package com.lap.web_shop_backend.repository;

import com.lap.web_shop_backend.model.Product;
import com.lap.web_shop_backend.model.ProductStatisticResult;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    @Query( value = "select new ProductStatisticResult(p.id, coalesce(sum(sp.quantity), 0) as amount, p.product_name, p.image_path)"
            + " from Shipment_product sp "
            + " right join sp.product p "
            + " group by p.id, p.product_name, p.image_path ")
    List<ProductStatisticResult> getTopProducts(Pageable pageable);

    @Query("select sum(sp.quantity)"
            + " from Product p, Shipment_product sp"
            + " where p.id = sp.product.id "
            + " group by p.id")
    List<Integer> getTest();
}
