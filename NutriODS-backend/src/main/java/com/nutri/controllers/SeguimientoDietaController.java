package com.nutri.controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.SeguimientoDieta;
import com.nutri.services.SeguimientoDietaService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/seguimiento")
public class SeguimientoDietaController {

    private final SeguimientoDietaService seguimientoService;

    public SeguimientoDietaController(SeguimientoDietaService seguimientoService) {
        this.seguimientoService = seguimientoService;
    }

    @GetMapping
    public List<SeguimientoDieta> getAll() {
        return seguimientoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<SeguimientoDieta> getById(@PathVariable Integer id) {
        return seguimientoService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<SeguimientoDieta> create(@Valid @RequestBody SeguimientoDieta seguimiento) {
        SeguimientoDieta saved = seguimientoService.save(seguimiento);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SeguimientoDieta> update(@PathVariable Integer id, @Valid @RequestBody SeguimientoDieta seguimiento) {
        return seguimientoService.findById(id)
                .map(existing -> {
                    seguimiento.setId(id);
                    SeguimientoDieta updated = seguimientoService.save(seguimiento);
                    return ResponseEntity.ok(updated);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        if (seguimientoService.findById(id).isPresent()) {
            seguimientoService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
