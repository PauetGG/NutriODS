package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.ComidaModelo;

@Repository
public interface ComidaModeloRepository extends JpaRepository<ComidaModelo, Integer> {
	List<ComidaModelo> findByTipoComida(ComidaModelo.TipoComida tipoComida);
    List<ComidaModelo> findByNombreContainingIgnoreCase(String nombre);
    List<ComidaModelo> findByCaloriasTotalesBetween(int min, int max);
}
