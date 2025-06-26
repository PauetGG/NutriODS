package com.nutri.controllers;

import java.math.BigDecimal;
import java.util.List;

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

import com.nutri.entities.Ingrediente;
import com.nutri.services.IngredienteService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/ingredientes")
public class IngredienteController {

    private final IngredienteService ingredienteService;

    public IngredienteController(IngredienteService ingredienteService) {
        this.ingredienteService = ingredienteService;
    }

    // GET /api/ingredientes
    @GetMapping
    public List<Ingrediente> getAllIngredientes() {
        return ingredienteService.findAll();
    }

    // GET /api/ingredientes/{id}
    @GetMapping("/{id}")
    public ResponseEntity<Ingrediente> getIngredienteById(@PathVariable Integer id) {
        return ingredienteService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // POST /api/ingredientes
    @PostMapping
    public ResponseEntity<Ingrediente> createIngrediente(@Valid @RequestBody Ingrediente ingrediente) {
        Ingrediente saved = ingredienteService.save(ingrediente);
        return ResponseEntity.ok(saved);
    }

    // PUT /api/ingredientes/{id}
    @PutMapping("/{id}")
    public ResponseEntity<Ingrediente> updateIngrediente(@PathVariable Integer id, @Valid @RequestBody Ingrediente updatedIngrediente) {
        return ingredienteService.findById(id)
                .map(existing -> {
                    updatedIngrediente.setId(id); // mantener el ID original
                    Ingrediente saved = ingredienteService.save(updatedIngrediente);
                    return ResponseEntity.ok(saved);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // DELETE /api/ingredientes/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteIngrediente(@PathVariable Integer id) {
        if (ingredienteService.findById(id).isPresent()) {
            ingredienteService.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @GetMapping("/tipo/{tipo}")
    public List<Ingrediente> findByTipo(@PathVariable Ingrediente.TipoIngrediente tipo) {
        return ingredienteService.findByTipo(tipo);
    }

    @GetMapping("/search")
    public List<Ingrediente> searchByNombre(@RequestParam("nombre") String nombre) {
        return ingredienteService.searchByNombre(nombre);
    }

    @GetMapping("/calorias/max/{maxCalorias}")
    public List<Ingrediente> findByCaloriasMenorIgual(@PathVariable Integer maxCalorias) {
        return ingredienteService.findByCaloriasMenorIgual(maxCalorias);
    }

    @GetMapping("/proteinas/rango")
    public List<Ingrediente> findByProteinasBetween(@RequestParam("min") BigDecimal min,
                                                     @RequestParam("max") BigDecimal max) {
        return ingredienteService.findByProteinasBetween(min, max);
    }
}
