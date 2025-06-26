package com.nutri.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.entities.LikeArticulo;
import com.nutri.entities.LikeArticuloId;
import com.nutri.repositories.LikeArticuloRepository;

@Service
public class LikeArticuloService {

    @Autowired
    private LikeArticuloRepository likeRepository;

    public Optional<LikeArticulo> findById(LikeArticuloId id) {
        return likeRepository.findById(id);
    }

    public LikeArticulo save(LikeArticulo like) {
        return likeRepository.save(like);
    }

    public void deleteById(LikeArticuloId id) {
        likeRepository.deleteById(id);
    }
    public long contarLikesPorArticulo(Integer articuloId) {
        return likeRepository.countByArticuloId(articuloId);
    }

    public boolean existeLike(Integer usuarioId, Integer articuloId) {
        return likeRepository.existsByUsuarioIdAndArticuloId(usuarioId, articuloId);
    }

    public List<LikeArticulo> findByUsuario(Integer usuarioId) {
        return likeRepository.findByUsuarioId(usuarioId);
    }

    public List<LikeArticulo> findByArticulo(Integer articuloId) {
        return likeRepository.findByArticuloId(articuloId);
    }
}
