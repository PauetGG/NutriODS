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
}
