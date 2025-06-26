package com.nutri.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.entities.ComidaDiaria;
import com.nutri.entities.ComidaModelo;
import com.nutri.repositories.ComidaDiariaRepository;

@Service
public class ComidaDiariaService {

    @Autowired
    private ComidaDiariaRepository repository;

    public List<ComidaDiaria> findAll() {
        return repository.findAll();
    }

    public Optional<ComidaDiaria> findById(Integer id) {
        return repository.findById(id);
    }

    public ComidaDiaria save(ComidaDiaria comidaDiaria) {
        return repository.save(comidaDiaria);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
    public List<ComidaDiaria> findByDieta(Integer dietaId) {
        return repository.findByDietaId(dietaId);
    }

    public List<ComidaDiaria> findByDiaSemana(ComidaDiaria.DiaSemana diaSemana) {
        return repository.findByDiaSemana(diaSemana);
    }

    public List<ComidaDiaria> findByTipoComida(ComidaModelo.TipoComida tipoComida) {
        return repository.findByTipoComida(tipoComida);
    }

    public List<ComidaDiaria> findByDietaAndDia(Integer dietaId, ComidaDiaria.DiaSemana diaSemana) {
        return repository.findByDietaIdAndDiaSemana(dietaId, diaSemana);
    }
}
