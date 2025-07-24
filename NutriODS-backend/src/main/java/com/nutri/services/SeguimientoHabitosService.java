package com.nutri.services;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.DTOs.ResumenHabitosDTO;
import com.nutri.entities.SeguimientoHabitos;
import com.nutri.repositories.SeguimientoHabitosRepository;

@Service
public class SeguimientoHabitosService {

    private final SeguimientoHabitosRepository seguimientoHabitosRepository;

    public SeguimientoHabitosService(SeguimientoHabitosRepository seguimientoHabitosRepository) {
        this.seguimientoHabitosRepository = seguimientoHabitosRepository;
    }
    
	// Obtener todos los seguimientos
    public List<SeguimientoHabitos> findAll() {
        return seguimientoHabitosRepository.findAll();
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
 // Nuevo método: calcular resumen semanal para dashboard
    public ResumenHabitosDTO calcularResumenSemanal(Integer dietaId, int semanasAtras) {
        LocalDate hoy = LocalDate.now();
        int diaSemana = hoy.getDayOfWeek().getValue(); // 1 (lunes) a 7 (domingo)
        LocalDate lunesEstaSemana = hoy.minusDays(diaSemana - 1);

        // Restar semanas
        LocalDate lunes = lunesEstaSemana.minusWeeks(semanasAtras);
        LocalDate domingo = lunes.plusDays(6);

        List<SeguimientoHabitos> semana = seguimientoHabitosRepository.findByDietaAndSemana(dietaId, lunes, domingo);

        if (semana.isEmpty()) {
            return new ResumenHabitosDTO(0, 0, 0, 0, 0, 0);
        }

        double promAgua = semana.stream().mapToDouble(h -> h.getAgua().doubleValue()).average().orElse(0);
        double promSueno = semana.stream().mapToDouble(h -> h.getSuenoHoras().doubleValue()).average().orElse(0);
        double promPasos = semana.stream().mapToInt(SeguimientoHabitos::getPasos).average().orElse(0);
        double promAnimo = semana.stream().mapToInt(SeguimientoHabitos::getAnimo).average().orElse(0);
        double promEstres = semana.stream().mapToInt(SeguimientoHabitos::getEstres).average().orElse(0);
        double promMotivacion = semana.stream().mapToInt(SeguimientoHabitos::getMotivacion).average().orElse(0);

        int agua = promAgua >= 2 ? 5 : promAgua >= 1.5 ? 4 : promAgua >= 1 ? 3 : promAgua >= 0.5 ? 2 : 1;
        int sueno = promSueno >= 8 ? 5 : promSueno >= 7 ? 4 : promSueno >= 6 ? 3 : promSueno >= 5 ? 2 : 1;
        int ejercicio = promPasos >= 12000 ? 5 : promPasos >= 10000 ? 4 : promPasos >= 8000 ? 3 : promPasos >= 6000 ? 2 : 1;

        int animo = (int) Math.round(promAnimo);
        int estres = (int) Math.round(promEstres);
        int motivacion = (int) Math.round(promMotivacion);

        return new ResumenHabitosDTO(agua, sueno, ejercicio, animo, estres, motivacion);
    }
}