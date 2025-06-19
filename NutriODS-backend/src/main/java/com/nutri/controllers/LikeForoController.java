package com.nutri.controllers;

import com.nutri.entities.LikeForo;
import com.nutri.entities.LikeForoId;
import com.nutri.services.LikeForoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/foro/likes-tema")
public class LikeForoController {

    @Autowired
    private LikeForoService service;

    @PostMapping
    public ResponseEntity<LikeForo> like(@RequestBody LikeForo like) {
        return ResponseEntity.ok(service.save(like));
    }

    @DeleteMapping("/{usuarioId}/{temaId}")
    public ResponseEntity<Object> unlike(@PathVariable Integer usuarioId, @PathVariable Integer temaId) {
        LikeForoId id = new LikeForoId(usuarioId, temaId);
        return service.findById(id).map(l -> {
            service.deleteById(id);
            return ResponseEntity.noContent().build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
