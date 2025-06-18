package com.nutri.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nutri.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
	 Optional<Usuario> findByCorreo(String correo);
}
