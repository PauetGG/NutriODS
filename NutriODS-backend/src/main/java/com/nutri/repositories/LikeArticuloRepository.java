package com.nutri.repositories;

import com.nutri.entities.LikeArticulo;
import com.nutri.entities.LikeArticuloId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeArticuloRepository extends JpaRepository<LikeArticulo, LikeArticuloId> {
    // Optional<LikeArticulo> findByIdUsuarioIdAndIdArticuloId(Integer usuarioId, Integer articuloId);
}
