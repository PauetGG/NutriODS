package com.nutri.controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.RecetaIngrediente;
import com.nutri.entities.RecetaIngredienteId;
import com.nutri.services.RecetaIngredienteService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/receta-ingredientes")
public class RecetaIngredienteController {

    private final RecetaIngredienteService service;

    public RecetaIngredienteController(RecetaIngredienteService service) {
        this.service = service;
    }

    @GetMapping
    public List<RecetaIngrediente> getAll() {
        return service.findAll();
    }

    @GetMapping("/{recetaId}/{ingredienteId}")
    public ResponseEntity<RecetaIngrediente> getById(
            @PathVariable Integer recetaId,
            @PathVariable Integer ingredienteId
    ) {
        RecetaIngredienteId id = new RecetaIngredienteId(recetaId, ingredienteId);
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<RecetaIngrediente> create(@Valid @RequestBody RecetaIngrediente recetaIngrediente) {
        RecetaIngrediente saved = service.save(recetaIngrediente);
        return ResponseEntity.ok(saved);
    }

    @DeleteMapping("/{recetaId}/{ingredienteId}")
    public ResponseEntity<Void> delete(
            @PathVariable Integer recetaId,
            @PathVariable Integer ingredienteId
    ) {
        RecetaIngredienteId id = new RecetaIngredienteId(recetaId, ingredienteId);
        if (service.findById(id).isPresent()) {
            service.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
