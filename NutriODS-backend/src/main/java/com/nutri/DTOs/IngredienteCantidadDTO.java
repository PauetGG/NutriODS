package com.nutri.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class IngredienteCantidadDTO {
    private String nombre;
    private double cantidad;
    private String unidad;
}
