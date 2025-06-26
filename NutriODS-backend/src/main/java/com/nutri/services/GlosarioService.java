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
    public List<Glosario> findByCategoria(Glosario.Categoria categoria) {
        return repository.findByCategoria(categoria);
    }

    public List<Glosario> findAllVisible() {
        return repository.findByVisibleTrue();
    }

    public List<Glosario> searchByPalabra(String palabra) {
        return repository.findByTerminoContainingIgnoreCaseOrDefinicionContainingIgnoreCase(palabra, palabra);
    }

    public long countAll() {
        return repository.count();
    }

    public Glosario cambiarVisibilidad(Integer id, boolean visible) {
        Glosario glosario = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Glosario no encontrado"));
        glosario.setVisible(visible);
        return repository.save(glosario);
    }
}
