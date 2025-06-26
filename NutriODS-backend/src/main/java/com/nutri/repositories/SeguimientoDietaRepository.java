package com.nutri.repositories;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.SeguimientoDieta;

@Repository
public interface SeguimientoDietaRepository extends JpaRepository<SeguimientoDieta, Integer> {
	List<SeguimientoDieta> findByDietaId(Integer dietaId);
    List<SeguimientoDieta> findByFecha(LocalDate fecha);
}
