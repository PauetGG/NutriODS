package com.nutri.controllers;

import com.nutri.entities.ComidaModelo;
import com.nutri.services.ComidaModeloService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/comidas-modelo")
public class ComidaModeloController {

    @Autowired
    private ComidaModeloService service;

    @GetMapping
    public List<ComidaModelo> findAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public Optional<ComidaModelo> findById(@PathVariable Integer id) {
        return service.findById(id);
    }

    @PostMapping
    public ComidaModelo save(@RequestBody ComidaModelo comidaModelo) {
        return service.save(comidaModelo);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        service.deleteById(id);
    }
}
