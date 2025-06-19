package com.nutri.services;

import com.nutri.entities.Multimedia;
import com.nutri.repositories.MultimediaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MultimediaService {

    @Autowired
    private MultimediaRepository repository;

    public List<Multimedia> findAll() {
        return repository.findAll();
    }

    public Optional<Multimedia> findById(Integer id) {
        return repository.findById(id);
    }

    public Multimedia save(Multimedia multimedia) {
        return repository.save(multimedia);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
