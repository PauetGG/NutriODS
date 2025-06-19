package com.nutri.controllers;

import com.nutri.entities.Dieta;
import com.nutri.services.DietaService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dietas")
public class DietaController {

    private final DietaService dietaService;

    public DietaController(DietaService dietaService) {
        this.dietaService = dietaService;
    }

    @GetMapping
    public List<Dieta> getAll() {
        return dietaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Dieta> getById(@PathVariable Integer id) {
        return dietaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Dieta> create(@Valid @RequestBody Dieta dieta) {
        Dieta saved = dietaService.save(dieta);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Dieta> update(@PathVariable Integer id, @Valid @RequestBody Dieta dieta) {
        return dietaService.findById(id)
                .map(existing -> {
                    dieta.setId(id);
                    Dieta updated = dietaService.save(dieta);
                    return ResponseEntity.ok(updated);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        if (dietaService.findById(id).isPresent()) {
            dietaService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
