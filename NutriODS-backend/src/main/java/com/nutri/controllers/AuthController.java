package com.nutri.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.DTOs.LoginRegisterRequest;
import com.nutri.entities.Usuario;
import com.nutri.services.UsuarioService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UsuarioService usuarioService;

    // Registro simple: solo correo y contraseña
    @PostMapping("/register")
    public Usuario register(@Valid @RequestBody LoginRegisterRequest request) {
        if (usuarioService.findByCorreo(request.getCorreo()).isPresent()) {
            throw new RuntimeException("El correo ya está en uso");
        }

        Usuario nuevo = new Usuario();
        nuevo.setCorreo(request.getCorreo());
        nuevo.setContraseña(request.getContraseña()); // sin cifrar aún

        return usuarioService.crearUsuario(nuevo);
    }

    // Login simple
    @PostMapping("/login")
    public Usuario login(@Valid @RequestBody LoginRegisterRequest request) {
        return usuarioService.login(request.getCorreo(), request.getContraseña());
    }
}