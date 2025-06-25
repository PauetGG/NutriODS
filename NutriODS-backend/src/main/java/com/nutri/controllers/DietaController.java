package com.nutri.controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.DTOs.GenerarDietaRequest;
import com.nutri.entities.Dieta;
import com.nutri.entities.Usuario;
import com.nutri.services.DietaService;
import com.nutri.services.UsuarioService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/dietas")
public class DietaController {

    private final DietaService dietaService;
    private final UsuarioService usuarioService;
    
    public DietaController(DietaService dietaService, UsuarioService usuarioService) {
        this.dietaService = dietaService;
        this.usuarioService = usuarioService;
    }
    

    @GetMapping
    public List<Dieta> getAll() {
        return dietaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Dieta> getById(@PathVariable Integer id) {
        return dietaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Dieta> create(@Valid @RequestBody Dieta dieta) {
        Dieta saved = dietaService.save(dieta);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Dieta> update(@PathVariable Integer id, @Valid @RequestBody Dieta dieta) {
        return dietaService.findById(id)
                .map(existing -> {
                    dieta.setId(id);
                    Dieta updated = dietaService.save(dieta);
                    return ResponseEntity.ok(updated);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        if (dietaService.findById(id).isPresent()) {
            dietaService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
    @PostMapping("/generar")
    public ResponseEntity<Dieta> generarDieta(@RequestBody GenerarDietaRequest request) {
        // Aquí deberías obtener el usuario por su ID, por ejemplo:
        Usuario usuario = usuarioService.getUsuarioById(request.getUsuarioId());
        if (usuario == null) {
            return ResponseEntity.notFound().build();
        }
        Dieta dieta = dietaService.generarDietaParaUsuario(
            usuario,
            request.getNombreDieta(),
            request.getDescripcion(),
            request.getNumeroComidasDia()
        );
        return ResponseEntity.ok(dieta);
    }
}
