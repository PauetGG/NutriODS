package com.nutri.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.entities.Multimedia;
import com.nutri.repositories.MultimediaRepository;

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
    
    public List<Multimedia> findByTipo(String tipo) {
        return repository.findByTipo(tipo);
    }

    public List<Multimedia> findByCategoria(String categoria) {
        return repository.findByCategoria(categoria);
    }

    public List<Multimedia> findByFechaAfter(LocalDateTime fecha) {
        return repository.findByCreadoAfter(fecha);
    }

    public long countByTipo(String tipo) {
        return repository.countByTipo(tipo);
    }

    public List<Multimedia> findAllVisible() {
        return repository.findByVisibleTrue();
    }

    public List<Multimedia> searchByPalabra(String palabra) {
        return repository.findByTituloContainingIgnoreCaseOrDescripcionContainingIgnoreCase(palabra, palabra);
    }
}
