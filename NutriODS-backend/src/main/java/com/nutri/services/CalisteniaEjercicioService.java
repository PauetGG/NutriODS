package com.nutri.services;

import com.nutri.entities.CalisteniaEjercicio;
import com.nutri.repositories.CalisteniaEjercicioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalisteniaEjercicioService {

    private final CalisteniaEjercicioRepository repository;

    public CalisteniaEjercicioService(CalisteniaEjercicioRepository repository) {
        this.repository = repository;
    }

    public List<CalisteniaEjercicio> findBySeguimientoId(Long seguimientoId) {
        return repository.findBySeguimientoId(seguimientoId);
    }

    public CalisteniaEjercicio save(CalisteniaEjercicio ejercicio) {
        return repository.save(ejercicio);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
