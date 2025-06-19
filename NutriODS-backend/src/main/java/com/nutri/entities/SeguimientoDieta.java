package com.nutri.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
    private Dieta dieta;

    @NotNull(message = "La receta es obligatoria")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receta_id", nullable = false)
    private Receta receta;

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
        desayuno, almuerzo, cena, snack
    }
}
