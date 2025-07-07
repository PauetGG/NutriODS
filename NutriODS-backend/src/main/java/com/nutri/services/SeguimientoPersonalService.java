package com.nutri.services;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.nutri.entities.SeguimientoPersonal;
import com.nutri.entities.Usuario;
import com.nutri.repositories.SeguimientoPersonalRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class SeguimientoPersonalService {

    private final SeguimientoPersonalRepository seguimientoRepository;

    public SeguimientoPersonalService(SeguimientoPersonalRepository seguimientoRepository) {
        this.seguimientoRepository = seguimientoRepository;
    }

    public List<SeguimientoPersonal> obtenerPorUsuario(Integer usuarioId) {
        return seguimientoRepository.findByUsuario_Id(usuarioId);
    }

    public List<SeguimientoPersonal> obtenerPorRangoDeFechas(Integer usuarioId, LocalDate desde, LocalDate hasta) {
        return seguimientoRepository.findByUsuario_IdAndFechaBetween(usuarioId, desde, hasta);
    }

    public Optional<SeguimientoPersonal> obtenerPorId(Integer id) {
        return seguimientoRepository.findById(id);
    }

    public SeguimientoPersonal guardar(SeguimientoPersonal seguimiento) {
        return seguimientoRepository.save(seguimiento);
    }

    public void eliminar(Integer id) {
        seguimientoRepository.deleteById(id);
    }

    public boolean existePorUsuarioYFecha(Usuario usuario, LocalDate fecha) {
        return seguimientoRepository.existsByUsuarioAndFecha(usuario, fecha);
    }
}
