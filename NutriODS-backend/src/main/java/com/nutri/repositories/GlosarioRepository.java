package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.nutri.entities.Glosario;

@Repository
public interface GlosarioRepository extends JpaRepository<Glosario, Integer> {
	List<Glosario> findByCategoria(Glosario.Categoria categoria);

    List<Glosario> findByVisibleTrue();

    List<Glosario> findByTerminoContainingIgnoreCaseAndVisibleTrue(String termino);
    
    @Query("SELECT g FROM Glosario g WHERE " +
            "(:termino IS NULL OR LOWER(g.termino) LIKE LOWER(CONCAT('%', :termino, '%'))) AND " +
            "(:categoria IS NULL OR g.categoria = :categoria) AND " +
            "g.visible = true")
     List<Glosario> buscarFiltrado(
         @Param("termino") String termino,
         @Param("categoria") Glosario.Categoria categoria
     );

}
