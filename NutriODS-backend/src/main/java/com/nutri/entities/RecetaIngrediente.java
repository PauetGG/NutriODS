package com.nutri.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "receta_ingrediente")
@Data
@NoArgsConstructor
public class RecetaIngrediente {

    @EmbeddedId
    private RecetaIngredienteId id = new RecetaIngredienteId();

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("recetaId")
    @JoinColumn(name = "receta_id", nullable = false)
    @JsonBackReference
    private Receta receta;

    @ManyToOne(fetch = FetchType.EAGER)
    @MapsId("ingredienteId")
    @JoinColumn(name = "ingrediente_id", nullable = false)
    private Ingrediente ingrediente;

    @NotNull(message = "La cantidad es obligatoria")
    @DecimalMin(value = "0.01", message = "La cantidad debe ser mayor que 0")
    private BigDecimal cantidad; // en gramos o unidades
}
