package com.nutri.controllers;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
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

import com.nutri.DTOs.CaloriasDiaDTO;
import com.nutri.entities.SeguimientoDieta;
import com.nutri.services.SeguimientoDietaService;

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
   
    @PostMapping("/generar-mes/{dietaId}")
    public ResponseEntity<Void> generarSeguimientoDelMes(@PathVariable Integer dietaId) {
        seguimientoDietaService.crearSeguimientoDesdeFecha(dietaId, LocalDate.now());
        return ResponseEntity.ok().build();
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<SeguimientoDieta> actualizarSeguimiento(
            @PathVariable Integer id,
            @RequestBody SeguimientoDieta datos) {
        return ResponseEntity.ok(seguimientoDietaService.actualizarSeguimiento(id, datos));
    }
    
    @GetMapping("/calorias-semanales/dieta/{dietaId}")
    public List<CaloriasDiaDTO> obtenerCaloriasSemanalesPorDieta(@PathVariable Integer dietaId) {
        return seguimientoDietaService.calcularCaloriasPorDiaPorDieta(dietaId);
    }

}
