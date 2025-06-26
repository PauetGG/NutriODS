package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.Articulo;

@Repository
public interface ArticuloRepository extends JpaRepository<Articulo, Integer> {
	List<Articulo> findByCategoria(Articulo.Categoria categoria);
    List<Articulo> findByVisible(boolean visible);
    List<Articulo> findByTituloContainingIgnoreCase(String keyword);
    long countByCategoria(Articulo.Categoria categoria);
}
