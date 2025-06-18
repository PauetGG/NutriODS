package com.nutri.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nutri.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

}
