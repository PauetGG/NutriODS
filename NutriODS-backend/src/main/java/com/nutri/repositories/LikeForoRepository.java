package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.LikeForo;
import com.nutri.entities.LikeForoId;

@Repository
public interface LikeForoRepository extends JpaRepository<LikeForo, LikeForoId> {
	long countByTemaId(Integer temaId);
    boolean existsByUsuarioIdAndTemaId(Integer usuarioId, Integer temaId);
    List<LikeForo> findByUsuarioId(Integer usuarioId);
    List<LikeForo> findByTemaId(Integer temaId);
}
