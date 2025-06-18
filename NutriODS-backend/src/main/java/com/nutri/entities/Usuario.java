package com.nutri.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true, length = 100)
    private String correo;

    @Column(nullable = false, length = 255)
    private String contraseña;

    @Column(nullable = false, length = 50)
    private String nombre;

    @Column(length = 100)
    private String apellidos;

    @Column(precision = 5, scale = 2)
    private Double altura;

    @Column(precision = 5, scale = 2)
    private Double peso;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('masculino', 'femenino', 'otro') DEFAULT 'otro'")
    private Genero genero;

    @Column(length = 255)
    private String objetivo;

    @Column(length = 255)
    private String alergias;

    @Column(length = 255)
    private String enfermedades;

    @Column(name = "preferencias_comida", length = 255)
    private String preferenciasComida;

    @Enumerated(EnumType.STRING)
    @Column(name = "actividad_fisica", columnDefinition = "ENUM('sedentario', 'ligero', 'moderado', 'intenso', 'muy intenso') DEFAULT 'moderado'")
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

    // Enums internos o externos si los prefieres
    public enum Genero {
        masculino, femenino, otro
    }

    public enum ActividadFisica {
        sedentario, ligero, moderado, intenso, muy_intenso
    }
}
