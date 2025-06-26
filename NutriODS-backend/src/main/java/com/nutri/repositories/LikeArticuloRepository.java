package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.LikeArticulo;
import com.nutri.entities.LikeArticuloId;

@Repository
public interface LikeArticuloRepository extends JpaRepository<LikeArticulo, LikeArticuloId> {
	long countByArticuloId(Integer articuloId);
    boolean existsByUsuarioIdAndArticuloId(Integer usuarioId, Integer articuloId);
    List<LikeArticulo> findByUsuarioId(Integer usuarioId);
    List<LikeArticulo> findByArticuloId(Integer articuloId);
}
