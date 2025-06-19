package com.nutri.repositories;

import com.nutri.entities.Glosario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GlosarioRepository extends JpaRepository<Glosario, Integer> {
    // Ejemplos de métodos personalizados si los necesitas:
    // List<Glosario> findByCategoria(Glosario.Categoria categoria);
    // Optional<Glosario> findByTerminoIgnoreCase(String termino);
}
