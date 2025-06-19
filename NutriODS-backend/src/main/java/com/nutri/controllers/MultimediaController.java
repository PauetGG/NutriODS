package com.nutri.controllers;

import com.nutri.entities.Multimedia;
import com.nutri.services.MultimediaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/multimedia")
public class MultimediaController {

    @Autowired
    private MultimediaService service;

    @GetMapping
    public List<Multimedia> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Multimedia> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Multimedia> create(@Valid @RequestBody Multimedia multimedia) {
        return ResponseEntity.ok(service.save(multimedia));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Multimedia> update(@PathVariable Integer id, @Valid @RequestBody Multimedia multimedia) {
        return service.findById(id)
                .map(existing -> {
                    multimedia.setId(id);
                    return ResponseEntity.ok(service.save(multimedia));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        return service.findById(id).map(m -> {
            service.deleteById(id);
            return ResponseEntity.ok("Recurso multimedia eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
}
