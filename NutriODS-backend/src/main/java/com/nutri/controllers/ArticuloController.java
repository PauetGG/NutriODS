package com.nutri.controllers;

import com.nutri.entities.Articulo;
import com.nutri.services.ArticuloService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/articulos")
public class ArticuloController {

    @Autowired
    private ArticuloService service;

    @GetMapping
    public List<Articulo> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Articulo> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Articulo> create(@Valid @RequestBody Articulo articulo) {
        return ResponseEntity.ok(service.save(articulo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Articulo> update(@PathVariable Integer id, @Valid @RequestBody Articulo articulo) {
        return service.findById(id)
                .map(existing -> {
                    articulo.setId(id);
                    return ResponseEntity.ok(service.save(articulo));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        return service.findById(id).map(a -> {
            service.deleteById(id);
            return ResponseEntity.ok().body("Artículo eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
}
