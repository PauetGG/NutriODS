package com.nutri.controllers;

import com.nutri.entities.SeguimientoDieta;
import com.nutri.services.SeguimientoDietaService;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/seguimiento-dieta")
public class SeguimientoDietaController {

    private final SeguimientoDietaService seguimientoDietaService;

    public SeguimientoDietaController(SeguimientoDietaService seguimientoDietaService) {
        this.seguimientoDietaService = seguimientoDietaService;
    }

    // ===================================================
    // ✅ Operaciones Básicas
    // ===================================================
    @GetMapping("/all")
    public List<SeguimientoDieta> findAll() {
        return seguimientoDietaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<SeguimientoDieta> findById(@PathVariable Integer id) {
        return seguimientoDietaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/crear")
    public SeguimientoDieta save(@RequestBody SeguimientoDieta seguimiento) {
        return seguimientoDietaService.save(seguimiento);
    }

    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable Integer id) {
        seguimientoDietaService.deleteById(id);
    }

    // ===================================================
    // ⚡️ Operaciones Específicas
    // ===================================================
    @GetMapping("/dieta/{dietaId}")
    public List<SeguimientoDieta> findByDietaId(@PathVariable Integer dietaId) {
        return seguimientoDietaService.findByDietaId(dietaId);
    }

    @GetMapping("/fecha")
    public List<SeguimientoDieta> findByFecha(
            @RequestParam("fecha") 
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha) {
        return seguimientoDietaService.findByFecha(fecha);
    }

    @PostMapping("/crear-seguimiento/{dietaId}")
    public void crearSeguimientoParaDieta(@PathVariable Integer dietaId) {
        seguimientoDietaService.crearSeguimientoParaDieta(dietaId);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SeguimientoDieta> actualizarSeguimiento(
            @PathVariable Integer id,
            @RequestBody SeguimientoDieta datos) {
        return ResponseEntity.ok(seguimientoDietaService.actualizarSeguimiento(id, datos));
    }
}
