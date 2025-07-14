package com.nutri.repositories;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nutri.entities.SeguimientoFisico;

public interface SeguimientoFisicoRepository extends JpaRepository<SeguimientoFisico, Long> {
	Optional<SeguimientoFisico> findByDietaIdAndFecha(Integer dietaId, LocalDate fecha);
}
