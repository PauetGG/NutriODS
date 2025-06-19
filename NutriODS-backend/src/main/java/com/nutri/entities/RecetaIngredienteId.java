package com.nutri.entities;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecetaIngredienteId implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 3905540954973625160L;
	private Integer recetaId;
    private Integer ingredienteId;

}
