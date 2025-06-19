package com.nutri.controllers;

import com.nutri.entities.LikeArticulo;
import com.nutri.entities.LikeArticuloId;
import com.nutri.services.LikeArticuloService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/articulos/likes")
public class LikeArticuloController {

    @Autowired
    private LikeArticuloService service;

    @PostMapping
    public ResponseEntity<LikeArticulo> like(@RequestBody LikeArticulo like) {
        return ResponseEntity.ok(service.save(like));
    }

    @DeleteMapping("/{usuarioId}/{articuloId}")
    public ResponseEntity<String> unlike(@PathVariable Integer usuarioId, @PathVariable Integer articuloId) {
        LikeArticuloId id = new LikeArticuloId(usuarioId, articuloId);
        return service.findById(id).map(l -> {
            service.deleteById(id);
            return ResponseEntity.ok().body("Like eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
}
