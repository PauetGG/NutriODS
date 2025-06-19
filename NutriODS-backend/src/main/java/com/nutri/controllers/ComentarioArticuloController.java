package com.nutri.controllers;

import com.nutri.entities.ComentarioArticulo;
import com.nutri.services.ComentarioArticuloService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/articulos/comentarios")
public class ComentarioArticuloController {

    @Autowired
    private ComentarioArticuloService service;

    @GetMapping
    public List<ComentarioArticulo> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ComentarioArticulo> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<ComentarioArticulo> create(@Valid @RequestBody ComentarioArticulo comentario) {
        return ResponseEntity.ok(service.save(comentario));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        return service.findById(id).map(c -> {
            service.deleteById(id);
            return ResponseEntity.ok().body("Comentario eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
}
