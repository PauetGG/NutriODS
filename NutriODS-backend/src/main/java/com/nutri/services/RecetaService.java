package com.nutri.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.Receta;
import com.nutri.repositories.RecetaRepository;

@Service
public class RecetaService {

    private final RecetaRepository recetaRepository;

    public RecetaService(RecetaRepository recetaRepository) {
        this.recetaRepository = recetaRepository;
    }

    public List<Receta> findAll() {
        return recetaRepository.findAll();
    }

    public Optional<Receta> findById(Integer id) {
        return recetaRepository.findById(id);
    }

    public Receta save(Receta receta) {
        return recetaRepository.save(receta);
    }

    public void deleteById(Integer id) {
        recetaRepository.deleteById(id);
    }
    public List<Receta> findRecetasVisibles() {
        return recetaRepository.findByVisibleTrue();
    }

    public List<Receta> findByDificultad(Receta.Dificultad dificultad) {
        return recetaRepository.findByDificultad(dificultad);
    }

    public List<Receta> searchByNombre(String palabra) {
        return recetaRepository.findByNombreContainingIgnoreCase(palabra);
    }

    public List<Receta> findByTiempoPreparacionMenorIgual(Integer minutos) {
        return recetaRepository.findByTiempoPreparacionLessThanEqual(minutos);
    }

    public List<Receta> findRecetasRecientes(int dias) {
        LocalDateTime fechaLimite = LocalDateTime.now().minusDays(dias);
        return recetaRepository.findByCreadoAfter(fechaLimite);
    }

    public long contarRecetasPorDificultad(Receta.Dificultad dificultad) {
        return recetaRepository.countByDificultad(dificultad);
    }

    public Receta cambiarVisibilidad(Integer id) {
        Receta receta = recetaRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Receta no encontrada"));
        receta.setVisible(!receta.getVisible());
        return recetaRepository.save(receta);
    }
}
