package com.nutri.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.Ingrediente;
import com.nutri.repositories.IngredienteRepository;

@Service
public class IngredienteService {

    private final IngredienteRepository ingredienteRepository;

    public IngredienteService(IngredienteRepository ingredienteRepository) {
        this.ingredienteRepository = ingredienteRepository;
    }

    public List<Ingrediente> findAll() {
        return ingredienteRepository.findAll();
    }

    public Optional<Ingrediente> findById(Integer id) {
        return ingredienteRepository.findById(id);
    }

    public Ingrediente save(Ingrediente ingrediente) {
        return ingredienteRepository.save(ingrediente);
    }

    public void deleteById(Integer id) {
        ingredienteRepository.deleteById(id);
    }
}
