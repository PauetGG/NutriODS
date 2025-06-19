package com.nutri.services;

import com.nutri.entities.Receta;
import com.nutri.repositories.RecetaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RecetaService {

    private final RecetaRepository recetaRepository;

    public RecetaService(RecetaRepository recetaRepository) {
        this.recetaRepository = recetaRepository;
    }

    public List<Receta> findAll() {
        return recetaRepository.findAll();
    }

    public Optional<Receta> findById(Integer id) {
        return recetaRepository.findById(id);
    }

    public Receta save(Receta receta) {
        return recetaRepository.save(receta);
    }

    public void deleteById(Integer id) {
        recetaRepository.deleteById(id);
    }
}
