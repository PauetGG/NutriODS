package com.nutri.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.Multimedia;

@Repository
public interface MultimediaRepository extends JpaRepository<Multimedia, Integer> {
	List<Multimedia> findByTipo(String tipo);
    List<Multimedia> findByCategoria(String categoria);
    List<Multimedia> findByCreadoAfter(LocalDateTime fecha);
    long countByTipo(String tipo);
    List<Multimedia> findByVisibleTrue();
    List<Multimedia> findByTituloContainingIgnoreCaseOrDescripcionContainingIgnoreCase(String titulo, String descripcion);
}
