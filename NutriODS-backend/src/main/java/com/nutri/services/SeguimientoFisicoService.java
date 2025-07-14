package com.nutri.services;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.SeguimientoFisico;
import com.nutri.repositories.SeguimientoFisicoRepository;

@Service
public class SeguimientoFisicoService {

    private final SeguimientoFisicoRepository repository;

    public SeguimientoFisicoService(SeguimientoFisicoRepository repository) {
        this.repository = repository;
    }

    public List<SeguimientoFisico> findAll() {
        return repository.findAll();
    }

    public Optional<SeguimientoFisico> findById(Long id) {
        return repository.findById(id);
    }

    public SeguimientoFisico save(SeguimientoFisico seguimiento) {
        return repository.save(seguimiento);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
    
    public Optional<SeguimientoFisico> findByDietaIdAndFecha(Integer dietaId, LocalDate fecha) {
        return repository.findByDietaIdAndFecha(dietaId, fecha);
    }


}
