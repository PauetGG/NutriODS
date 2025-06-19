package com.nutri.controllers;

import com.nutri.entities.RespuestaForo;
import com.nutri.services.RespuestaForoService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/foro/respuestas")
public class RespuestaForoController {

    @Autowired
    private RespuestaForoService service;

    @GetMapping
    public List<RespuestaForo> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<RespuestaForo> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<RespuestaForo> create(@Valid @RequestBody RespuestaForo respuesta) {
        return ResponseEntity.ok(service.save(respuesta));
    }

    @PutMapping("/{id}")
    public ResponseEntity<RespuestaForo> update(@PathVariable Integer id, @Valid @RequestBody RespuestaForo respuesta) {
        return service.findById(id)
                .map(existing -> {
                    respuesta.setId(id);
                    return ResponseEntity.ok(service.save(respuesta));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> delete(@PathVariable Integer id) {
        return service.findById(id).map(r -> {
            service.deleteById(id);
            return ResponseEntity.noContent().build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
