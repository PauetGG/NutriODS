package com.nutri.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GenerarDietaRequest {
		private Integer usuarioId;
	    private String nombreDieta;
	    private String descripcion;
	    private int numeroComidasDia;
}
