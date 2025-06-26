package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.ComentarioArticulo;

@Repository
public interface ComentarioArticuloRepository extends JpaRepository<ComentarioArticulo, Integer> {
	List<ComentarioArticulo> findByArticuloId(Integer articuloId);
    List<ComentarioArticulo> findByUsuarioId(Integer usuarioId);
    long countByArticuloId(Integer articuloId);
    void deleteByArticuloId(Integer articuloId);

}
