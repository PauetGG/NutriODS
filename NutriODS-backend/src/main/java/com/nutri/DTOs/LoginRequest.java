package com.nutri.DTOs;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class LoginRequest {
    @NotBlank(message = "El identificador es obligatorio") // puede ser username o correo
    private String identificador;

    @NotBlank(message = "La contraseña es obligatoria")
    private String contraseña;
}
