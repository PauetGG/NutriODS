package com.nutri.DTOs;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class LoginRegisterRequest {
		@NotBlank(message = "El correo es obligatorio")
	    @Email(message = "El formato del correo no es válido")
	    private String correo;
	
	    @NotBlank(message = "La contraseña es obligatoria")
	    @Size(min = 4, max = 255, message = "La contraseña debe tener entre 4 y 255 caracteres")
	    private String contraseña;
}