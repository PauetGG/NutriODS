package com.nutri.controllers;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

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

import com.nutri.entities.SeguimientoPersonal;
import com.nutri.entities.Usuario;
import com.nutri.services.SeguimientoPersonalService;
import com.nutri.services.UsuarioService;

import jakarta.persistence.EntityNotFoundException;

@RestController
@RequestMapping("/api/seguimiento-personal")
public class SeguimientoPersonalController {

    private final SeguimientoPersonalService seguimientoService;
    private final UsuarioService usuarioService;

    public SeguimientoPersonalController(SeguimientoPersonalService seguimientoService, UsuarioService usuarioService) {
        this.seguimientoService = seguimientoService;
        this.usuarioService = usuarioService;
    }

    // ✅ Obtener todos los registros de un usuario
    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<List<SeguimientoPersonal>> getByUsuario(@PathVariable Integer usuarioId) {
        return ResponseEntity.ok(seguimientoService.obtenerPorUsuario(usuarioId));
    }

    // ✅ Obtener por ID
    @GetMapping("/{id}")
    public ResponseEntity<SeguimientoPersonal> getById(@PathVariable Integer id) {
        return seguimientoService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // ✅ Obtener registros entre dos fechas
    @GetMapping("/usuario/{usuarioId}/rango")
    public ResponseEntity<List<SeguimientoPersonal>> getByUsuarioAndFechas(
            @PathVariable Integer usuarioId,
            @RequestParam("desde") String desdeStr,
            @RequestParam("hasta") String hastaStr) {

        LocalDate desde = LocalDate.parse(desdeStr);
        LocalDate hasta = LocalDate.parse(hastaStr);

        List<SeguimientoPersonal> registros = seguimientoService.obtenerPorRangoDeFechas(usuarioId, desde, hasta);
        return ResponseEntity.ok(registros);
    }

    // ✅ Crear nuevo registro
    @PostMapping
    public ResponseEntity<?> crear(@RequestBody SeguimientoPersonal seguimiento) {
        try {
            Usuario usuario = usuarioService.getUsuarioById(seguimiento.getUsuario().getId());

            if (seguimientoService.existePorUsuarioYFecha(usuario, seguimiento.getFecha())) {
                return ResponseEntity.badRequest().body("Ya existe un seguimiento para esa fecha");
            }

            seguimiento.setUsuario(usuario);
            return ResponseEntity.ok(seguimientoService.guardar(seguimiento));
            
        } catch (EntityNotFoundException e) {
            return ResponseEntity.badRequest().body("Usuario no encontrado");
        }
    }

    // ✅ Editar un registro existente
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(@PathVariable Integer id, @RequestBody SeguimientoPersonal actualizado) {
        Optional<SeguimientoPersonal> existente = seguimientoService.obtenerPorId(id);

        if (existente.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        actualizado.setId(id);
        return ResponseEntity.ok(seguimientoService.guardar(actualizado));
    }

    // ✅ Eliminar registro
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (seguimientoService.obtenerPorId(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        seguimientoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
