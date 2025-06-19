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
@Table(name = "favorito_articulo")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FavoritoArticulo {

    @EmbeddedId
    private FavoritoArticuloId id = new FavoritoArticuloId();

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("usuarioId")
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("articuloId")
    @JoinColumn(name = "articulo_id", nullable = false)
    private Articulo articulo;
}
