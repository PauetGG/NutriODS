package com.nutri.entities;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "comida_modelo")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ComidaModelo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_comida", nullable = false)
    private TipoComida tipoComida;

    @Column(name = "calorias_totales", nullable = false)
    private Integer caloriasTotales;

    // Booleans de enfermedades y alergias
    private Boolean aptaDiabetes = true;
    private Boolean aptaHipertension = true;
    private Boolean aptaHipercolesterolemia = true;
    private Boolean aptaCeliacos = true;
    private Boolean aptaRenal = true;
    private Boolean aptaAnemia = true;
    private Boolean aptaObesidad = true;
    private Boolean aptaHipotiroidismo = true;
    private Boolean aptaColonIrritable = true;

    private Boolean sinLactosa = false;
    private Boolean sinFrutosSecos = false;
    private Boolean sinMarisco = false;
    private Boolean sinPescadoAzul = false;
    private Boolean sinHuevo = false;
    private Boolean sinSoja = false;
    private Boolean sinLegumbres = false;
    private Boolean sinSesamo = false;

    @Column(nullable = false, updatable = false)
    private LocalDateTime created;

    @PrePersist
    protected void onCreate() {
        this.created = LocalDateTime.now();
    }

    @OneToMany(mappedBy = "comidaModelo", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<ComidaIngrediente> ingredientes = new ArrayList<>();



    public enum TipoComida {
        desayuno, almuerzo, comida, merienda, cena
    }
}
