package com.nutri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.TemaForo;
import com.nutri.services.TemaForoService;

import jakarta.validation.Valid;

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
    
    @PostMapping("/{id}/incrementar-visitas")
    public void incrementarVisitas(@PathVariable Integer id) {
        service.incrementarVisitas(id);
    }

    @PostMapping("/{id}/incrementar-respuestas")
    public void incrementarRespuestas(@PathVariable Integer id) {
        service.incrementarRespuestas(id);
    }

    @GetMapping("/usuario/{userId}")
    public List<TemaForo> findByUsuario(@PathVariable Integer userId) {
        return service.findByUsuario(userId);
    }

    @GetMapping("/categoria/{categoria}")
    public List<TemaForo> findByCategoria(@PathVariable TemaForo.Categoria categoria) {
        return service.findByCategoria(categoria);
    }

    @GetMapping("/search")
    public List<TemaForo> searchByPalabra(@RequestParam String palabra) {
        return service.searchByPalabra(palabra);
    }
}
