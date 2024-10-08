package com.lap.web_shop_backend.controller;

import com.lap.web_shop_backend.model.Shipment;
import com.lap.web_shop_backend.service.ShipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ShipmentController {
    @Autowired
    private ShipmentService shipmentService;

    @GetMapping(path = "/shipments")
    public List<Shipment> getAllShipments() {
        return shipmentService.findAll();
    }

    @PostMapping(path = "/addShipment")
    public Shipment addShipment(@RequestBody Shipment shipment) {
        System.out.println(shipment.toString());
        //shipment.setShipmentProducts(shipment.getShipmentProducts());
        shipment.setCustomer(shipment.getCustomer());
        //shipment.setShipping_address(shipment.getShipping_address());
        shipment.getShipmentProducts().forEach(shipmentProduct -> shipmentProduct.setShipment(shipment));
        //List<Shipment> customersShipments = shipment.getCustomer().getShipments();
        //customersShipments.add(shipment);
        //shipment.getCustomer().setShipments(customersShipments);

        return shipmentService.save(shipment);
    }
}
