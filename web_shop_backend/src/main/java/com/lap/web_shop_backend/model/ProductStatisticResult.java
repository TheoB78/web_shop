package com.lap.web_shop_backend.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

class IdClass {
    private Integer product_id;
    private Integer shipment_product_id;

    public IdClass(Integer product_id, Integer shipment_product_id) {
        this.product_id = product_id;
        this.shipment_product_id = shipment_product_id;
    }
}
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@jakarta.persistence.IdClass(IdClass.class)
public class ProductStatisticResult {
    @Id
    private Integer product_id;

    @Id
    private Integer shipment_product_id;

    private Long amount;

    private String product_name;

    private String image_path;
}
