package com.nutri.services;

import com.nutri.entities.TemaForo;
import com.nutri.repositories.TemaForoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TemaForoService {

    private final TemaForoRepository temaRepository;

    public TemaForoService(TemaForoRepository temaRepository) {
        this.temaRepository = temaRepository;
    }

    public List<TemaForo> findAll() {
        return temaRepository.findAll();
    }

    public Optional<TemaForo> findById(Integer id) {
        return temaRepository.findById(id);
    }

    public TemaForo save(TemaForo tema) {
        return temaRepository.save(tema);
    }

    public void deleteById(Integer id) {
        temaRepository.deleteById(id);
    }
    public void incrementarVisitas(Integer id) {
        TemaForo tema = temaRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Tema no encontrado"));
        tema.setVisitas(tema.getVisitas() + 1);
        temaRepository.save(tema);
    }

    public void incrementarRespuestas(Integer id) {
        TemaForo tema = temaRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Tema no encontrado"));
        tema.setNumRespuestas(tema.getNumRespuestas() + 1);
        temaRepository.save(tema);
    }

    public List<TemaForo> findByUsuario(Integer usuarioId) {
        return temaRepository.findByUsuarioId(usuarioId);
    }

    public List<TemaForo> findByCategoria(TemaForo.Categoria categoria) {
        return temaRepository.findByCategoria(categoria);
    }

    public List<TemaForo> searchByPalabra(String palabra) {
        return temaRepository.findByTituloContainingIgnoreCaseOrContenidoContainingIgnoreCase(palabra, palabra);
    }
}
