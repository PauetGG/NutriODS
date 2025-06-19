package com.nutri.services;

import com.nutri.entities.LikeRespuestaForo;
import com.nutri.entities.LikeRespuestaForoId;
import com.nutri.repositories.LikeRespuestaForoRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

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
}
