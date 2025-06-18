package com.nutri.services;

import com.nutri.entities.Usuario;
import com.nutri.repositories.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
        usuarioExistente.setPreferencias(usuarioActualizado.getPreferencias());
        usuarioExistente.setActividad(usuarioActualizado.getActividad());

        return usuarioRepository.save(usuarioExistente);
    }

    // Eliminar usuario
    public void eliminarUsuario(Integer id) {
        Usuario usuario = getUsuarioById(id);
        usuarioRepository.delete(usuario);
    }
}
