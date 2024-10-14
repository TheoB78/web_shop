package com.lap.web_shop_backend.service;

import com.lap.web_shop_backend.model.Shipment;
import com.lap.web_shop_backend.repository.ShipmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ShipmentService {
    @Autowired
    private ShipmentRepository shipmentRepository;

    public List<Shipment> findAll() {
        return shipmentRepository.findAll();
    }

    public Optional<Shipment> findById(Integer id) {
        return shipmentRepository.findById(id);
    }

    public Shipment save(Shipment shipment) {
        return shipmentRepository.save(shipment);
    }

    public List<Shipment> findByShipmentDateBetween(LocalDateTime endDate) {
        return shipmentRepository.findByShipmentDateBetween(endDate, LocalDateTime.now());
    }


}
