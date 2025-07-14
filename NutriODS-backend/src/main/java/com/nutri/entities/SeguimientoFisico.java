package com.nutri.entities;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "seguimiento_fisico")
@Data
@NoArgsConstructor
public class SeguimientoFisico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dieta_id", nullable = false)
    @NotNull(message = "La dieta es obligatoria")
    private Dieta dieta;


    @NotNull(message = "El día de la semana es obligatorio")
    @Enumerated(EnumType.STRING)
    @Column(name = "dia_semana", nullable = false, length = 10)
    private DiaSemana diaSemana;

    @NotNull(message = "El número de semana es obligatorio")
    @Column(nullable = false)
    private Integer semana;

    @NotNull(message = "El peso es obligatorio")
    @DecimalMin(value = "30.0", message = "El peso mínimo permitido es 30 kg")
    @DecimalMax(value = "200.0", message = "El peso máximo permitido es 200 kg")
    @Column(nullable = false, precision = 5, scale = 2)
    private BigDecimal peso;

    @NotNull(message = "Debe indicarse si entrenó hoy")
    @Column(name = "entreno_hoy", nullable = false)
    private Boolean entrenoHoy;

    @Column(name = "tipo_entreno", length = 20)
    private String tipoEntreno;

    @Column(name = "tipo_fuerza", length = 20)
    private String tipoFuerza;

    @DecimalMin(value = "0.0", message = "La velocidad no puede ser negativa")
    private Double velocidad;

    @DecimalMin(value = "0.0", message = "El tiempo no puede ser negativo")
    private Double tiempo;

    @OneToMany(mappedBy = "seguimiento", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<GimnasioEjercicio> gimnasioEjercicios;

    @OneToMany(mappedBy = "seguimiento", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<CalisteniaEjercicio> calisteniaEjercicios;

    @NotNull(message = "La fecha es obligatoria")
    @Column(nullable = false)
    private LocalDate fecha;

    @Column(nullable = false, updatable = false)
    private LocalDateTime created;

    @PrePersist
    protected void onCreate() {
        this.created = LocalDateTime.now();
    }

    public enum DiaSemana {
        lunes, martes, miércoles, jueves, viernes, sábado, domingo
    }
}
