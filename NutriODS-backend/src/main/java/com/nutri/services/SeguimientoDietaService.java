package com.nutri.services;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

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

        // Calcular último día del mes de la fechaInicio
        LocalDate finDeMes = fechaInicio.withDayOfMonth(fechaInicio.lengthOfMonth());

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
    
    public void crearSeguimientoMesCompleto(Integer dietaId, YearMonth mes) {
        for (int day = 1; day <= mes.lengthOfMonth(); day++) {
            LocalDate fecha = mes.atDay(day);
            crearSeguimientoDesdeFecha(dietaId, fecha);
        }
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
