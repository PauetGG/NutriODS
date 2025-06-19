package com.nutri.services;

import com.nutri.entities.Glosario;
import com.nutri.repositories.GlosarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class GlosarioService {

    @Autowired
    private GlosarioRepository repository;

    public List<Glosario> findAll() {
        return repository.findAll();
    }

    public Optional<Glosario> findById(Integer id) {
        return repository.findById(id);
    }

    public Glosario save(Glosario glosario) {
        return repository.save(glosario);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
