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

import com.nutri.entities.LikeForo;
import com.nutri.entities.LikeForoId;
import com.nutri.services.LikeForoService;

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
    @GetMapping("/count/{temaId}")
    public long contarLikesPorTema(@PathVariable Integer temaId) {
        return service.contarLikesPorTema(temaId);
    }

    @GetMapping("/exists")
    public boolean existeLike(
            @RequestParam("temaId") Integer temaId,
            @RequestParam("usuarioId") Integer usuarioId) {
        return service.existeLike(usuarioId, temaId);
    }

    @GetMapping("/usuario/{usuarioId}")
    public List<LikeForo> findByUsuario(@PathVariable Integer usuarioId) {
        return service.findByUsuario(usuarioId);
    }

    @GetMapping("/tema/{temaId}")
    public List<LikeForo> findByTema(@PathVariable Integer temaId) {
        return service.findByTema(temaId);
    }
}
