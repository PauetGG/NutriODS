package com.nutri.controllers;

import com.nutri.entities.RespuestaForo;
import com.nutri.services.RespuestaForoService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/foro/respuestas")
public class RespuestaForoController {

    @Autowired
    private RespuestaForoService service;

    @GetMapping
    public List<RespuestaForo> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<RespuestaForo> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<RespuestaForo> create(@Valid @RequestBody RespuestaForo respuesta) {
        return ResponseEntity.ok(service.save(respuesta));
    }

    @PutMapping("/{id}")
    public ResponseEntity<RespuestaForo> update(@PathVariable Integer id, @Valid @RequestBody RespuestaForo respuesta) {
        return service.findById(id)
                .map(existing -> {
                    respuesta.setId(id);
                    return ResponseEntity.ok(service.save(respuesta));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> delete(@PathVariable Integer id) {
        return service.findById(id).map(r -> {
            service.deleteById(id);
            return ResponseEntity.noContent().build();
        }).orElse(ResponseEntity.notFound().build());
    }
    @GetMapping("/tema/{temaId}")
    public List<RespuestaForo> findByTema(@PathVariable Integer temaId) {
        return service.findByTema(temaId);
    }

    @GetMapping("/usuario/{usuarioId}")
    public List<RespuestaForo> findByUsuario(@PathVariable Integer usuarioId) {
        return service.findByUsuario(usuarioId);
    }

    @PostMapping("/{id}/incrementar-visitas")
    public void incrementarVisitas(@PathVariable Integer id) {
        service.incrementarVisitas(id);
    }

    @GetMapping("/{id}/count-likes")
    public long contarLikes(@PathVariable Integer id) {
        return service.contarLikes(id);
    }

    @PutMapping("/{id}/editar-contenido")
    public ResponseEntity<RespuestaForo> actualizarContenido(
            @PathVariable Integer id,
            @RequestBody String nuevoContenido) {
        RespuestaForo respuesta = service.actualizarContenido(id, nuevoContenido);
        return ResponseEntity.ok(respuesta);
    }
}
