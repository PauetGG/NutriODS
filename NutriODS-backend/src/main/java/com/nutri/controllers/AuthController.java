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

    @PostMapping("/register")
    public Usuario register(@Valid @RequestBody LoginRegisterRequest request) {
        // Validaciones
        if (usuarioService.findByCorreo(request.getCorreo()).isPresent()) {
            throw new RuntimeException("El correo ya está en uso");
        }
        if (usuarioService.findByUsername(request.getUsername()).isPresent()) {
            throw new RuntimeException("El nombre de usuario ya existe");
        }

        Usuario nuevo = new Usuario();
        nuevo.setUsername(request.getUsername());
        nuevo.setCorreo(request.getCorreo());
        nuevo.setContraseña(request.getContraseña()); // Aquí sería ideal cifrarla
        nuevo.setNombre(request.getNombre());
        nuevo.setApellidos(request.getApellidos());

        return usuarioService.crearUsuario(nuevo);
    }

    // ===================================================
    // ✅ LOGIN
    // ===================================================
    // Ahora usaremos el campo `username` tanto para usuario como para correo electrónico
    @PostMapping("/login")
    public Usuario login(@Valid @RequestBody LoginRegisterRequest request) {
        String loginInput = request.getUsername();
        String contraseña = request.getContraseña();

        // Intenta primero por CORREO
        return usuarioService.findByCorreo(loginInput)
                .filter(usuario -> usuario.getContraseña().equals(contraseña))
                .or(() -> usuarioService.findByUsername(loginInput)
                        .filter(usuario -> usuario.getContraseña().equals(contraseña)))
                .orElseThrow(() -> new RuntimeException("Usuario o contraseña incorrectos"));
    }
}