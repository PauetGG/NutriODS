package com.nutri.controllers;

import com.nutri.entities.Receta;
import com.nutri.services.RecetaService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recetas")
public class RecetaController {

    private final RecetaService recetaService;

    public RecetaController(RecetaService recetaService) {
        this.recetaService = recetaService;
    }

    @GetMapping
    public List<Receta> getAllRecetas() {
        return recetaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Receta> getRecetaById(@PathVariable Integer id) {
        return recetaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Receta> createReceta(@Valid @RequestBody Receta receta) {
        Receta saved = recetaService.save(receta);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Receta> updateReceta(@PathVariable Integer id, @Valid @RequestBody Receta receta) {
        return recetaService.findById(id)
                .map(existing -> {
                    receta.setId(id);
                    Receta updated = recetaService.save(receta);
                    return ResponseEntity.ok(updated);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReceta(@PathVariable Integer id) {
        if (recetaService.findById(id).isPresent()) {
            recetaService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/visible")
    public List<Receta> findRecetasVisibles() {
        return recetaService.findRecetasVisibles();
    }

    @GetMapping("/dificultad/{dificultad}")
    public List<Receta> findByDificultad(@PathVariable Receta.Dificultad dificultad) {
        return recetaService.findByDificultad(dificultad);
    }

    @GetMapping("/search")
    public List<Receta> searchByNombre(@RequestParam String palabra) {
        return recetaService.searchByNombre(palabra);
    }

    @GetMapping("/max-tiempo/{minutos}")
    public List<Receta> findByTiempoPreparacionMenorIgual(@PathVariable Integer minutos) {
        return recetaService.findByTiempoPreparacionMenorIgual(minutos);
    }

    @GetMapping("/recientes/{dias}")
    public List<Receta> findRecetasRecientes(@PathVariable Integer dias) {
        return recetaService.findRecetasRecientes(dias);
    }

    @GetMapping("/count-dificultad/{dificultad}")
    public long contarRecetasPorDificultad(@PathVariable Receta.Dificultad dificultad) {
        return recetaService.contarRecetasPorDificultad(dificultad);
    }

    @PostMapping("/{id}/cambiar-visibilidad")
    public ResponseEntity<Receta> cambiarVisibilidad(@PathVariable Integer id) {
        return ResponseEntity.ok(recetaService.cambiarVisibilidad(id));
    }
}
