package com.nutri.services;

import com.nutri.entities.ComidaIngrediente;
import com.nutri.repositories.ComidaIngredienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComidaIngredienteService {

    @Autowired
    private ComidaIngredienteRepository repository;

    public List<ComidaIngrediente> findAll() {
        return repository.findAll();
    }

    public Optional<ComidaIngrediente> findById(Integer id) {
        return repository.findById(id);
    }

    public ComidaIngrediente save(ComidaIngrediente comidaIngrediente) {
        return repository.save(comidaIngrediente);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
