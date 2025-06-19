package com.nutri.services;

import com.nutri.entities.ComentarioArticulo;
import com.nutri.repositories.ComentarioArticuloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComentarioArticuloService {

    @Autowired
    private ComentarioArticuloRepository comentarioRepository;

    public List<ComentarioArticulo> findAll() {
        return comentarioRepository.findAll();
    }

    public Optional<ComentarioArticulo> findById(Integer id) {
        return comentarioRepository.findById(id);
    }

    public ComentarioArticulo save(ComentarioArticulo comentario) {
        return comentarioRepository.save(comentario);
    }

    public void deleteById(Integer id) {
        comentarioRepository.deleteById(id);
    }
}
