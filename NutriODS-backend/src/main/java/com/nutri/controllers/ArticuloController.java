package com.nutri.controllers;

import com.nutri.entities.Articulo;
import com.nutri.services.ArticuloService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/articulos")
public class ArticuloController {

    @Autowired
    private ArticuloService service;

    @GetMapping
    public List<Articulo> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Articulo> getById(@PathVariable Integer id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Articulo> create(@Valid @RequestBody Articulo articulo) {
        return ResponseEntity.ok(service.save(articulo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Articulo> update(@PathVariable Integer id, @Valid @RequestBody Articulo articulo) {
        return service.findById(id)
                .map(existing -> {
                    articulo.setId(id);
                    return ResponseEntity.ok(service.save(articulo));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        return service.findById(id).map(a -> {
            service.deleteById(id);
            return ResponseEntity.ok().body("Artículo eliminado correctamente");
        }).orElse(ResponseEntity.notFound().build());
    }
    @GetMapping("/categoria/{categoria}")
    public List<Articulo> findByCategoria(@PathVariable Articulo.Categoria categoria) {
        return service.findByCategoria(categoria);
    }

    @GetMapping("/visible/{visible}")
    public List<Articulo> findByVisible(@PathVariable boolean visible) {
        return service.findByVisible(visible);
    }

    @GetMapping("/search")
    public List<Articulo> searchByTitulo(@RequestParam String keyword) {
        return service.searchByTitulo(keyword);
    }

    @GetMapping("/count")
    public long countAll() {
        return service.countAll();
    }

    @GetMapping("/count/categoria/{categoria}")
    public long countByCategoria(@PathVariable Articulo.Categoria categoria) {
        return service.countByCategoria(categoria);
    }

    @GetMapping("/recent/{limit}")
    public List<Articulo> findMostRecent(@PathVariable int limit) {
        return service.findMostRecent(limit);
    }

    @PutMapping("/hide/{id}")
    public ResponseEntity<Articulo> hideArticle(@PathVariable Integer id) {
        return ResponseEntity.ok(service.hideArticle(id));
    }

    @PutMapping("/show/{id}")
    public ResponseEntity<Articulo> showArticle(@PathVariable Integer id) {
        return ResponseEntity.ok(service.showArticle(id));
    }
}
