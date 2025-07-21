package com.nutri.services;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.SeguimientoHabitos;
import com.nutri.repositories.SeguimientoHabitosRepository;

@Service
public class SeguimientoHabitosService {

    private final SeguimientoHabitosRepository seguimientoHabitosRepository;

    public SeguimientoHabitosService(SeguimientoHabitosRepository seguimientoHabitosRepository) {
        this.seguimientoHabitosRepository = seguimientoHabitosRepository;
    }

    // Guardar o actualizar un registro
    public SeguimientoHabitos save(SeguimientoHabitos seguimientoHabitos) {
        return seguimientoHabitosRepository.save(seguimientoHabitos);
    }

    // Obtener todos los seguimientos de una dieta
    public List<SeguimientoHabitos> findByDietaId(Integer dietaId) {
        return seguimientoHabitosRepository.findByDietaIdOrderByFechaAsc(dietaId);
    }

    // Obtener un seguimiento por dieta y fecha
    public Optional<SeguimientoHabitos> findByDietaIdAndFecha(Integer dietaId, LocalDate fecha) {
        return seguimientoHabitosRepository.findByDietaIdAndFecha(dietaId, fecha);
    }

    // Obtener un seguimiento por ID
    public Optional<SeguimientoHabitos> findById(Integer id) {
        return seguimientoHabitosRepository.findById(id);
    }

    // Eliminar un seguimiento por ID
    public void deleteById(Integer id) {
        seguimientoHabitosRepository.deleteById(id);
    }
}