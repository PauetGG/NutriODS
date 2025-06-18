package com.nutri.entities;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "usuario")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El correo es obligatorio")
    @Email(message = "El correo no tiene un formato válido")
    @Column(nullable = false, unique = true, length = 100)
    private String correo;

    @NotBlank(message = "La contraseña es obligatoria")
    @Size(min = 4, max = 255, message = "La contraseña debe tener entre 4 y 255 caracteres")
    @Column(nullable = false, length = 255)
    private String contraseña;

    @Size(max = 50, message = "El nombre no debe superar los 50 caracteres")
    @Column(length = 50)
    private String nombre;

    @Size(max = 100, message = "Los apellidos no deben superar los 100 caracteres")
    @Column(length = 100)
    private String apellidos;

    @DecimalMin(value = "0.0", inclusive = false, message = "La altura debe ser positiva")
    @Digits(integer = 3, fraction = 2)
    private BigDecimal altura;

    @DecimalMin(value = "0.0", inclusive = false, message = "El peso debe ser positivo")
    @Digits(integer = 3, fraction = 2)
    private BigDecimal peso;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('masculino', 'femenino', 'otro') DEFAULT 'otro'")
    private Genero genero;

    @Size(max = 255)
    private String objetivo;

    @Size(max = 255)
    private String alergias;

    @Size(max = 255)
    private String enfermedades;

    @Column(name = "preferencias_comida")
    @Size(max = 255)
    private String preferenciasComida;

    @Enumerated(EnumType.STRING)
    @Column(name = "actividad_fisica", columnDefinition = "ENUM('sedentario', 'ligero', 'moderado', 'intenso', 'muy_intenso') DEFAULT 'moderado'")
    private ActividadFisica actividadFisica;

    @Column(name = "created", updatable = false)
    private LocalDateTime creadoEn;

    @Column(name = "modified")
    private LocalDateTime actualizadoEn;

    @PrePersist
    protected void onCreate() {
        LocalDateTime now = LocalDateTime.now();
        creadoEn = now;
        actualizadoEn = now;
    }

    @PreUpdate
    protected void onUpdate() {
        actualizadoEn = LocalDateTime.now();
    }

    public enum Genero {
        masculino, femenino, otro
    }

    public enum ActividadFisica {
        sedentario, ligero, moderado, intenso, muy_intenso
    }
}
