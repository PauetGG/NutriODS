package com.nutri.services;

import com.nutri.entities.LikeForo;
import com.nutri.entities.LikeForoId;
import com.nutri.repositories.LikeForoRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

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
}
