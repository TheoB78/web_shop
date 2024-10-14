package com.lap.web_shop_backend.repository;

import com.lap.web_shop_backend.model.Shipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ShipmentRepository extends JpaRepository<Shipment, Integer> {



    List<Shipment> findByShipmentDateBetween(LocalDateTime startDate, LocalDateTime endDate);

}
