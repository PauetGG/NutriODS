package com.nutri.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nutri.entities.ComidaDiaria;
import com.nutri.entities.ComidaModelo;

@Repository
public interface ComidaDiariaRepository extends JpaRepository<ComidaDiaria, Integer> {
	 	List<ComidaDiaria> findByDietaId(Integer dietaId);
	    List<ComidaDiaria> findByDiaSemana(ComidaDiaria.DiaSemana diaSemana);
	    List<ComidaDiaria> findByTipoComida(ComidaModelo.TipoComida tipoComida);
	    List<ComidaDiaria> findByDietaIdAndDiaSemana(Integer dietaId, ComidaDiaria.DiaSemana diaSemana);
	}

