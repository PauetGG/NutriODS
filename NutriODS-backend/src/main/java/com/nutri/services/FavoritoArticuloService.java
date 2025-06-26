package com.nutri.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.entities.FavoritoArticulo;
import com.nutri.entities.FavoritoArticuloId;
import com.nutri.repositories.FavoritoArticuloRepository;

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
    public List<FavoritoArticulo> findByUsuario(Integer usuarioId) {
        return favoritoRepository.findByUsuarioId(usuarioId);
    }

    public List<FavoritoArticulo> findByArticulo(Integer articuloId) {
        return favoritoRepository.findByArticuloId(articuloId);
    }

    public boolean existeFavorito(Integer usuarioId, Integer articuloId) {
        return favoritoRepository.existsByUsuarioIdAndArticuloId(usuarioId, articuloId);
    }

    public long contarFavoritosPorArticulo(Integer articuloId) {
        return favoritoRepository.countByArticuloId(articuloId);
    }
}
