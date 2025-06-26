package com.nutri.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.LikeForo;
import com.nutri.entities.LikeForoId;
import com.nutri.repositories.LikeForoRepository;

@Service
public class LikeForoService {

    private final LikeForoRepository likeRepository;

    public LikeForoService(LikeForoRepository likeRepository) {
        this.likeRepository = likeRepository;
    }

    public Optional<LikeForo> findById(LikeForoId id) {
        return likeRepository.findById(id);
    }

    public LikeForo save(LikeForo like) {
        return likeRepository.save(like);
    }

    public void deleteById(LikeForoId id) {
        likeRepository.deleteById(id);
    }
    public long contarLikesPorTema(Integer temaId) {
        return likeRepository.countByTemaId(temaId);
    }

    public boolean existeLike(Integer usuarioId, Integer temaId) {
        return likeRepository.existsByUsuarioIdAndTemaId(usuarioId, temaId);
    }

    public List<LikeForo> findByUsuario(Integer usuarioId) {
        return likeRepository.findByUsuarioId(usuarioId);
    }

    public List<LikeForo> findByTema(Integer temaId) {
        return likeRepository.findByTemaId(temaId);
    }
}
