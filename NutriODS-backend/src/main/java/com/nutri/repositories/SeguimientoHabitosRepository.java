package com.nutri.repositories;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.nutri.entities.SeguimientoHabitos;

@Repository
public interface SeguimientoHabitosRepository extends JpaRepository<SeguimientoHabitos, Integer> {

    // Buscar todos los seguimientos de una dieta ordenados por fecha
    List<SeguimientoHabitos> findByDietaIdOrderByFechaAsc(Integer dietaId);

    // Buscar un seguimiento concreto por dieta y fecha (para evitar duplicados)
    Optional<SeguimientoHabitos> findByDietaIdAndFecha(Integer dietaId, LocalDate fecha);

    @Query("SELECT h FROM SeguimientoHabitos h WHERE h.dieta.id = :dietaId AND h.fecha >= :inicio AND h.fecha <= :fin")
    List<SeguimientoHabitos> findByDietaAndSemana(@Param("dietaId") Integer dietaId,
                                                   @Param("inicio") LocalDate inicio,
                                                   @Param("fin") LocalDate fin);
}