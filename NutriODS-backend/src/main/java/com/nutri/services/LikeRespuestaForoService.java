package com.nutri.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.LikeRespuestaForo;
import com.nutri.entities.LikeRespuestaForoId;
import com.nutri.repositories.LikeRespuestaForoRepository;

@Service
public class LikeRespuestaForoService {

    private final LikeRespuestaForoRepository likeRespuestaRepository;

    public LikeRespuestaForoService(LikeRespuestaForoRepository likeRespuestaRepository) {
        this.likeRespuestaRepository = likeRespuestaRepository;
    }

    public Optional<LikeRespuestaForo> findById(LikeRespuestaForoId id) {
        return likeRespuestaRepository.findById(id);
    }

    public LikeRespuestaForo save(LikeRespuestaForo like) {
        return likeRespuestaRepository.save(like);
    }

    public void deleteById(LikeRespuestaForoId id) {
        likeRespuestaRepository.deleteById(id);
    }
    public long contarLikesPorRespuesta(Integer respuestaId) {
        return likeRespuestaRepository.countByRespuestaId(respuestaId);
    }

    public boolean existeLike(Integer usuarioId, Integer respuestaId) {
        return likeRespuestaRepository.existsByUsuarioIdAndRespuestaId(usuarioId, respuestaId);
    }

    public List<LikeRespuestaForo> findByUsuario(Integer usuarioId) {
        return likeRespuestaRepository.findByUsuarioId(usuarioId);
    }

    public List<LikeRespuestaForo> findByRespuesta(Integer respuestaId) {
        return likeRespuestaRepository.findByRespuestaId(respuestaId);
    }
}
