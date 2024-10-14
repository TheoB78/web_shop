package com.lap.web_shop_backend.controller;

import com.lap.web_shop_backend.model.Shipment;
import com.lap.web_shop_backend.service.ShipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
public class ShipmentController {
    @Autowired
    private ShipmentService shipmentService;

    @GetMapping(path = "/shipments")
    public List<Shipment> getAllShipments() {
        return shipmentService.findAll();
    }

    @GetMapping(path = "/shipment")
    public Optional<Shipment> getShipmentById(@RequestParam Integer id) {
        return shipmentService.findById(id);
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

    @GetMapping(path = "/shipmentAfterDate")
    public List<Shipment> getShipmentAfterDays(@RequestParam Integer days) {
        return shipmentService.findByShipmentDateBetween(LocalDateTime.now().minusDays(days));
    }
}
