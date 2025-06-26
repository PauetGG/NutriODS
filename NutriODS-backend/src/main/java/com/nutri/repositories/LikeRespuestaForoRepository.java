package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.LikeRespuestaForo;
import com.nutri.entities.LikeRespuestaForoId;

@Repository
public interface LikeRespuestaForoRepository extends JpaRepository<LikeRespuestaForo, LikeRespuestaForoId> {
	long countByRespuestaId(Integer respuestaId);
    boolean existsByUsuarioIdAndRespuestaId(Integer usuarioId, Integer respuestaId);
    List<LikeRespuestaForo> findByUsuarioId(Integer usuarioId);
    List<LikeRespuestaForo> findByRespuestaId(Integer respuestaId);
}
