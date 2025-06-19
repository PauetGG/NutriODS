package com.nutri.controllers;

import com.nutri.entities.FavoritoArticulo;
import com.nutri.entities.FavoritoArticuloId;
import com.nutri.services.FavoritoArticuloService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/articulos/favoritos")
public class FavoritoArticuloController {

    @Autowired
    private FavoritoArticuloService service;

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
}
