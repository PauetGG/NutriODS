package com.nutri.controllers;

import com.nutri.entities.ComidaIngrediente;
import com.nutri.services.ComidaIngredienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/comidas-ingredientes")
public class ComidaIngredienteController {

    @Autowired
    private ComidaIngredienteService service;

    @GetMapping
    public List<ComidaIngrediente> findAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public Optional<ComidaIngrediente> findById(@PathVariable Integer id) {
        return service.findById(id);
    }

    @PostMapping
    public ComidaIngrediente save(@RequestBody ComidaIngrediente comidaIngrediente) {
        return service.save(comidaIngrediente);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        service.deleteById(id);
    }
}
