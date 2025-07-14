package com.nutri.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "gimnasio_ejercicios")
@Data
@NoArgsConstructor
public class GimnasioEjercicio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El nombre del ejercicio es obligatorio")
    @Column(nullable = false, length = 100)
    private String ejercicio;

    @NotBlank(message = "La zona muscular es obligatoria")
    @Column(nullable = false, length = 50)
    private String zona;

    @NotNull(message = "El peso es obligatorio")
    @DecimalMin(value = "0.1", message = "El peso debe ser mayor a cero")
    @Column(nullable = false)
    private Double peso;

    @NotNull(message = "Las repeticiones son obligatorias")
    @Min(value = 1, message = "Debe haber al menos 1 repetición")
    @Column(nullable = false)
    private Integer reps;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seguimiento_id", nullable = false)
    private SeguimientoFisico seguimiento;
}
