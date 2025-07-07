package com.nutri.entities;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "seguimiento_personal")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SeguimientoPersonal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull(message = "El usuario es obligatorio")
    @ManyToOne(optional = false)
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    @NotNull(message = "La fecha es obligatoria")
    private LocalDate fecha;

    // Bienestar y energía
    @Min(1) @Max(5)
    private Integer energia;

    @Min(1) @Max(5)
    private Integer calidadSueno;

    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer = 2, fraction = 2)
    private BigDecimal horasDormidas;

    @Min(1) @Max(5)
    private Integer estadoAnimo;

    @Min(1) @Max(5)
    private Integer estres;

    @Size(max = 255)
    private String molestias;

    // Ejercicio físico
    @Min(0)
    private Integer pasos;

    @Min(0)
    private Integer minutosEjercicio;

    @Size(max = 100)
    private String tipoEjercicio;

    @Min(0)
    private Integer caloriasQuemadas;

    // Hábitos y motivación
    @DecimalMin(value = "0.0")
    @Digits(integer = 2, fraction = 2)
    private BigDecimal aguaLitros;

    @Min(1) @Max(5)
    private Integer hambre;

    @Min(1) @Max(5)
    private Integer motivacion;

    private Boolean objetivoCumplido;

    // Medidas corporales
    @DecimalMin(value = "0.0") @Digits(integer = 5, fraction = 2)
    private BigDecimal cintura;

    @DecimalMin(value = "0.0") @Digits(integer = 5, fraction = 2)
    private BigDecimal cadera;

    @DecimalMin(value = "0.0") @Digits(integer = 5, fraction = 2)
    private BigDecimal pecho;

    @DecimalMin(value = "0.0") @Digits(integer = 5, fraction = 2)
    private BigDecimal grasaCorporal;

    @Size(max = 1000)
    private String reflexiones;

    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime created;

    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime modified;
}
