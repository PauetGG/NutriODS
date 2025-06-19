package com.nutri.entities;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Embeddable
@Data
@NoArgsConstructor
public class LikeArticuloId implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = -4875829766903884683L;
	private Integer usuarioId;
    private Integer articuloId;

    public LikeArticuloId(Integer usuarioId, Integer articuloId) {
        this.usuarioId = usuarioId;
        this.articuloId = articuloId;
    }
}
