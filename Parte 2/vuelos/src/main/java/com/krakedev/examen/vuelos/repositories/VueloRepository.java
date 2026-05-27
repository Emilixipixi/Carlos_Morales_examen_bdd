package com.krakedev.examen.vuelos.repositories;

import com.krakedev.examen.vuelos.entities.Vuelo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.util.List;

@Repository
public interface VueloRepository extends JpaRepository<Vuelo, Long> {
    List<Vuelo> findByPrecioBoletoLessThan(BigDecimal precio);
}