package com.nutri.services;

import com.nutri.entities.Dieta;
import com.nutri.repositories.DietaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DietaService {

    private final DietaRepository dietaRepository;

    public DietaService(DietaRepository dietaRepository) {
        this.dietaRepository = dietaRepository;
    }

    public List<Dieta> findAll() {
        return dietaRepository.findAll();
    }

    public Optional<Dieta> findById(Integer id) {
        return dietaRepository.findById(id);
    }

    public Dieta save(Dieta dieta) {
        return dietaRepository.save(dieta);
    }

    public void deleteById(Integer id) {
        dietaRepository.deleteById(id);
    }
}
