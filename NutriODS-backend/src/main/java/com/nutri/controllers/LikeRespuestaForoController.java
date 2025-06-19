package com.nutri.controllers;

import com.nutri.entities.LikeRespuestaForo;
import com.nutri.entities.LikeRespuestaForoId;
import com.nutri.services.LikeRespuestaForoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/foro/likes-respuesta")
public class LikeRespuestaForoController {

    @Autowired
    private LikeRespuestaForoService service;

    @PostMapping
    public ResponseEntity<LikeRespuestaForo> like(@RequestBody LikeRespuestaForo like) {
        return ResponseEntity.ok(service.save(like));
    }

    @DeleteMapping("/{usuarioId}/{respuestaId}")
    public ResponseEntity<Object> unlike(@PathVariable Integer usuarioId, @PathVariable Integer respuestaId) {
        LikeRespuestaForoId id = new LikeRespuestaForoId(usuarioId, respuestaId);
        return service.findById(id).map(l -> {
            service.deleteById(id);
            return ResponseEntity.noContent().build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
