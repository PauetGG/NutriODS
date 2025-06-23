package com.nutri.controllers;

import com.nutri.entities.ComidaDiaria;
import com.nutri.services.ComidaDiariaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

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
}
