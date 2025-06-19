package com.nutri.services;

import com.nutri.entities.LikeArticulo;
import com.nutri.entities.LikeArticuloId;
import com.nutri.repositories.LikeArticuloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

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
}
