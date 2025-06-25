package com.nutri.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
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
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private ComidaModelo comidaModelo;

    public enum DiaSemana {
        lunes, martes, miércoles, jueves, viernes, sábado, domingo
    }
}
