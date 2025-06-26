package com.nutri.services;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.entities.Articulo;
import com.nutri.repositories.ArticuloRepository;

@Service
public class ArticuloService {

    @Autowired
    private ArticuloRepository articuloRepository;

    public List<Articulo> findAll() {
        return articuloRepository.findAll();
    }

    public Optional<Articulo> findById(Integer id) {
        return articuloRepository.findById(id);
    }

    public Articulo save(Articulo articulo) {
        return articuloRepository.save(articulo);
    }

    public void deleteById(Integer id) {
        articuloRepository.deleteById(id);
    }
    public List<Articulo> findByCategoria(Articulo.Categoria categoria) {
        return articuloRepository.findByCategoria(categoria);
    }

    public List<Articulo> findByVisible(boolean visible) {
        return articuloRepository.findByVisible(visible);
    }

    public List<Articulo> searchByTitulo(String keyword) {
        return articuloRepository.findByTituloContainingIgnoreCase(keyword);
    }

    public long countAll() {
        return articuloRepository.count();
    }

    public long countByCategoria(Articulo.Categoria categoria) {
        return articuloRepository.countByCategoria(categoria);
    }

    public List<Articulo> findMostRecent(int limit) {
        List<Articulo> articulos = articuloRepository.findAll();
        return articulos.stream()
                .sorted(Comparator.comparing(Articulo::getFechaPublicacion, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(limit)
                .toList();
    }

    public Articulo hideArticle(Integer id) {
        Articulo articulo = findById(id).orElseThrow(() -> new RuntimeException("Artículo no encontrado"));
        articulo.setVisible(false);
        return articuloRepository.save(articulo);
    }

    public Articulo showArticle(Integer id) {
        Articulo articulo = findById(id).orElseThrow(() -> new RuntimeException("Artículo no encontrado"));
        articulo.setVisible(true);
        return articuloRepository.save(articulo);
    }
}
