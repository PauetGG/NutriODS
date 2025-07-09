package com.nutri.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CaloriasDiaDTO {
    private String dia;
    private int objetivo;
    private int consumido;
}
