package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.TemaForo;

@Repository
public interface TemaForoRepository extends JpaRepository<TemaForo, Integer> {
	 	List<TemaForo> findByUsuarioId(Integer usuarioId);
	    List<TemaForo> findByCategoria(TemaForo.Categoria categoria);
	    List<TemaForo> findByTituloContainingIgnoreCaseOrContenidoContainingIgnoreCase(String titulo, String contenido);
}
