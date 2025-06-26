package com.nutri.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.Receta;

@Repository
public interface RecetaRepository extends JpaRepository<Receta, Integer> {
	List<Receta> findByVisibleTrue();

    List<Receta> findByDificultad(Receta.Dificultad dificultad);

    List<Receta> findByNombreContainingIgnoreCase(String palabra);

    List<Receta> findByTiempoPreparacionLessThanEqual(Integer minutos);

    List<Receta> findByCreadoAfter(LocalDateTime fechaLimite);

    long countByDificultad(Receta.Dificultad dificultad);
}
