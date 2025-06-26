package com.nutri.controllers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nutri.entities.ComidaModelo;
import com.nutri.services.ComidaModeloService;

@RestController
@RequestMapping("/api/comidas-modelo")
public class ComidaModeloController {

    @Autowired
    private ComidaModeloService service;

    @GetMapping
    public List<ComidaModelo> findAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public Optional<ComidaModelo> findById(@PathVariable Integer id) {
        return service.findById(id);
    }

    @PostMapping
    public ComidaModelo save(@RequestBody ComidaModelo comidaModelo) {
        return service.save(comidaModelo);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        service.deleteById(id);
    }
    @GetMapping("/tipo/{tipoComida}")
    public List<ComidaModelo> findByTipoComida(@PathVariable ComidaModelo.TipoComida tipoComida) {
        return service.findByTipoComida(tipoComida);
    }

    @GetMapping("/search")
    public List<ComidaModelo> searchByNombre(@RequestParam("nombre") String nombre) {
        return service.searchByNombre(nombre);
    }

    @GetMapping("/calorias")
    public List<ComidaModelo> findByCaloriasRango(@RequestParam("min") int min,
                                                  @RequestParam("max") int max) {
        return service.findByCaloriasRango(min, max);
    }

    @GetMapping("/enfermedad/{enfermedad}")
    public List<ComidaModelo> findAptasPara(@PathVariable String enfermedad) {
        return service.findAptasPara(enfermedad);
    }

    @GetMapping("/alergia/{alergia}")
    public List<ComidaModelo> findSinAlergia(@PathVariable String alergia) {
        return service.findSinAlergia(alergia);
    }

    @GetMapping("/{id}/macros")
    public Map<String, Double> calcularMacrosTotales(@PathVariable Integer id) {
        ComidaModelo comidaModelo = service.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("ComidaModelo no encontrado"));
        return service.calcularMacrosTotales(comidaModelo);
    }
}
