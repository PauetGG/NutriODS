package com.nutri.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nutri.entities.Ingrediente;

public interface IngredienteRepository extends JpaRepository<Ingrediente, Integer> {

}
