package com.nutri.DTOs;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class DatosUsuarioDTO {

    @Size(min = 2, max = 50, message = "El nombre debe tener entre 2 y 50 caracteres")
    private String nombre;

    @Size(min = 2, max = 100, message = "Los apellidos deben tener entre 2 y 100 caracteres")
    private String apellidos;

    @DecimalMin(value = "0.5", inclusive = true, message = "La altura debe ser al menos 0.5 metros")
    @DecimalMax(value = "2.5", inclusive = true, message = "La altura no puede superar los 2.5 metros")
    private BigDecimal altura;

    @DecimalMin(value = "20.0", inclusive = true, message = "El peso debe ser al menos 20 kg")
    @DecimalMax(value = "300.0", inclusive = true, message = "El peso no puede superar los 300 kg")
    private BigDecimal peso;

    @Past(message = "La fecha de nacimiento debe ser una fecha pasada")
    private LocalDate fechaNacimiento;

    @Pattern(
        regexp = "masculino|femenino|otro",
        message = "El género debe ser masculino, femenino u otro"
    )
    private String genero;

    @Size(max = 255, message = "El objetivo no puede superar los 255 caracteres")
    private String objetivo;

    private List<String> alergias;
    private List<String> enfermedades;
    private List<String> preferencias;

    @Pattern(
        regexp = "sedentario|ligero|moderado|intenso|muy intenso",
        message = "La actividad física debe ser: sedentario, ligero, moderado, intenso o muy intenso"
    )
    private String actividad;
}
