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
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String email;

    private String phone_number;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "billing_address")
    private Address billing_address;

    @OneToMany(mappedBy = "customer")
    @JsonIgnore
    private List<Shipment> shipments;

    @OneToOne(mappedBy = "customer")
    @JsonIgnore
    private Account account;
}
