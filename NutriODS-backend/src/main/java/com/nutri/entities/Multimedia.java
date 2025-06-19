package com.nutri.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "multimedia")
@Data
@NoArgsConstructor
public class Multimedia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El título es obligatorio")
    @Size(max = 150, message = "El título no puede superar los 150 caracteres")
    @Column(nullable = false, length = 150)
    private String titulo;

    @Size(max = 1000, message = "La descripción no puede superar los 1000 caracteres")
    @Column(columnDefinition = "TEXT")
    private String descripcion;

    @NotBlank(message = "La URL es obligatoria")
    @Size(max = 255, message = "La URL no puede superar los 255 caracteres")
    @Column(nullable = false)
    private String url;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private Tipo tipo = Tipo.video;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private Categoria categoria = Categoria.nutricion;

    private Boolean visible = true;

    private LocalDate fechaPublicacion;

    @Column(updatable = false)
    private LocalDateTime creado;

    @PrePersist
    protected void onCreate() {
        this.creado = LocalDateTime.now();
    }

    public enum Tipo {
        video, infografia, pdf, web, otro
    }

    public enum Categoria {
        nutricion, salud, ejercicio, mentalidad, otro
    }
}
