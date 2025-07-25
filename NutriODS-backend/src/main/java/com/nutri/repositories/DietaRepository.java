package com.nutri.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.nutri.entities.Dieta;

@Repository
public interface DietaRepository extends JpaRepository<Dieta, Integer> {
	@Query("SELECT d FROM Dieta d JOIN FETCH d.usuario")
	List<Dieta> findAllConUsuario();
	List<Dieta> findByUsuarioId(Integer usuarioId);
    List<Dieta> findByCreatedBetween(LocalDateTime start, LocalDateTime end);
    long countByUsuarioId(Integer usuarioId);
}
