package com.nutri.services;

import com.nutri.entities.RecetaIngrediente;
import com.nutri.entities.RecetaIngredienteId;
import com.nutri.repositories.RecetaIngredienteRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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
}
