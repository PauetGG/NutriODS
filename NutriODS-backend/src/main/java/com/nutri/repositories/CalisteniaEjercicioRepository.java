package com.nutri.repositories;

import com.nutri.entities.CalisteniaEjercicio;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CalisteniaEjercicioRepository extends JpaRepository<CalisteniaEjercicio, Long> {
    List<CalisteniaEjercicio> findBySeguimientoId(Long seguimientoId);
}
