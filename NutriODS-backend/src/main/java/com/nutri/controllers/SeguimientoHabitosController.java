package com.nutri.controllers;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.SeguimientoHabitos;
import com.nutri.services.SeguimientoHabitosService;

@RestController
@RequestMapping("/api/seguimiento-habitos")
public class SeguimientoHabitosController {

    private final SeguimientoHabitosService seguimientoHabitosService;

    public SeguimientoHabitosController(SeguimientoHabitosService seguimientoHabitosService) {
        this.seguimientoHabitosService = seguimientoHabitosService;
    }
    
 // Obtener todos los seguimientos
    @GetMapping
    public ResponseEntity<List<SeguimientoHabitos>> getAll() {
        List<SeguimientoHabitos> lista = seguimientoHabitosService.findAll();
        return ResponseEntity.ok(lista);
    }


    // Crear o actualizar un registro
    @PostMapping
    public ResponseEntity<SeguimientoHabitos> save(@RequestBody SeguimientoHabitos seguimientoHabitos) {
        SeguimientoHabitos saved = seguimientoHabitosService.save(seguimientoHabitos);
        return ResponseEntity.ok(saved);
    }

    // Obtener todos los seguimientos de una dieta
    @GetMapping("/dieta/{dietaId}")
    public ResponseEntity<List<SeguimientoHabitos>> getByDieta(@PathVariable Integer dietaId) {
        List<SeguimientoHabitos> lista = seguimientoHabitosService.findByDietaId(dietaId);
        return ResponseEntity.ok(lista);
    }

    // Obtener un seguimiento por dieta y fecha
    @GetMapping("/dieta/{dietaId}/fecha/{fecha}")
    public ResponseEntity<SeguimientoHabitos> getByDietaAndFecha(
            @PathVariable Integer dietaId,
            @PathVariable String fecha
    ) {
        Optional<SeguimientoHabitos> optional = seguimientoHabitosService.findByDietaIdAndFecha(dietaId, LocalDate.parse(fecha));
        return optional.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Obtener un seguimiento por ID
    @GetMapping("/{id}")
    public ResponseEntity<SeguimientoHabitos> getById(@PathVariable Integer id) {
        Optional<SeguimientoHabitos> optional = seguimientoHabitosService.findById(id);
        return optional.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Eliminar un seguimiento por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Integer id) {
        seguimientoHabitosService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}