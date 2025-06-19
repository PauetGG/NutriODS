package com.nutri.repositories;

import com.nutri.entities.Articulo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ArticuloRepository extends JpaRepository<Articulo, Integer> {
    // Ejemplo: List<Articulo> findByCategoria(Articulo.Categoria categoria);
}
