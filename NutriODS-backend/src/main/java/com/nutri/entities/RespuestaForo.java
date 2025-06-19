package com.nutri.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "respuesta_foro")
@Data
@NoArgsConstructor
public class RespuestaForo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tema_foro_id", nullable = false)
    private TemaForo tema;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    @NotBlank(message = "El contenido no puede estar vacío")
    @Column(columnDefinition = "TEXT", nullable = false)
    private String contenido;

    private Integer visitas = 0;

    @Column(nullable = false, updatable = false)
    private LocalDateTime created;

    @Column(nullable = false)
    private LocalDateTime modified;

    @OneToMany(mappedBy = "respuesta", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<LikeRespuestaForo> likes = new HashSet<>();

    @PrePersist
    protected void onCreate() {
        this.created = LocalDateTime.now();
        this.modified = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.modified = LocalDateTime.now();
    }
}
