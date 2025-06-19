package com.nutri.services;

import com.nutri.entities.SeguimientoDieta;
import com.nutri.repositories.SeguimientoDietaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SeguimientoDietaService {

    private final SeguimientoDietaRepository seguimientoRepository;

    public SeguimientoDietaService(SeguimientoDietaRepository seguimientoRepository) {
        this.seguimientoRepository = seguimientoRepository;
    }

    public List<SeguimientoDieta> findAll() {
        return seguimientoRepository.findAll();
    }

    public Optional<SeguimientoDieta> findById(Integer id) {
        return seguimientoRepository.findById(id);
    }

    public SeguimientoDieta save(SeguimientoDieta seguimiento) {
        return seguimientoRepository.save(seguimiento);
    }

    public void deleteById(Integer id) {
        seguimientoRepository.deleteById(id);
    }
}
