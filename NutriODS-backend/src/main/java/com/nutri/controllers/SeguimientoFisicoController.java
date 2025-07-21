package com.nutri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.nutri.entities.CalisteniaEjercicio;
import com.nutri.entities.GimnasioEjercicio;
import com.nutri.entities.SeguimientoFisico;
import com.nutri.services.CalisteniaEjercicioService;
import com.nutri.services.GimnasioEjercicioService;
import com.nutri.services.SeguimientoFisicoService;

@RestController
@RequestMapping("/api/seguimiento-fisico")
public class SeguimientoFisicoController {

    @Autowired
    private SeguimientoFisicoService seguimientoService;

    @Autowired
    private CalisteniaEjercicioService calisteniaService;

    @Autowired
    private GimnasioEjercicioService gimnasioService;

    @PostMapping
    public ResponseEntity<SeguimientoFisico> crearSeguimiento(@RequestBody SeguimientoFisico seguimiento) {
        if (Boolean.FALSE.equals(seguimiento.getEntrenoHoy())) {
            seguimiento.setTipoEntreno(null);
            seguimiento.setTipoFuerza(null);
            seguimiento.setVelocidad(null);
            seguimiento.setTiempo(null);
            seguimiento.setGimnasioEjercicios(List.of());
            seguimiento.setCalisteniaEjercicios(List.of());
        }

        SeguimientoFisico nuevo = seguimientoService.save(seguimiento);
        return ResponseEntity.ok(nuevo);
    }


    // Obtener todos los seguimientos
    @GetMapping
    public ResponseEntity<List<SeguimientoFisico>> obtenerTodos() {
        return ResponseEntity.ok(seguimientoService.findAll());
    }
    
    @GetMapping("/buscar")
    public ResponseEntity<SeguimientoFisico> obtenerPorDietaYFecha(
            @RequestParam Integer dietaId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) java.time.LocalDate fecha) {

        return seguimientoService.findByDietaIdAndFecha(dietaId, fecha)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }



    // Obtener seguimiento por ID
    @GetMapping("/{id}")
    public ResponseEntity<SeguimientoFisico> obtenerPorId(@PathVariable Long id) {
        return seguimientoService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Eliminar seguimiento (elimina también los ejercicios asociados)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        seguimientoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // Añadir ejercicio de calistenia
    @PostMapping("/{seguimientoId}/calistenia")
    public ResponseEntity<CalisteniaEjercicio> agregarCalistenia(
            @PathVariable Long seguimientoId,
            @RequestBody CalisteniaEjercicio ejercicio) {
        CalisteniaEjercicio nuevo = calisteniaService.save(ejercicio);
        return ResponseEntity.ok(nuevo);
    }

    // Añadir ejercicio de gimnasio
    @PostMapping("/{seguimientoId}/gimnasio")
    public ResponseEntity<GimnasioEjercicio> agregarGimnasio(
            @PathVariable Long seguimientoId,
            @RequestBody GimnasioEjercicio ejercicio) {
        GimnasioEjercicio nuevo = gimnasioService.save(ejercicio);
        return ResponseEntity.ok(nuevo);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<SeguimientoFisico> actualizarSeguimiento(
            @PathVariable Long id,
            @RequestBody SeguimientoFisico seguimientoActualizado) {

        return seguimientoService.findById(id)
                .map(existing -> {
                    seguimientoActualizado.setId(id);

                    // 🧹 Limpiar campos si no entrenó hoy
                    if (Boolean.FALSE.equals(seguimientoActualizado.getEntrenoHoy())) {
                        seguimientoActualizado.setTipoEntreno(null);
                        seguimientoActualizado.setTipoFuerza(null);
                        seguimientoActualizado.setVelocidad(null);
                        seguimientoActualizado.setTiempo(null);
                        seguimientoActualizado.setGimnasioEjercicios(List.of());
                        seguimientoActualizado.setCalisteniaEjercicios(List.of());
                    }

                    SeguimientoFisico actualizado = seguimientoService.save(seguimientoActualizado);
                    return ResponseEntity.ok(actualizado);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // Obtener ejercicios de calistenia por seguimiento
    @GetMapping("/{seguimientoId}/calistenia")
    public ResponseEntity<List<CalisteniaEjercicio>> listarCalistenia(@PathVariable Long seguimientoId) {
        return ResponseEntity.ok(calisteniaService.findBySeguimientoId(seguimientoId));
    }

    // Obtener ejercicios de gimnasio por seguimiento
    @GetMapping("/{seguimientoId}/gimnasio")
    public ResponseEntity<List<GimnasioEjercicio>> listarGimnasio(@PathVariable Long seguimientoId) {
        return ResponseEntity.ok(gimnasioService.findBySeguimientoId(seguimientoId));
    }
}
