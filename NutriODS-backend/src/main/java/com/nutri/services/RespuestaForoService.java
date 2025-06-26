package com.nutri.services;

import com.nutri.entities.RespuestaForo;
import com.nutri.repositories.RespuestaForoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RespuestaForoService {

    private final RespuestaForoRepository respuestaRepository;

    public RespuestaForoService(RespuestaForoRepository respuestaRepository) {
        this.respuestaRepository = respuestaRepository;
    }

    public List<RespuestaForo> findAll() {
        return respuestaRepository.findAll();
    }

    public Optional<RespuestaForo> findById(Integer id) {
        return respuestaRepository.findById(id);
    }

    public RespuestaForo save(RespuestaForo respuesta) {
        return respuestaRepository.save(respuesta);
    }

    public void deleteById(Integer id) {
        respuestaRepository.deleteById(id);
    }
    public List<RespuestaForo> findByTema(Integer temaId) {
        return respuestaRepository.findByTemaId(temaId);
    }

    public List<RespuestaForo> findByUsuario(Integer usuarioId) {
        return respuestaRepository.findByUsuarioId(usuarioId);
    }

    public void incrementarVisitas(Integer id) {
        RespuestaForo respuesta = respuestaRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Respuesta no encontrada"));
        respuesta.setVisitas(respuesta.getVisitas() + 1);
        respuestaRepository.save(respuesta);
    }

    public long contarLikes(Integer id) {
        RespuestaForo respuesta = respuestaRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Respuesta no encontrada"));
        return respuesta.getLikes().size();
    }

    public RespuestaForo actualizarContenido(Integer id, String nuevoContenido) {
        RespuestaForo respuesta = respuestaRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Respuesta no encontrada"));
        respuesta.setContenido(nuevoContenido);
        return respuestaRepository.save(respuesta);
    }
}
