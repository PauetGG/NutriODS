package com.nutri.services;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.nutri.entities.ComidaDiaria;
import com.nutri.entities.ComidaModelo;
import com.nutri.entities.Dieta;
import com.nutri.entities.Usuario;
import com.nutri.repositories.ComidaModeloRepository;
import com.nutri.repositories.DietaRepository;

@Service
public class DietaService {

    private final DietaRepository dietaRepository;
    private final ComidaModeloRepository comidaModeloRepository;

    public DietaService(DietaRepository dietaRepository, ComidaModeloRepository comidaModeloRepository) {
        this.dietaRepository = dietaRepository;
        this.comidaModeloRepository = comidaModeloRepository;
    }

    public List<Dieta> findAll() {
        return dietaRepository.findAll();
    }

    public Optional<Dieta> findById(Integer id) {
        return dietaRepository.findById(id);
    }

    public Dieta save(Dieta dieta) {
        return dietaRepository.save(dieta);
    }

    public void deleteById(Integer id) {
        dietaRepository.deleteById(id);
    }

    public List<ComidaModelo> obtenerComidasCompatibles(Usuario usuario) {
        List<ComidaModelo> todasLasComidas = comidaModeloRepository.findAll();
    
        return todasLasComidas.stream()
            // Enfermedades
            .filter(c -> !usuario.getEnfermedades().contains("diabetes") || Boolean.TRUE.equals(c.getAptaDiabetes()))
            .filter(c -> !usuario.getEnfermedades().contains("hipertensión") || Boolean.TRUE.equals(c.getAptaHipertension()))
            .filter(c -> !usuario.getEnfermedades().contains("hipercolesterolemia") || Boolean.TRUE.equals(c.getAptaHipercolesterolemia()))
            .filter(c -> !usuario.getEnfermedades().contains("celíaca") || Boolean.TRUE.equals(c.getAptaCeliacos()))
            .filter(c -> !usuario.getEnfermedades().contains("renal") || Boolean.TRUE.equals(c.getAptaRenal()))
            .filter(c -> !usuario.getEnfermedades().contains("anemia") || Boolean.TRUE.equals(c.getAptaAnemia()))
            .filter(c -> !usuario.getEnfermedades().contains("obesidad") || Boolean.TRUE.equals(c.getAptaObesidad()))
            .filter(c -> !usuario.getEnfermedades().contains("hipotiroidismo") || Boolean.TRUE.equals(c.getAptaHipotiroidismo()))
            .filter(c -> !usuario.getEnfermedades().contains("colon irritable") || Boolean.TRUE.equals(c.getAptaColonIrritable()))
    
            // Alergias
            .filter(c -> !usuario.getAlergias().contains("lactosa") || Boolean.TRUE.equals(c.getSinLactosa()))
            .filter(c -> !usuario.getAlergias().contains("frutos secos") || Boolean.TRUE.equals(c.getSinFrutosSecos()))
            .filter(c -> !usuario.getAlergias().contains("marisco") || Boolean.TRUE.equals(c.getSinMarisco()))
            .filter(c -> !usuario.getAlergias().contains("pescado azul") || Boolean.TRUE.equals(c.getSinPescadoAzul()))
            .filter(c -> !usuario.getAlergias().contains("huevo") || Boolean.TRUE.equals(c.getSinHuevo()))
            .filter(c -> !usuario.getAlergias().contains("soja") || Boolean.TRUE.equals(c.getSinSoja()))
            .filter(c -> !usuario.getAlergias().contains("legumbres") || Boolean.TRUE.equals(c.getSinLegumbres()))
            .filter(c -> !usuario.getAlergias().contains("sésamo") || Boolean.TRUE.equals(c.getSinSesamo()))
    
            .collect(Collectors.toList());
    }    

    public int calcularEdad(LocalDate fechaNacimiento) {
        return Period.between(fechaNacimiento, LocalDate.now()).getYears();
    }
    public double calcularMetabolismoBasal(double peso, double altura, int edad, String genero) {
        if (genero.equalsIgnoreCase("masculino")) {
            return 10 * peso + 6.25 * altura - 5 * edad + 5;
        } else {
            return 10 * peso + 6.25 * altura - 5 * edad - 161;
        }
    }
    public double calcularGET(double metabolismoBasal, String nivelActividad) {
        Map<String, Double> factores = new HashMap<>();
        factores.put("sedentario", 1.2);
        factores.put("ligero", 1.375);
        factores.put("moderado", 1.55);
        factores.put("intenso", 1.725);
        factores.put("muy intenso", 1.9);
    
        return metabolismoBasal * factores.getOrDefault(nivelActividad.toLowerCase(), 1.2);
    }
    public double ajustarCaloriasPorObjetivo(double GET, String objetivo) {
        switch (objetivo.toLowerCase()) {
            case "perder peso":
                return GET * 0.8;
            case "ganar peso":
                return GET * 1.15;
            default: // mantener peso
                return GET;
        }
    }
    public Map<String, Double> calcularMacronutrientes(double caloriasObjetivo) {
        Map<String, Double> macros = new HashMap<>();
        // Proteínas: 25%, 4 kcal/g
        macros.put("proteinas", (caloriasObjetivo * 0.25) / 4);
        // Grasas: 25%, 9 kcal/g
        macros.put("grasas", (caloriasObjetivo * 0.25) / 9);
        // Carbohidratos: 50%, 4 kcal/g
        macros.put("carbohidratos", (caloriasObjetivo * 0.5) / 4);
        return macros;
    }
    
