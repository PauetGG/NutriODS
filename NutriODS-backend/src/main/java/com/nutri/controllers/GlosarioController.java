package com.nutri.controllers;

import com.nutri.entities.Glosario;
import com.nutri.services.GlosarioService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/glosario")
public class GlosarioController {

    @Autowired
    private GlosarioService service;

    @GetMapping
    public List<Glosario> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Glosario> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Glosario> create(@Valid @RequestBody Glosario glosario) {
        return ResponseEntity.ok(service.save(glosario));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Glosario> update(@PathVariable Integer id, @Valid @RequestBody Glosario glosario) {
        return service.findById(id)
                .map(existing -> {
                    glosario.setId(id);
                    return ResponseEntity.ok(service.save(glosario));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        return service.findById(id).map(gl -> {
            service.deleteById(id);
            return ResponseEntity.ok("Término eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
    @GetMapping("/categoria/{categoria}")
    public List<Glosario> findByCategoria(@PathVariable Glosario.Categoria categoria) {
        return service.findByCategoria(categoria);
    }

    @GetMapping("/visible")
    public List<Glosario> findAllVisible() {
        return service.findAllVisible();
    }

    @GetMapping("/search")
    public List<Glosario> searchByPalabra(@RequestParam("palabra") String palabra) {
        return service.searchByPalabra(palabra);
    }

    @GetMapping("/count")
    public long countAll() {
        return service.countAll();
    }

    @PutMapping("/cambiar-visibilidad/{id}")
    public ResponseEntity<Glosario> cambiarVisibilidad(@PathVariable Integer id,
                                                        @RequestParam("visible") boolean visible) {
        return ResponseEntity.ok(service.cambiarVisibilidad(id, visible));
    }
}
