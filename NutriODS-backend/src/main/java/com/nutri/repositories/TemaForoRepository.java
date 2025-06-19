package com.nutri.repositories;

import com.nutri.entities.TemaForo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TemaForoRepository extends JpaRepository<TemaForo, Integer> {
    // Ejemplo para filtrar por categoría o usuario si quieres
    // List<TemaForo> findByCategoria(TemaForo.Categoria categoria);
}
