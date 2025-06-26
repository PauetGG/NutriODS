package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.RespuestaForo;

@Repository
public interface RespuestaForoRepository extends JpaRepository<RespuestaForo, Integer> {
	List<RespuestaForo> findByTemaId(Integer temaId);
    List<RespuestaForo> findByUsuarioId(Integer usuarioId);
}
