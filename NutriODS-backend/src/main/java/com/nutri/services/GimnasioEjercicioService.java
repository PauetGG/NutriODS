package com.nutri.services;

import com.nutri.entities.GimnasioEjercicio;
import com.nutri.repositories.GimnasioEjercicioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GimnasioEjercicioService {

    private final GimnasioEjercicioRepository repository;

    public GimnasioEjercicioService(GimnasioEjercicioRepository repository) {
        this.repository = repository;
    }

    public List<GimnasioEjercicio> findBySeguimientoId(Long seguimientoId) {
        return repository.findBySeguimientoId(seguimientoId);
    }

    public GimnasioEjercicio save(GimnasioEjercicio ejercicio) {
        return repository.save(ejercicio);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
