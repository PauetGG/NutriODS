package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.ComidaIngrediente;

@Repository
public interface ComidaIngredienteRepository extends JpaRepository<ComidaIngrediente, Integer> {
	List<ComidaIngrediente> findByComidaModeloId(Integer comidaModeloId);
    List<ComidaIngrediente> findByIngredienteId(Integer ingredienteId);
}
