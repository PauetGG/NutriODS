package com.nutri.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.DTOs.LoginRequest;
import com.nutri.DTOs.RegisterRequest;
import com.nutri.entities.Usuario;
import com.nutri.services.UsuarioService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UsuarioService usuarioService;

    @PostMapping("/register")
    public Usuario register(@Valid @RequestBody RegisterRequest request) {
        if (usuarioService.findByCorreo(request.getCorreo()).isPresent()) {
            throw new RuntimeException("El correo ya está en uso");
        }
        if (usuarioService.findByUsername(request.getUsername()).isPresent()) {
            throw new RuntimeException("El nombre de usuario ya existe");
        }

        Usuario nuevo = new Usuario();
        nuevo.setUsername(request.getUsername());
        nuevo.setCorreo(request.getCorreo());
        nuevo.setContraseña(request.getContraseña()); // Recuerda: cifrar con BCrypt si lo usas
        nuevo.setNombre(request.getNombre());
        nuevo.setApellidos(request.getApellidos());

        return usuarioService.crearUsuario(nuevo);
    }

    @PostMapping("/login")
    public Usuario login(@Valid @RequestBody LoginRequest request) {
        String identificador = request.getIdentificador();
        String contraseña = request.getContraseña();

        return usuarioService.findByCorreo(identificador)
                .filter(usuario -> usuario.getContraseña().equals(contraseña))
                .or(() -> usuarioService.findByUsername(identificador)
                        .filter(usuario -> usuario.getContraseña().equals(contraseña)))
                .orElseThrow(() -> new RuntimeException("Usuario o contraseña incorrectos"));
    }
}
