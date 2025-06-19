package com.nutri.repositories;

import com.nutri.entities.Receta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecetaRepository extends JpaRepository<Receta, Integer> {
    // Aquí puedes añadir métodos custom si quieres buscar por nombre, etc.
}
