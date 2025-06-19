package com.nutri.repositories;

import com.nutri.entities.ComentarioArticulo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComentarioArticuloRepository extends JpaRepository<ComentarioArticulo, Integer> {
    // List<ComentarioArticulo> findByArticuloId(Integer articuloId);
}
