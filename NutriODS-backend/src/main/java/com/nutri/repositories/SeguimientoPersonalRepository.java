package com.nutri.repositories;

import com.nutri.entities.SeguimientoPersonal;
import com.nutri.entities.Usuario;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface SeguimientoPersonalRepository extends JpaRepository<SeguimientoPersonal, Integer> {

    List<SeguimientoPersonal> findByUsuario_Id(Integer usuarioId);

    List<SeguimientoPersonal> findByUsuario_IdAndFechaBetween(Integer usuarioId, LocalDate start, LocalDate end);

    boolean existsByUsuarioAndFecha(Usuario usuario, LocalDate fecha);
}
