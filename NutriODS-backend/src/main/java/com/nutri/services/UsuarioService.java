package com.nutri.services;

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

        usuario.setNombre(dto.getNombre());
        usuario.setApellidos(dto.getApellidos());
        usuario.setAltura(dto.getAltura());
        usuario.setPeso(dto.getPeso());
        usuario.setFechaNacimiento(dto.getFechaNacimiento());
        usuario.setGenero(Usuario.Genero.valueOf(dto.getGenero()));
        usuario.setObjetivo(dto.getObjetivo());
        usuario.setAlergias(dto.getAlergias());
        usuario.setEnfermedades(dto.getEnfermedades());
        usuario.setPreferenciasComida(dto.getPreferencias());
        usuario.setActividadFisica(Usuario.ActividadFisica.valueOf(dto.getActividad().replace(" ", "_")));
        return usuarioRepository.save(usuario);
    }

}
