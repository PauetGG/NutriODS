package com.nutri.entities;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "seguimiento_habitos")
@Data
@NoArgsConstructor
public class SeguimientoHabitos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "La dieta es obligatoria")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dieta_id", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Dieta dieta;

    @NotNull(message = "La fecha es obligatoria")
    @Column(nullable = false)
    private LocalDate fecha;

    @NotNull
    @DecimalMin(value = "0.0", message = "El agua debe ser mayor o igual a 0")
    @Column(nullable = false, precision = 4, scale = 2)
    private BigDecimal agua;

    @NotNull
    @DecimalMin(value = "0.0", message = "Las horas de sueño deben ser mayor o igual a 0")
    @Column(name = "sueno_horas", nullable = false, precision = 3, scale = 1)
    private BigDecimal suenoHoras;

    @NotNull
    @Column(name = "calidad_sueno", nullable = false)
    private Integer calidadSueno;

    @NotNull
    @Column(nullable = false)
    private Integer pasos;

    @NotNull
    @Column(nullable = false)
    private Integer animo;

    @NotNull
    @Column(nullable = false)
    private Integer estres;

    @NotNull
    @Column(nullable = false)
    private Integer motivacion;

    @NotNull
    @Column(name = "aire_libre", nullable = false)
    private Integer aireLibre;

    @NotNull
    @Column(nullable = false, precision = 3, scale = 1)
    private BigDecimal pantallas;

    @Column(columnDefinition = "TEXT")
    private String reflexion;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}