package com.nutri.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nutri.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
	
	
		Optional<Usuario> findByCorreo(String correo);
		
	    Optional<Usuario> findByUsername(String username);

	    boolean existsByCorreo(String correo);

	    List<Usuario> findByGenero(Usuario.Genero genero);

	    List<Usuario> findByActividadFisica(Usuario.ActividadFisica actividadFisica);
}
