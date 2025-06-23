package com.nutri.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "comida_diaria")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ComidaDiaria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "dieta_id", nullable = false)
    @JsonBackReference
    private Dieta dieta;

    @Enumerated(EnumType.STRING)
    @Column(name = "dia_semana", nullable = false)
    private DiaSemana diaSemana;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_comida", nullable = false)
    private ComidaModelo.TipoComida tipoComida;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "comida_modelo_id", nullable = false)
    private ComidaModelo comidaModelo;

    public enum DiaSemana {
        lunes, martes, miércoles, jueves, viernes, sábado, domingo
    }
}
