package com.nutri.controllers;

import java.time.LocalDateTime;
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

import com.nutri.entities.Multimedia;
import com.nutri.services.MultimediaService;

import jakarta.validation.Valid;

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
    @GetMapping("/tipo/{tipo}")
    public List<Multimedia> findByTipo(@PathVariable String tipo) {
        return service.findByTipo(tipo);
    }

    @GetMapping("/categoria/{categoria}")
    public List<Multimedia> findByCategoria(@PathVariable String categoria) {
        return service.findByCategoria(categoria);
    }

    @GetMapping("/desde-fecha")
    public List<Multimedia> findByFechaAfter(@RequestParam String fecha) {
        return service.findByFechaAfter(LocalDateTime.parse(fecha));
    }

    @GetMapping("/count/{tipo}")
    public long countByTipo(@PathVariable String tipo) {
        return service.countByTipo(tipo);
    }

    @GetMapping("/visible")
    public List<Multimedia> findAllVisible() {
        return service.findAllVisible();
    }

    @GetMapping("/search")
    public List<Multimedia> searchByPalabra(@RequestParam String palabra) {
        return service.searchByPalabra(palabra);
    }
}
