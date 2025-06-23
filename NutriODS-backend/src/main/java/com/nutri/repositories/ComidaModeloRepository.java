package com.nutri.repositories;

import com.nutri.entities.ComidaModelo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComidaModeloRepository extends JpaRepository<ComidaModelo, Integer> {
    // Aquí puedes añadir métodos personalizados si los necesitas
}
