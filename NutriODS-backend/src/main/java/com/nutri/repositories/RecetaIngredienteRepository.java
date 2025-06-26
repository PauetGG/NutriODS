package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.RecetaIngrediente;
import com.nutri.entities.RecetaIngredienteId;

@Repository
public interface RecetaIngredienteRepository extends JpaRepository<RecetaIngrediente, RecetaIngredienteId> {
	  	List<RecetaIngrediente> findByRecetaId(Integer recetaId);

	    List<RecetaIngrediente> findByIngredienteId(Integer ingredienteId);
}
