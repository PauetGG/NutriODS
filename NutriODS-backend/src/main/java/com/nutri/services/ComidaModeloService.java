package com.nutri.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutri.entities.ComidaIngrediente;
import com.nutri.entities.ComidaModelo;
import com.nutri.entities.Ingrediente;
import com.nutri.repositories.ComidaModeloRepository;

@Service
public class ComidaModeloService {

    @Autowired
    private ComidaModeloRepository repository;

    public List<ComidaModelo> findAll() {
        return repository.findAll();
    }

    public Optional<ComidaModelo> findById(Integer id) {
        return repository.findById(id);
    }

    public ComidaModelo save(ComidaModelo comidaModelo) {
        return repository.save(comidaModelo);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
    
    public Map<String, Double> calcularMacrosTotales(ComidaModelo comidaModelo) {
        double proteinas = 0;
        double grasas = 0;
        double carbohidratos = 0;
        double calorias = 0;

        for (ComidaIngrediente ci : comidaModelo.getIngredientes()) {
            Ingrediente ing = ci.getIngrediente();
            double cantidad = ci.getCantidad().doubleValue(); // en gramos o ml

            // Suponemos que los macros y calorías son por 100g/ml
            double factor = cantidad / 100.0;

            proteinas += (ing.getProteinas() != null ? ing.getProteinas().doubleValue() : 0) * factor;
            grasas += (ing.getGrasas() != null ? ing.getGrasas().doubleValue() : 0) * factor;
            carbohidratos += (ing.getCarbohidratos() != null ? ing.getCarbohidratos().doubleValue() : 0) * factor;
            calorias += (ing.getCalorias() != null ? ing.getCalorias() : 0) * factor;
        }

        Map<String, Double> macros = new HashMap<>();
        macros.put("proteinas", proteinas);
        macros.put("grasas", grasas);
        macros.put("carbohidratos", carbohidratos);
        macros.put("calorias", calorias);
        return macros;
    }
    
    public List<ComidaModelo> findByTipoComida(ComidaModelo.TipoComida tipoComida) {
        return repository.findByTipoComida(tipoComida);
    }

    public List<ComidaModelo> searchByNombre(String nombre) {
        return repository.findByNombreContainingIgnoreCase(nombre);
    }

    public List<ComidaModelo> findByCaloriasRango(int min, int max) {
        return repository.findByCaloriasTotalesBetween(min, max);
    }

    public List<ComidaModelo> findAptasPara(String enfermedad) {
        return repository.findAll()
                .stream()
                .filter(comida -> {
                    switch (enfermedad.toLowerCase()) {
                        case "diabetes": return comida.getAptaDiabetes();
                        case "hipertension": return comida.getAptaHipertension();
                        case "hipercolesterolemia": return comida.getAptaHipercolesterolemia();
                        case "celiacos": return comida.getAptaCeliacos();
                        case "renal": return comida.getAptaRenal();
                        case "anemia": return comida.getAptaAnemia();
                        case "obesidad": return comida.getAptaObesidad();
                        case "hipotiroidismo": return comida.getAptaHipotiroidismo();
                        case "colon irritable": return comida.getAptaColonIrritable();
                        default: return true;
                    }
                })
                .toList();
    }

    public List<ComidaModelo> findSinAlergia(String alergia) {
        return repository.findAll()
                .stream()
                .filter(comida -> {
                    switch (alergia.toLowerCase()) {
                        case "lactosa": return comida.getSinLactosa();
                        case "frutos secos": return comida.getSinFrutosSecos();
                        case "marisco": return comida.getSinMarisco();
                        case "pescado azul": return comida.getSinPescadoAzul();
                        case "huevo": return comida.getSinHuevo();
                        case "soja": return comida.getSinSoja();
                        case "legumbres": return comida.getSinLegumbres();
                        case "sésamo": return comida.getSinSesamo();
                        default: return true;
                    }
                })
                .toList();
    }
}
