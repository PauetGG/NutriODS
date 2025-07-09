package com.nutri.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.DTOs.DatosUsuarioDTO;
import com.nutri.entities.Usuario;
import com.nutri.repositories.UsuarioRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Obtener todos los usuarios
    public List<Usuario> getAllUsuarios() {
        return usuarioRepository.findAll();
    }

    // Obtener un usuario por ID
    public Usuario getUsuarioById(Integer id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con ID: " + id));
    }

    // Crear usuario
    public Usuario crearUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    // Actualizar usuario
    public Usuario actualizarUsuario(Integer id, Usuario usuarioActualizado) {
        Usuario usuarioExistente = getUsuarioById(id);

        usuarioExistente.setCorreo(usuarioActualizado.getCorreo());
        usuarioExistente.setContraseña(usuarioActualizado.getContraseña());
        usuarioExistente.setNombre(usuarioActualizado.getNombre());
        usuarioExistente.setApellidos(usuarioActualizado.getApellidos());
        usuarioExistente.setAltura(usuarioActualizado.getAltura());
        usuarioExistente.setPeso(usuarioActualizado.getPeso());
        usuarioExistente.setFechaNacimiento(usuarioActualizado.getFechaNacimiento());
        usuarioExistente.setGenero(usuarioActualizado.getGenero());
        usuarioExistente.setObjetivo(usuarioActualizado.getObjetivo());
        usuarioExistente.setAlergias(usuarioActualizado.getAlergias());
        usuarioExistente.setEnfermedades(usuarioActualizado.getEnfermedades());
        usuarioExistente.setPreferenciasComida(usuarioActualizado.getPreferenciasComida());
        usuarioExistente.setActividadFisica(usuarioActualizado.getActividadFisica());

        return usuarioRepository.save(usuarioExistente);
    }

    // Eliminar usuario
    public void eliminarUsuario(Integer id) {
        Usuario usuario = getUsuarioById(id);
        usuarioRepository.delete(usuario);
    }
 // Buscar usuario por correo
    public Optional<Usuario> findByCorreo(String correo) {
        return usuarioRepository.findByCorreo(correo);
    }

    // Validar login (sin cifrado todavía)
    public Usuario login(String correo, String contraseña) {
        Optional<Usuario> optionalUsuario = usuarioRepository.findByCorreo(correo);

        if (optionalUsuario.isEmpty()) {
            throw new EntityNotFoundException("Usuario no encontrado");
        }

        Usuario usuario = optionalUsuario.get();

        if (!usuario.getContraseña().equals(contraseña)) {
            throw new RuntimeException("Contraseña incorrecta");
        }

        return usuario;
    }
    
    public Usuario actualizarDatosUsuario(Integer id, DatosUsuarioDTO dto) {
        Usuario usuario = usuarioRepository.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"));

        usuario.setAltura(dto.getAltura());
        usuario.setPeso(dto.getPeso());
        usuario.setFechaNacimiento(dto.getFechaNacimiento());

        if (dto.getGenero() != null) {
            usuario.setGenero(Usuario.Genero.valueOf(dto.getGenero()));
        }

        usuario.setObjetivo(dto.getObjetivo());

        // Asegurar que no se guarde null para evitar errores al llamar a .contains()
        usuario.setAlergias(dto.getAlergias() != null ? String.join(",", dto.getAlergias()) : "");
        usuario.setEnfermedades(dto.getEnfermedades() != null ? String.join(",", dto.getEnfermedades()) : "");
        usuario.setPreferenciasComida(dto.getPreferencias() != null ? String.join(",", dto.getPreferencias()) : "");

        if (dto.getActividad() != null) {
            usuario.setActividadFisica(
                Usuario.ActividadFisica.valueOf(dto.getActividad().replace(" ", "_"))
            );
        }

        return usuarioRepository.save(usuario);
    }


    public Optional<Usuario> findByUsername(String username) {
        return usuarioRepository.findByUsername(username);
    }

    public boolean existsByCorreo(String correo) {
        return usuarioRepository.existsByCorreo(correo);
    }


    public long contarUsuarios() {
        return usuarioRepository.count();
    }

    public List<Usuario> findByGenero(Usuario.Genero genero) {
        return usuarioRepository.findByGenero(genero);
    }

    public List<Usuario> findByActividadFisica(Usuario.ActividadFisica actividadFisica) {
        return usuarioRepository.findByActividadFisica(actividadFisica);
    }
    public boolean cambiarPassword(Integer id, String actual, String nueva) {
        Optional<Usuario> optional = usuarioRepository.findById(id);
        if (optional.isEmpty()) return false;

        Usuario usuario = optional.get();

        // Comprobación directa de la contraseña (texto plano)
        if (!usuario.getContraseña().equals(actual)) {
            return false;
        }

        usuario.setContraseña(nueva);
        usuarioRepository.save(usuario);
        return true;
    }
    public DatosUsuarioDTO getDatosUsuarioDTOByUsername(String username) {
        Usuario usuario = usuarioRepository.findByUsername(username)
            .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con username: " + username));

        DatosUsuarioDTO dto = new DatosUsuarioDTO();

        dto.setAltura(usuario.getAltura());
        dto.setPeso(usuario.getPeso());
        dto.setFechaNacimiento(usuario.getFechaNacimiento());
        dto.setGenero(usuario.getGenero() != null ? usuario.getGenero().name().toLowerCase() : null);
        dto.setObjetivo(usuario.getObjetivo());

        dto.setAlergias(usuario.getAlergias() != null && !usuario.getAlergias().isBlank()
                ? Arrays.stream(usuario.getAlergias().split(",")).map(String::trim).toList()
                : new ArrayList<>());

        dto.setEnfermedades(usuario.getEnfermedades() != null && !usuario.getEnfermedades().isBlank()
                ? Arrays.stream(usuario.getEnfermedades().split(",")).map(String::trim).toList()
                : new ArrayList<>());

        dto.setPreferencias(usuario.getPreferenciasComida() != null && !usuario.getPreferenciasComida().isBlank()
                ? Arrays.stream(usuario.getPreferenciasComida().split(",")).map(String::trim).toList()
                : new ArrayList<>());

        dto.setActividad(usuario.getActividadFisica() != null
                ? usuario.getActividadFisica().name().replace("_", " ").toLowerCase()
                : null);

        return dto;
    }
    
    public BigDecimal calcularIMCUsuario(Integer id) {
        Usuario usuario = getUsuarioById(id);

        BigDecimal altura = usuario.getAltura();
        BigDecimal peso = usuario.getPeso();

        if (altura == null || peso == null || altura.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO;
        }

        return peso.divide(altura.multiply(altura), 2, RoundingMode.HALF_UP);
    }


}
