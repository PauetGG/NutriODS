package com.nutri.services;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.RecetaIngrediente;
import com.nutri.entities.RecetaIngredienteId;
import com.nutri.repositories.RecetaIngredienteRepository;

@Service
public class RecetaIngredienteService {

    private final RecetaIngredienteRepository recetaIngredienteRepository;

    public RecetaIngredienteService(RecetaIngredienteRepository recetaIngredienteRepository) {
        this.recetaIngredienteRepository = recetaIngredienteRepository;
    }

    public List<RecetaIngrediente> findAll() {
        return recetaIngredienteRepository.findAll();
    }

    public Optional<RecetaIngrediente> findById(RecetaIngredienteId id) {
        return recetaIngredienteRepository.findById(id);
    }

    public RecetaIngrediente save(RecetaIngrediente recetaIngrediente) {
        return recetaIngredienteRepository.save(recetaIngrediente);
    }

    public void deleteById(RecetaIngredienteId id) {
        recetaIngredienteRepository.deleteById(id);
    }
    public List<RecetaIngrediente> findByReceta(Integer recetaId) {
        return recetaIngredienteRepository.findByRecetaId(recetaId);
    }

    public List<RecetaIngrediente> findByIngrediente(Integer ingredienteId) {
        return recetaIngredienteRepository.findByIngredienteId(ingredienteId);
    }

    public BigDecimal totalCantidadIngrediente(Integer ingredienteId) {
        return recetaIngredienteRepository.findByIngredienteId(ingredienteId).stream()
            .map(RecetaIngrediente::getCantidad)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public RecetaIngrediente actualizarCantidad(RecetaIngredienteId id, BigDecimal nuevaCantidad) {
        RecetaIngrediente ri = recetaIngredienteRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("RecetaIngrediente no encontrado"));
        ri.setCantidad(nuevaCantidad);
        return recetaIngredienteRepository.save(ri);
    }
}
