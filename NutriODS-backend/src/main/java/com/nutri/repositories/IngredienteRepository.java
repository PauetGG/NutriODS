package com.nutri.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nutri.entities.Ingrediente;

public interface IngredienteRepository extends JpaRepository<Ingrediente, Integer> {
	List<Ingrediente> findByTipo(Ingrediente.TipoIngrediente tipo);
    List<Ingrediente> findByNombreContainingIgnoreCase(String nombre);
    List<Ingrediente> findByCaloriasLessThanEqual(Integer maxCalorias);
    List<Ingrediente> findByProteinasBetween(BigDecimal min, BigDecimal max);
}
