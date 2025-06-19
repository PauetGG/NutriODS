package com.nutri.repositories;

import com.nutri.entities.LikeRespuestaForo;
import com.nutri.entities.LikeRespuestaForoId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeRespuestaForoRepository extends JpaRepository<LikeRespuestaForo, LikeRespuestaForoId> {
    // Optional<LikeRespuestaForo> findByIdUsuarioIdAndIdRespuestaId(Integer usuarioId, Integer respuestaId);
}
