package com.nutri.repositories;

import com.nutri.entities.LikeForo;
import com.nutri.entities.LikeForoId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeForoRepository extends JpaRepository<LikeForo, LikeForoId> {
    // Optional<LikeForo> findByIdUsuarioIdAndIdTemaId(Integer usuarioId, Integer temaId);
}
