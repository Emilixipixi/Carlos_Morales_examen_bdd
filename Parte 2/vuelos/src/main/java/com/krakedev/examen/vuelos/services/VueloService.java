package com.krakedev.examen.vuelos.services;

import com.krakedev.examen.vuelos.entities.Vuelo;
import com.krakedev.examen.vuelos.repositories.VueloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class VueloService {

    @Autowired
    private VueloRepository vueloRepository;

    public Vuelo insertar(Vuelo vuelo) {
        return vueloRepository.save(vuelo);
    }

    public List<Vuelo> listarTodos() {
        return vueloRepository.findAll();
    }

    public Optional<Vuelo> buscarPorId(Long id) {
        return vueloRepository.findById(id);
    }

    public Vuelo actualizar(Long id, Vuelo vueloDetalles) {
        return vueloRepository.findById(id).map(vuelo -> {
            vuelo.setCodigo(vueloDetalles.getCodigo());
            vuelo.setPrecioBoleto(vueloDetalles.getPrecioBoleto());
            vuelo.setAsientosDisponibles(vueloDetalles.getAsientosDisponibles());
            return vueloRepository.save(vuelo);
        }).orElseThrow(() -> new RuntimeException("Vuelo no encontrado"));
    }

    public void eliminar(Long id) {
        if (vueloRepository.existsById(id)) {
            vueloRepository.deleteById(id);
        } else {
            throw new RuntimeException("Vuelo no encontrado");
        }
    }

    public List<Vuelo> buscarPorPrecioMenor(BigDecimal precio) {
        return vueloRepository.findByPrecioBoletoLessThan(precio);
    }
}