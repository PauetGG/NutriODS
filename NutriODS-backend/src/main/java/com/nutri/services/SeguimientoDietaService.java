package com.nutri.services;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.nutri.DTOs.CaloriasDiaDTO;
import com.nutri.entities.ComidaDiaria;
import com.nutri.entities.SeguimientoDieta;
import com.nutri.repositories.ComidaDiariaRepository;
import com.nutri.repositories.SeguimientoDietaRepository;

import jakarta.transaction.Transactional;

@Service
public class SeguimientoDietaService {

    private final SeguimientoDietaRepository seguimientoRepository;
    private final ComidaDiariaRepository comidaDiariaRepository;

    public SeguimientoDietaService(SeguimientoDietaRepository seguimientoRepository,
                                     ComidaDiariaRepository comidaDiariaRepository) {
        this.seguimientoRepository = seguimientoRepository;
        this.comidaDiariaRepository = comidaDiariaRepository;
    }

    // Métodos básicos
    public List<SeguimientoDieta> findAll() {
        return seguimientoRepository.findAll();
    }

    public Optional<SeguimientoDieta> findById(Integer id) {
        return seguimientoRepository.findById(id);
    }

    public SeguimientoDieta save(SeguimientoDieta seguimiento) {
        return seguimientoRepository.save(seguimiento);
    }

    public void deleteById(Integer id) {
        seguimientoRepository.deleteById(id);
    }

    // Métodos por necesidad
    public List<SeguimientoDieta> findByDietaId(Integer dietaId) {
        return seguimientoRepository.findByDietaId(dietaId);
    }

    public List<SeguimientoDieta> findByFecha(LocalDate fecha) {
        return seguimientoRepository.findByFecha(fecha);
    }

    /**
     * Crea registros de seguimiento para toda la planificación de la dieta indicada.
     */
    @Transactional
    public void crearSeguimientoDesdeFecha(Integer dietaId, LocalDate fechaInicio) {
        List<ComidaDiaria> comidas = comidaDiariaRepository.findByDietaId(dietaId);

        // Calcular último día: 3 meses después de la fecha de inicio
        LocalDate finDeMes = fechaInicio.plusMonths(3);

        // Empezar desde el lunes anterior o igual a fechaInicio
        LocalDate inicioSemana = fechaInicio.with(java.time.DayOfWeek.MONDAY);

        int semanaActual = 1;

        while (!inicioSemana.isAfter(finDeMes)) {
            for (ComidaDiaria comida : comidas) {
                SeguimientoDieta.DiaSemana diaSemana = SeguimientoDieta.DiaSemana.valueOf(comida.getDiaSemana().name());
                int offset = diaSemana.ordinal(); // lunes=0

                LocalDate fechaComida = inicioSemana.plusDays(offset);
                if (fechaComida.isBefore(fechaInicio) || fechaComida.isAfter(finDeMes)) continue;

                boolean yaExiste = seguimientoRepository.existsByDietaIdAndComidaModeloIdAndFecha(
                    dietaId, comida.getComidaModelo().getId(), fechaComida
                );
                if (yaExiste) continue;

                SeguimientoDieta seguimiento = new SeguimientoDieta();
                seguimiento.setDieta(comida.getDieta());
                seguimiento.setComidaModelo(comida.getComidaModelo());
                seguimiento.setDiaSemana(diaSemana);
                seguimiento.setComida(SeguimientoDieta.TipoComida.valueOf(comida.getTipoComida().name()));
                seguimiento.setFecha(fechaComida);
                seguimiento.setSemanaNumero(semanaActual);
                seguimiento.setPorciones(BigDecimal.ONE);
                seguimiento.setConsumido(false);

                seguimientoRepository.save(seguimiento);
            }
            semanaActual++;
            inicioSemana = inicioSemana.plusWeeks(1);
        }
    }
        
    public List<CaloriasDiaDTO> calcularCaloriasPorDiaPorDieta(Integer dietaId) {
        LocalDate hoy = LocalDate.now();

        List<SeguimientoDieta> registros = seguimientoRepository.findByDietaId(dietaId)
            .stream()
            .filter(s -> s.getFecha() != null && s.getFecha().isBefore(hoy)) // solo hasta ayer
            .toList();

        Map<String, CaloriasDiaDTO> resumenPorDia = new HashMap<>();

        for (SeguimientoDieta s : registros) {
            String dia = capitalizar(s.getDiaSemana().name()); // ejemplo: "Lunes"
            
            int caloriasPorComida = s.getComidaModelo().getCaloriasTotales();
            boolean fueConsumido = Boolean.TRUE.equals(s.getConsumido());

            CaloriasDiaDTO dto = resumenPorDia.getOrDefault(dia, new CaloriasDiaDTO(dia, 0, 0));

            // ✅ Aquí solo sumamos 1 vez las calorías totales por comida
            dto.setObjetivo(dto.getObjetivo() + caloriasPorComida);

            if (fueConsumido) {
                dto.setConsumido(dto.getConsumido() + caloriasPorComida);
            }

            resumenPorDia.put(dia, dto);
        }

        return resumenPorDia.values().stream()
            .sorted(Comparator.comparingInt(d -> ordenarDiaSemana(d.getDia())))
            .collect(Collectors.toList());
    }


    private int ordenarDiaSemana(String dia) {
        return switch (dia.toLowerCase()) {
            case "lunes" -> 1;
            case "martes" -> 2;
            case "miércoles" -> 3;
            case "jueves" -> 4;
            case "viernes" -> 5;
            case "sábado" -> 6;
            case "domingo" -> 7;
            default -> 99;
        };
    }

    private String capitalizar(String dia) {
        return dia.substring(0, 1).toUpperCase() + dia.substring(1).toLowerCase();
    }


    /**
     * Actualiza un registro de seguimiento existente.
     */
    public SeguimientoDieta actualizarSeguimiento(Integer id, SeguimientoDieta datos) {
        SeguimientoDieta existente = seguimientoRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Seguimiento no encontrado"));
        existente.setPorciones(datos.getPorciones());
        existente.setConsumido(datos.getConsumido());
        existente.setNotas(datos.getNotas());
        existente.setFecha(datos.getFecha());
        existente.setComida(datos.getComida());
        existente.setDiaSemana(datos.getDiaSemana());
        return seguimientoRepository.save(existente);
    }
}
