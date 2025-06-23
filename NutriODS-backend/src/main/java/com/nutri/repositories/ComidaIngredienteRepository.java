package com.nutri.repositories;

import com.nutri.entities.ComidaIngrediente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComidaIngredienteRepository extends JpaRepository<ComidaIngrediente, Integer> {
    // También puedes filtrar por comidaModelo o ingrediente si quieres añadir métodos
}
