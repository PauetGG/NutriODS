package com.nutri.repositories;

import com.nutri.entities.Multimedia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MultimediaRepository extends JpaRepository<Multimedia, Integer> {
    // Aquí podrías añadir métodos personalizados como:
    // List<Multimedia> findByCategoria(Multimedia.Categoria categoria);
    // List<Multimedia> findByVisibleTrue();
}
