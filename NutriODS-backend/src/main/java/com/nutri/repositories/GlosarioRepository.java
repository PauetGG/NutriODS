package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.Glosario;

@Repository
public interface GlosarioRepository extends JpaRepository<Glosario, Integer> {
	List<Glosario> findByCategoria(Glosario.Categoria categoria);

    List<Glosario> findByVisibleTrue();

    List<Glosario> findByTerminoContainingIgnoreCaseOrDefinicionContainingIgnoreCase(String termino, String definicion);
}
