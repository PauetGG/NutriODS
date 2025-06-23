package com.nutri.repositories;

import com.nutri.entities.ComidaDiaria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComidaDiariaRepository extends JpaRepository<ComidaDiaria, Integer> {
    // Puedes buscar por dieta o día si lo necesitas más adelante
}
