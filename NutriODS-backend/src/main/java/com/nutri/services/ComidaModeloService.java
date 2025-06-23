package com.nutri.services;

import com.nutri.entities.ComidaModelo;
import com.nutri.repositories.ComidaModeloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComidaModeloService {

    @Autowired
    private ComidaModeloRepository repository;

    public List<ComidaModelo> findAll() {
        return repository.findAll();
    }

    public Optional<ComidaModelo> findById(Integer id) {
        return repository.findById(id);
    }

    public ComidaModelo save(ComidaModelo comidaModelo) {
        return repository.save(comidaModelo);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
