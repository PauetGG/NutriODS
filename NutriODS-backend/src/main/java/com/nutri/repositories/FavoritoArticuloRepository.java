package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.FavoritoArticulo;
import com.nutri.entities.FavoritoArticuloId;

@Repository
public interface FavoritoArticuloRepository extends JpaRepository<FavoritoArticulo, FavoritoArticuloId> {
	List<FavoritoArticulo> findByUsuarioId(Integer usuarioId);
    List<FavoritoArticulo> findByArticuloId(Integer articuloId);
    boolean existsByUsuarioIdAndArticuloId(Integer usuarioId, Integer articuloId);
    long countByArticuloId(Integer articuloId);
}
