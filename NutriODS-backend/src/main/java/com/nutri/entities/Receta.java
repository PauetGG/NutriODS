package com.nutri.entities;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "receta")
@Data
@NoArgsConstructor
public class Receta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 100, message = "El nombre no puede superar los 100 caracteres")
    @Column(nullable = false, unique = true, length = 100)
    private String nombre;

    @Size(max = 500, message = "La descripción no puede superar los 500 caracteres")
    private String descripcion;

    @NotBlank(message = "Las instrucciones son obligatorias")
    @Column(columnDefinition = "TEXT", nullable = false)
    private String instrucciones;

    @NotNull(message = "El tiempo de preparación es obligatorio")
    @Min(value = 1, message = "El tiempo de preparación debe ser al menos 1 minuto")
    private Integer tiempoPreparacion; // en minutos

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private Dificultad dificultad = Dificultad.media;

    @NotNull(message = "El número de raciones es obligatorio")
    @Min(value = 1, message = "Debe haber al menos una ración")
    private Integer raciones = 1;

    @Size(max = 255, message = "La URL de la imagen no puede superar los 255 caracteres")
    private String imagenUrl;

    private Boolean visible = true;

    @Column(nullable = false, updatable = false)
    private LocalDateTime creado;

    @Column(nullable = false)
    private LocalDateTime modificado;

    // Relación con ingredientes (tabla intermedia)
    @OneToMany(mappedBy = "receta", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<RecetaIngrediente> ingredientes = new HashSet<>();

    @PrePersist
    protected void onCreate() {
        this.creado = LocalDateTime.now();
        this.modificado = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.modificado = LocalDateTime.now();
    }

    public enum Dificultad {
        fácil, media, difícil
    }
}
