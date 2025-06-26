package com.nutri.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.ComidaDiaria;
import com.nutri.entities.ComidaModelo;
import com.nutri.services.ComidaDiariaService;

@RestController
@RequestMapping("/api/comidas-diarias")
public class ComidaDiariaController {

    @Autowired
    private ComidaDiariaService service;

    @GetMapping
    public List<ComidaDiaria> findAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public Optional<ComidaDiaria> findById(@PathVariable Integer id) {
        return service.findById(id);
    }

    @PostMapping
    public ComidaDiaria save(@RequestBody ComidaDiaria comidaDiaria) {
        return service.save(comidaDiaria);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        service.deleteById(id);
    }
    @GetMapping("/dieta/{dietaId}")
    public List<ComidaDiaria> findByDieta(@PathVariable Integer dietaId) {
        return service.findByDieta(dietaId);
    }

    @GetMapping("/dia/{diaSemana}")
    public List<ComidaDiaria> findByDiaSemana(@PathVariable ComidaDiaria.DiaSemana diaSemana) {
        return service.findByDiaSemana(diaSemana);
    }

    @GetMapping("/tipo/{tipoComida}")
    public List<ComidaDiaria> findByTipoComida(@PathVariable ComidaModelo.TipoComida tipoComida) {
        return service.findByTipoComida(tipoComida);
    }

    @GetMapping("/dieta/{dietaId}/dia/{diaSemana}")
    public List<ComidaDiaria> findByDietaAndDia(
            @PathVariable Integer dietaId,
            @PathVariable ComidaDiaria.DiaSemana diaSemana) {
        return service.findByDietaAndDia(dietaId, diaSemana);
    }
}
