package com.nutri.controllers;

import java.util.List;
import java.util.Optional;

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

import com.nutri.entities.LikeArticulo;
import com.nutri.entities.LikeArticuloId;
import com.nutri.services.LikeArticuloService;

@RestController
@RequestMapping("/api/articulos/likes")
public class LikeArticuloController {

    @Autowired
    private LikeArticuloService likeService;

    @GetMapping("/one")
    public ResponseEntity<LikeArticulo> findById(
            @RequestParam("articuloId") Integer articuloId,
            @RequestParam("usuarioId") Integer usuarioId) {
        LikeArticuloId id = new LikeArticuloId(usuarioId, articuloId);
        Optional<LikeArticulo> like = likeService.findById(id);
        return like.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public LikeArticulo save(@RequestBody LikeArticulo like) {
        return likeService.save(like);
    }

    @DeleteMapping
    public void deleteById(
            @RequestParam("articuloId") Integer articuloId,
            @RequestParam("usuarioId") Integer usuarioId) {
        LikeArticuloId id = new LikeArticuloId(usuarioId, articuloId);
        likeService.deleteById(id);
    }
    @GetMapping("/count/{articuloId}")
    public long contarLikesPorArticulo(@PathVariable Integer articuloId) {
        return likeService.contarLikesPorArticulo(articuloId);
    }

    @GetMapping("/exists")
    public boolean existeLike(
            @RequestParam("articuloId") Integer articuloId,
            @RequestParam("usuarioId") Integer usuarioId) {
        return likeService.existeLike(usuarioId, articuloId);
    }

    @GetMapping("/usuario/{usuarioId}")
    public List<LikeArticulo> findByUsuario(@PathVariable Integer usuarioId) {
        return likeService.findByUsuario(usuarioId);
    }

    @GetMapping("/articulo/{articuloId}")
    public List<LikeArticulo> findByArticulo(@PathVariable Integer articuloId) {
        return likeService.findByArticulo(articuloId);
    }
}
