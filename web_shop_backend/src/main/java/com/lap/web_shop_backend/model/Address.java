package com.lap.web_shop_backend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String first_name;

    private String last_name;

    private String street;

    private String city;

    private String country;

    private Integer postal_code;

    @OneToMany(mappedBy = "billing_address")
    @JsonIgnore
    private List<Customer> customers;

    @OneToMany(mappedBy = "shipping_address")
    @JsonIgnore
    private List<Shipment> shipments;
}
