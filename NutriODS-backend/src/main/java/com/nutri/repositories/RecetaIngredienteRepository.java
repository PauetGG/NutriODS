package com.nutri.repositories;

import com.nutri.entities.RecetaIngrediente;
import com.nutri.entities.RecetaIngredienteId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecetaIngredienteRepository extends JpaRepository<RecetaIngrediente, RecetaIngredienteId> {
    // Puedes buscar todos los ingredientes de una receta concreta
    // List<RecetaIngrediente> findByRecetaId(Integer recetaId);
}
