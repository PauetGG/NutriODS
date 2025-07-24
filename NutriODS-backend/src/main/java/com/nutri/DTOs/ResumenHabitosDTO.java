package com.nutri.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ResumenHabitosDTO {
    private int agua;
    private int sueno;
    private int ejercicio;
    private int energia;
    private int estres;
    private int motivacion;
}
