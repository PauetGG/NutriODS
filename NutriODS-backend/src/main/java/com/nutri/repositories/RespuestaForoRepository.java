package com.nutri.repositories;

import com.nutri.entities.RespuestaForo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RespuestaForoRepository extends JpaRepository<RespuestaForo, Integer> {
    // List<RespuestaForo> findByTemaId(Integer temaId);
}
