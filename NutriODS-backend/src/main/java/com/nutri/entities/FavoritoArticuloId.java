package com.nutri.entities;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Embeddable
@Data
@NoArgsConstructor
public class FavoritoArticuloId implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = -9176089940705130381L;
	private Integer usuarioId;
    private Integer articuloId;

    public FavoritoArticuloId(Integer usuarioId, Integer articuloId) {
        this.usuarioId = usuarioId;
        this.articuloId = articuloId;
    }
}
