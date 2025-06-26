package com.nutri.services;

import com.nutri.entities.*;
import com.nutri.repositories.SeguimientoDietaRepository;
import com.nutri.repositories.ComidaDiariaRepository;

import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

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
    public void crearSeguimientoParaDieta(Integer dietaId) {
        List<ComidaDiaria> comidas = comidaDiariaRepository.findByDietaId(dietaId);
        for (ComidaDiaria comida : comidas) {
            SeguimientoDieta seguimiento = new SeguimientoDieta();
            seguimiento.setDieta(comida.getDieta());
            seguimiento.setComidaModelo(comida.getComidaModelo());

            // Conversión de Enums
            seguimiento.setDiaSemana(SeguimientoDieta.DiaSemana.valueOf(comida.getDiaSemana().name()));
            seguimiento.setComida(SeguimientoDieta.TipoComida.valueOf(comida.getTipoComida().name()));
            seguimiento.setFecha(LocalDate.now());
            seguimiento.setPorciones(BigDecimal.ONE);
            seguimiento.setConsumido(false);

            seguimientoRepository.save(seguimiento);
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
