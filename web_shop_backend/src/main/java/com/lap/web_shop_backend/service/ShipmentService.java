package com.lap.web_shop_backend.service;

import com.lap.web_shop_backend.model.Shipment;
import com.lap.web_shop_backend.repository.ShipmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShipmentService {
    @Autowired
    private ShipmentRepository shipmentRepository;

    public List<Shipment> findAll() {
        return shipmentRepository.findAll();
    }

    public Shipment save(Shipment shipment) {
        return shipmentRepository.save(shipment);
    }
}
