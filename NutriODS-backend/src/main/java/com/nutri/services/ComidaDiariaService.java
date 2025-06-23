package com.nutri.services;

import com.nutri.entities.ComidaDiaria;
import com.nutri.repositories.ComidaDiariaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComidaDiariaService {

    @Autowired
    private ComidaDiariaRepository repository;

    public List<ComidaDiaria> findAll() {
        return repository.findAll();
    }

    public Optional<ComidaDiaria> findById(Integer id) {
        return repository.findById(id);
    }

    public ComidaDiaria save(ComidaDiaria comidaDiaria) {
        return repository.save(comidaDiaria);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
