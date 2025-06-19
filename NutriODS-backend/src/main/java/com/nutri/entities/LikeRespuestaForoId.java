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
public class LikeRespuestaForoId implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1312902005133173486L;
	private Integer usuarioId;
    private Integer respuestaId;

}
