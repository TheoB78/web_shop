package com.lap.web_shop_backend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String product_name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    private String description;

    private String image_path;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<Product_property> properties;

    @OneToMany(mappedBy = "product")
    @JsonIgnore
    private List<Shipment_product> shipmentProducts;
}
