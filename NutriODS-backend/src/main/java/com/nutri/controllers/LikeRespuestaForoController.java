package com.nutri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.LikeRespuestaForo;
import com.nutri.entities.LikeRespuestaForoId;
import com.nutri.services.LikeRespuestaForoService;

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
    @GetMapping("/count/{respuestaId}")
    public long contarLikesPorRespuesta(@PathVariable Integer respuestaId) {
        return service.contarLikesPorRespuesta(respuestaId);
    }

    @GetMapping("/exists")
    public boolean existeLike(@RequestParam("respuestaId") Integer respuestaId,
                              @RequestParam("usuarioId") Integer usuarioId) {
        return service.existeLike(usuarioId, respuestaId);
    }

    @GetMapping("/usuario/{usuarioId}")
    public List<LikeRespuestaForo> findByUsuario(@PathVariable Integer usuarioId) {
        return service.findByUsuario(usuarioId);
    }

    @GetMapping("/respuesta/{respuestaId}")
    public List<LikeRespuestaForo> findByRespuesta(@PathVariable Integer respuestaId) {
        return service.findByRespuesta(respuestaId);
    }
}
