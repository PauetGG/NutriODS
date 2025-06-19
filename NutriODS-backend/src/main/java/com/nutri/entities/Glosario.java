package com.nutri.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "glosario")
@Data
@NoArgsConstructor
public class Glosario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El término es obligatorio")
    @Size(max = 100, message = "El término no puede superar los 100 caracteres")
    @Column(nullable = false, unique = true, length = 100)
    private String termino;

    @NotBlank(message = "La definición es obligatoria")
    @Column(columnDefinition = "TEXT", nullable = false)
    private String definicion;

    @Size(max = 255, message = "La fuente no puede superar los 255 caracteres")
    private String fuente;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private Categoria categoria = Categoria.otro;

    @Size(max = 255, message = "La URL de la imagen no puede superar los 255 caracteres")
    private String imagenUrl;

    private Boolean visible = true;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @PrePersist
    protected void onCreate() {
        this.fechaCreacion = LocalDateTime.now();
    }

    public enum Categoria {
        concepto,
        macronutriente,
        micronutriente,
        vitamina,
        mineral,
        suplemento,
        dieta,
        deporte,
        otro
    }
}
