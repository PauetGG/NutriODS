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

import com.nutri.entities.FavoritoArticulo;
import com.nutri.entities.FavoritoArticuloId;
import com.nutri.services.FavoritoArticuloService;

@RestController
@RequestMapping("/api/articulos/favoritos")
public class FavoritoArticuloController {

    @Autowired
    private FavoritoArticuloService service;
    
    @GetMapping("/one")
    public ResponseEntity<FavoritoArticulo> findById(
            @RequestParam("articuloId") Integer articuloId,
            @RequestParam("usuarioId") Integer usuarioId) {
        FavoritoArticuloId id = new FavoritoArticuloId(usuarioId, articuloId);
        Optional<FavoritoArticulo> favorito = service.findById(id);
        return favorito.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }


    @PostMapping
    public ResponseEntity<FavoritoArticulo> addFavorito(@RequestBody FavoritoArticulo favorito) {
        return ResponseEntity.ok(service.save(favorito));
    }

    @DeleteMapping("/{usuarioId}/{articuloId}")
    public ResponseEntity<String> removeFavorito(@PathVariable Integer usuarioId, @PathVariable Integer articuloId) {
        FavoritoArticuloId id = new FavoritoArticuloId(usuarioId, articuloId);
        return service.findById(id).map(f -> {
            service.deleteById(id);
            return ResponseEntity.ok().body("Favorito eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
    @GetMapping("/usuario/{usuarioId}")
    public List<FavoritoArticulo> findByUsuario(@PathVariable Integer usuarioId) {
        return service.findByUsuario(usuarioId);
    }

    @GetMapping("/articulo/{articuloId}")
    public List<FavoritoArticulo> findByArticulo(@PathVariable Integer articuloId) {
        return service.findByArticulo(articuloId);
    }

    @GetMapping("/exists")
    public boolean existeFavorito(
            @RequestParam("articuloId") Integer articuloId,
            @RequestParam("usuarioId") Integer usuarioId) {
        return service.existeFavorito(usuarioId, articuloId);
    }

    @GetMapping("/count/{articuloId}")
    public long contarFavoritosPorArticulo(@PathVariable Integer articuloId) {
        return service.contarFavoritosPorArticulo(articuloId);
    }
}
