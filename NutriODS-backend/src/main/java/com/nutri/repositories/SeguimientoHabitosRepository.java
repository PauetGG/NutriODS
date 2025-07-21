package com.nutri.repositories;

import com.nutri.entities.SeguimientoHabitos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface SeguimientoHabitosRepository extends JpaRepository<SeguimientoHabitos, Integer> {

    // Buscar todos los seguimientos de una dieta ordenados por fecha
    List<SeguimientoHabitos> findByDietaIdOrderByFechaAsc(Integer dietaId);

    // Buscar un seguimiento concreto por dieta y fecha (para evitar duplicados)
    Optional<SeguimientoHabitos> findByDietaIdAndFecha(Integer dietaId, LocalDate fecha);

    // Puedes añadir más métodos según tus necesidades
}