    public Dieta generarDietaParaUsuario(Usuario usuario, String nombreDieta, String descripcion, int numeroComidasDia) {
        // 1. Filtrar comidas compatibles
        List<ComidaModelo> comidasCompatibles = obtenerComidasCompatibles(usuario);

        // 2. Calcular calorías y macronutrientes
        int edad = calcularEdad(usuario.getFechaNacimiento());
        double peso = usuario.getPeso().doubleValue();
        double altura = usuario.getAltura().doubleValue();
        String genero = usuario.getGenero().name();
        String nivelActividad = usuario.getActividadFisica().name();
        String objetivo = usuario.getObjetivo();

        double metabolismoBasal = calcularMetabolismoBasal(peso, altura, edad, genero);
        double GET = calcularGET(metabolismoBasal, nivelActividad);
        double caloriasObjetivo = ajustarCaloriasPorObjetivo(GET, objetivo);
        Map<String, Double> macros = calcularMacronutrientes(caloriasObjetivo);

        // 3. Crear la dieta
        Dieta dieta = new Dieta();
        dieta.setUsuario(usuario);
        dieta.setNombre(nombreDieta);
        dieta.setDescripcion(descripcion);
        dieta.setNumeroComidasDia(numeroComidasDia);
        dieta.setProteinasObjetivo(macros.get("proteinas"));
        dieta.setGrasasObjetivo(macros.get("grasas"));
        dieta.setCarbohidratosObjetivo(macros.get("carbohidratos"));

        // 4. Definir el reparto de calorías por tipo de comida según el número de comidas
        Map<ComidaModelo.TipoComida, Double> reparto = new HashMap<>();
        if (numeroComidasDia == 3) {
            reparto.put(ComidaModelo.TipoComida.desayuno, 0.25);
            reparto.put(ComidaModelo.TipoComida.comida, 0.5);
            reparto.put(ComidaModelo.TipoComida.cena, 0.25);
        } else if (numeroComidasDia == 4) {
            reparto.put(ComidaModelo.TipoComida.desayuno, 0.2);
            reparto.put(ComidaModelo.TipoComida.comida, 0.4);
            reparto.put(ComidaModelo.TipoComida.merienda, 0.1);
            reparto.put(ComidaModelo.TipoComida.cena, 0.3);
        } else { // 5 comidas
            reparto.put(ComidaModelo.TipoComida.desayuno, 0.2);
            reparto.put(ComidaModelo.TipoComida.almuerzo, 0.1);
            reparto.put(ComidaModelo.TipoComida.comida, 0.4);
            reparto.put(ComidaModelo.TipoComida.merienda, 0.1);
            reparto.put(ComidaModelo.TipoComida.cena, 0.2);
        }

        List<ComidaDiaria> comidasDiarias = new ArrayList<>();
        for (ComidaDiaria.DiaSemana dia : ComidaDiaria.DiaSemana.values()) {
            for (ComidaModelo.TipoComida tipo : reparto.keySet()) {
                double caloriasObjetivoComida = caloriasObjetivo * reparto.get(tipo);

                // Buscar comidas compatibles para ese tipo
                List<ComidaModelo> candidatas = comidasCompatibles.stream()
                    .filter(c -> c.getTipoComida() == tipo)
                    .collect(Collectors.toList());

                if (!candidatas.isEmpty()) {
                    ComidaModelo seleccionada = candidatas.get((int) (Math.random() * candidatas.size()));

                    // Calcular macros totales de la comida seleccionada
                    // Suponiendo que tienes un método en comidaModeloService:
                    // Map<String, Double> macrosComida = comidaModeloService.calcularMacrosTotales(seleccionada);
                    // Por ahora, usamos caloriasTotales como aproximación:
                    double caloriasComida = seleccionada.getCaloriasTotales();
                    double factor = caloriasComida > 0 ? caloriasObjetivoComida / caloriasComida : 1.0;

                    // Ajustar las cantidades de los ingredientes
                    for (com.nutri.entities.ComidaIngrediente ci : seleccionada.getIngredientes()) {
                        ci.setCantidad(ci.getCantidad().multiply(java.math.BigDecimal.valueOf(factor)));
                    }

                    ComidaDiaria comidaDiaria = new ComidaDiaria();
                    comidaDiaria.setDieta(dieta);
                    comidaDiaria.setDiaSemana(dia);
                    comidaDiaria.setTipoComida(tipo);
                    comidaDiaria.setComidaModelo(seleccionada);
                    comidasDiarias.add(comidaDiaria);
                }
            }
        }
        dieta.setComidasDiarias(comidasDiarias);

        // 5. Guardar la dieta (esto guarda también las comidas diarias por cascade)
        return dietaRepository.save(dieta);
    }
    
    public List<Dieta> findAllConUsuario() {
        return dietaRepository.findAllConUsuario();
    }
    public List<Dieta> findByUsuario(Integer usuarioId) {
        return dietaRepository.findByUsuarioId(usuarioId);
    }

    public List<Dieta> findByCreatedBetween(LocalDateTime start, LocalDateTime end) {
        return dietaRepository.findByCreatedBetween(start, end);
    }

    public long countByUsuario(Integer usuarioId) {
        return dietaRepository.countByUsuarioId(usuarioId);
    }
}
