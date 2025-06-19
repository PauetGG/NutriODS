package com.nutri.services;

import com.nutri.entities.FavoritoArticulo;
import com.nutri.entities.FavoritoArticuloId;
import com.nutri.repositories.FavoritoArticuloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FavoritoArticuloService {

    @Autowired
    private FavoritoArticuloRepository favoritoRepository;

    public Optional<FavoritoArticulo> findById(FavoritoArticuloId id) {
        return favoritoRepository.findById(id);
    }

    public FavoritoArticulo save(FavoritoArticulo favorito) {
        return favoritoRepository.save(favorito);
    }

    public void deleteById(FavoritoArticuloId id) {
        favoritoRepository.deleteById(id);
    }
}
