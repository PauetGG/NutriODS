package com.nutri.repositories;

import com.nutri.entities.FavoritoArticulo;
import com.nutri.entities.FavoritoArticuloId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FavoritoArticuloRepository extends JpaRepository<FavoritoArticulo, FavoritoArticuloId> {
    // Optional<FavoritoArticulo> findByIdUsuarioIdAndIdArticuloId(Integer usuarioId, Integer articuloId);
}
