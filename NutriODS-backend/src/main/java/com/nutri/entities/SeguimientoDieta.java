package com.nutri.entities;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "seguimiento_dieta")
@Data
@NoArgsConstructor
public class SeguimientoDieta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "La dieta es obligatoria")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dieta_id", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Dieta dieta;

    @NotNull(message = "La comida modelo es obligatoria")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "comida_modelo_id", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private ComidaModelo comidaModelo;


    @NotNull(message = "El día de la semana es obligatorio")
    @Enumerated(EnumType.STRING)
    @Column(name = "dia_semana", nullable = false, length = 10)
    private DiaSemana diaSemana;

    @NotNull(message = "El tipo de comida es obligatorio")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private TipoComida comida;

    private LocalDate fecha;

    @DecimalMin(value = "0.01", message = "Las porciones deben ser mayores que cero")
    private BigDecimal porciones = BigDecimal.ONE;

    private Boolean consumido = false;

    private String notas;

    @Column(nullable = false, updatable = false)
    private LocalDateTime created;

    @PrePersist
    protected void onCreate() {
        this.created = LocalDateTime.now();
    }

    public enum DiaSemana {
        lunes, martes, miércoles, jueves, viernes, sábado, domingo
    }

    public enum TipoComida {
        desayuno, almuerzo, comida, merienda, cena, 
    }
}
