package com.nutri.entities;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "like_respuesta_foro")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LikeRespuestaForo {

    @EmbeddedId
    private LikeRespuestaForoId id = new LikeRespuestaForoId();

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("usuarioId")
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("respuestaId")
    @JoinColumn(name = "respuesta_id", nullable = false)
    private RespuestaForo respuesta;
}
