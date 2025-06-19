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
}
