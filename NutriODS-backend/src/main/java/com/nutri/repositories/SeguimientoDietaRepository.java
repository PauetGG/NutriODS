package com.nutri.repositories;

import com.nutri.entities.SeguimientoDieta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SeguimientoDietaRepository extends JpaRepository<SeguimientoDieta, Integer> {
    // Ej: List<SeguimientoDieta> findByDietaId(Integer dietaId);
}
