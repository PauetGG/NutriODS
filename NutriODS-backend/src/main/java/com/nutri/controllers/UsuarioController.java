package com.nutri.controllers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.DTOs.DatosUsuarioDTO;
import com.nutri.entities.Usuario;
import com.nutri.services.UsuarioService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    // GET → Obtener todos los usuarios
    @GetMapping
    public List<Usuario> getAllUsuarios() {
        return usuarioService.getAllUsuarios();
    }

    // GET → Obtener usuario por ID
    @GetMapping("/{id}")
    public Usuario getUsuarioById(@PathVariable Integer id) {
        return usuarioService.getUsuarioById(id);
    }

    // POST → Crear nuevo usuario
    @PostMapping
    public Usuario crearUsuario(@RequestBody Usuario usuario) {
        return usuarioService.crearUsuario(usuario);
    }

    // PUT → Actualizar usuario existente
    @PutMapping("/{id}")
    public Usuario actualizarUsuario(@PathVariable Integer id, @RequestBody Usuario usuario) {
        return usuarioService.actualizarUsuario(id, usuario);
    }

    // DELETE → Eliminar usuario por ID
    @DeleteMapping("/{id}")
    public void eliminarUsuario(@PathVariable Integer id) {
        usuarioService.eliminarUsuario(id);
    }
    
    @PutMapping("/{id}/datos")
    public Usuario actualizarDatosPersonales(@PathVariable Integer id, @Valid @RequestBody DatosUsuarioDTO dto) {
        return usuarioService.actualizarDatosUsuario(id, dto);
    }

    @GetMapping("/correo/{correo}")
    public ResponseEntity<Usuario> findByCorreo(@PathVariable String correo) {
        Optional<Usuario> usuario = usuarioService.findByCorreo(correo);
        return usuario.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
    @GetMapping("/username/{username}")
    public DatosUsuarioDTO getDatosUsuarioPorUsername(@PathVariable String username) {
        return usuarioService.getDatosUsuarioDTOByUsername(username);
    }

    @GetMapping("/count")
    public long contarUsuarios() {
        return usuarioService.contarUsuarios();
    }

    @GetMapping("/genero/{genero}")
    public List<Usuario> findByGenero(@PathVariable Usuario.Genero genero) {
        return usuarioService.findByGenero(genero);
    }

    @GetMapping("/actividad/{actividadFisica}")
    public List<Usuario> findByActividadFisica(@PathVariable Usuario.ActividadFisica actividadFisica) {
        return usuarioService.findByActividadFisica(actividadFisica);
    }
    @PutMapping("/{id}/cambiar-password")
    public ResponseEntity<?> cambiarPassword(@PathVariable Integer id, @RequestBody Map<String, String> pass) {
        String actual = pass.get("actual");
        String nueva = pass.get("nueva");

        boolean cambiada = usuarioService.cambiarPassword(id, actual, nueva);
        if (cambiada) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Contraseña incorrecta");
        }
    }
    
    @GetMapping("/{id}/imc")
    public ResponseEntity<?> calcularIMC(@PathVariable Integer id) {
        try {
            return ResponseEntity.ok(Map.of("imc", usuarioService.calcularIMCUsuario(id)));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error al calcular el IMC");
        }
    }
}
