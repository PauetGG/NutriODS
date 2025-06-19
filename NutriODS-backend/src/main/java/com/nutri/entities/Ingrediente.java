package com.nutri.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "ingrediente")
@Data
@NoArgsConstructor
public class Ingrediente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 100, message = "El nombre no puede superar los 100 caracteres")
    @Column(nullable = false, unique = true, length = 100)
    private String nombre;

    @Size(max = 300, message = "La descripción no puede superar los 300 caracteres")
    private String descripcion;

    @NotNull(message = "Las calorías son obligatorias")
    @Min(value = 0, message = "Las calorías no pueden ser negativas")
    private Integer calorias; // kcal por 100g

    @DecimalMin(value = "0.0", inclusive = true, message = "La cantidad no puede ser negativa")
    private BigDecimal proteinas;

    @DecimalMin(value = "0.0", inclusive = true, message = "La cantidad no puede ser negativa")
    private BigDecimal grasas;

    @DecimalMin(value = "0.0", inclusive = true, message = "La cantidad no puede ser negativa")
    private BigDecimal carbohidratos;

    @DecimalMin(value = "0.0", inclusive = true, message = "La cantidad no puede ser negativa")
    private BigDecimal fibra;

    @DecimalMin(value = "0.0", inclusive = true, message = "La cantidad no puede ser negativa")
    private BigDecimal azucar;

    @Enumerated(EnumType.STRING)
    @Column(length = 20, nullable = false)
    private TipoIngrediente tipo = TipoIngrediente.otro;

    @NotNull(message = "Debe indicarse si contiene gluten o no")
    private Boolean sinGluten = false;

    @NotNull(message = "Debe indicarse si contiene lactosa o no")
    private Boolean sinLactosa = false;

    @NotNull(message = "Debe indicarse si es apto para veganos o no")
    private Boolean vegano = false;

    @Size(max = 255, message = "La URL de la imagen no puede superar los 255 caracteres")
    private String imagenUrl;

    @Column(nullable = false, updatable = false)
    private LocalDateTime creado;

    @Column(nullable = false)
    private LocalDateTime modificado;

    @PrePersist
    protected void onCreate() {
        this.creado = LocalDateTime.now();
        this.modificado = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.modificado = LocalDateTime.now();
    }

    public enum TipoIngrediente {
        fruta("Fruta"),
        verdura("Verdura"),
        carne("Carne"),
        pescado("Pescado"),
        cereal("Cereal"),
        lácteo("Lácteo"),
        legumbre("Legumbre"),
        fruto_seco("Fruto seco"),
        semilla("Semilla"),
        bebida("Bebida"),
        otro("Otro");

        private final String label;

        TipoIngrediente(String label) {
            this.label = label;
        }

        public String getLabel() {
            return label;
        }
    }
}
