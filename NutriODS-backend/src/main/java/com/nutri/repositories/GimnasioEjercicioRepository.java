package com.nutri.repositories;

import com.nutri.entities.GimnasioEjercicio;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GimnasioEjercicioRepository extends JpaRepository<GimnasioEjercicio, Long> {
    List<GimnasioEjercicio> findBySeguimientoId(Long seguimientoId);
}
