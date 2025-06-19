package com.nutri.controllers;

import com.nutri.entities.TemaForo;
import com.nutri.services.TemaForoService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/foro/temas")
public class TemaForoController {

    @Autowired
    private TemaForoService service;

    @GetMapping
    public List<TemaForo> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<TemaForo> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<TemaForo> create(@Valid @RequestBody TemaForo tema) {
        return ResponseEntity.ok(service.save(tema));
    }

    @PutMapping("/{id}")
    public ResponseEntity<TemaForo> update(@PathVariable Integer id, @Valid @RequestBody TemaForo tema) {
        return service.findById(id)
                .map(existing -> {
                    tema.setId(id);
                    return ResponseEntity.ok(service.save(tema));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> delete(@PathVariable Integer id) {
        return service.findById(id).map(t -> {
            service.deleteById(id);
            return ResponseEntity.noContent().build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
