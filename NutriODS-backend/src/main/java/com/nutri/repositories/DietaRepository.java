package com.nutri.repositories;

import com.nutri.entities.Dieta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DietaRepository extends JpaRepository<Dieta, Integer> {
    // Puedes añadir: List<Dieta> findByUsuarioId(Integer usuarioId);
}
