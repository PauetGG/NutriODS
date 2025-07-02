package com.nutri.entities;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "comentario_articulo")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ComentarioArticulo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "articulo_id", nullable = false)
    @JsonBackReference
    private Articulo articulo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id", nullable = false)
    @JsonManagedReference
    private Usuario usuario;

    @NotBlank(message = "El comentario no puede estar vacío")
    @Column(columnDefinition = "TEXT", nullable = false)
    private String contenido;

    @Column(nullable = false, updatable = false)
    private LocalDateTime created;

    @PrePersist
    protected void onCreate() {
        this.created = LocalDateTime.now();
    }
}
