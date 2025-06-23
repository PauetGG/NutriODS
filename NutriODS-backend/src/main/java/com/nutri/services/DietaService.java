package com.nutri.services;

import com.nutri.entities.*;
import com.nutri.repositories.ComidaModeloRepository;
import com.nutri.repositories.DietaRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.*;
import java.util.stream.Collectors;

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

    // 🚀 MÉTODO CLAVE: genera una dieta personalizada según el usuario
    public Dieta generarDietaParaUsuario(Usuario usuario) {
        int caloriasObjetivo = calcularCaloriasTotales(usuario);
        int numeroComidasPorDia = 4; // valor fijo o configurable según usuario u opciones

        List<ComidaModelo> comidasAptas = comidaModeloRepository.findAll().stream()
            .filter(c -> esAptaParaUsuario(c, usuario))
            .collect(Collectors.toList());

        List<ComidaDiaria> planSemanal = generarPlanSemanal(comidasAptas, caloriasObjetivo, numeroComidasPorDia);

        Dieta dieta = new Dieta();
        dieta.setUsuario(usuario);
        dieta.setNombre("Dieta personalizada");
        dieta.setDescripcion("Dieta generada automáticamente en función del perfil del usuario");
        dieta.setNumeroComidasDia(numeroComidasPorDia);
        dieta.setCaloriasTotales(caloriasObjetivo); // opcional, si lo tienes en tu entidad
        dieta.setCreated(LocalDateTime.now());
        dieta.setModified(LocalDateTime.now());

        for (ComidaDiaria comidaDiaria : planSemanal) {
            comidaDiaria.setDieta(dieta);
        }

        dieta.setComidasDiarias(planSemanal);

        return dietaRepository.save(dieta);
    }

    private boolean esAptaParaUsuario(ComidaModelo comida, Usuario usuario) {
        String alergias = Optional.ofNullable(usuario.getAlergias()).orElse("").toLowerCase();
        String enfermedades = Optional.ofNullable(usuario.getEnfermedades()).orElse("").toLowerCase();

        if (alergias.contains("lactosa") && !Boolean.TRUE.equals(comida.getSinLactosa())) return false;
        if (alergias.contains("huevo") && !Boolean.TRUE.equals(comida.getSinHuevo())) return false;
        if (alergias.contains("frutos") && !Boolean.TRUE.equals(comida.getSinFrutosSecos())) return false;
        if (alergias.contains("marisco") && !Boolean.TRUE.equals(comida.getSinMarisco())) return false;
        if (alergias.contains("pescado") && !Boolean.TRUE.equals(comida.getSinPescadoAzul())) return false;
        if (alergias.contains("soja") && !Boolean.TRUE.equals(comida.getSinSoja())) return false;
        if (alergias.contains("legumbre") && !Boolean.TRUE.equals(comida.getSinLegumbres())) return false;
        if (alergias.contains("sésamo") && !Boolean.TRUE.equals(comida.getSinSesamo())) return false;

        if (enfermedades.contains("diabetes") && !Boolean.TRUE.equals(comida.getAptaDiabetes())) return false;
        if (enfermedades.contains("hipertension") && !Boolean.TRUE.equals(comida.getAptaHipertension())) return false;
        if (enfermedades.contains("colesterol") && !Boolean.TRUE.equals(comida.getAptaHipercolesterolemia())) return false;
        if (enfermedades.contains("celiac") && !Boolean.TRUE.equals(comida.getAptaCeliacos())) return false;
        if (enfermedades.contains("renal") && !Boolean.TRUE.equals(comida.getAptaRenal())) return false;
        if (enfermedades.contains("anemia") && !Boolean.TRUE.equals(comida.getAptaAnemia())) return false;
        if (enfermedades.contains("obesidad") && !Boolean.TRUE.equals(comida.getAptaObesidad())) return false;
        if (enfermedades.contains("hipotiroidismo") && !Boolean.TRUE.equals(comida.getAptaHipotiroidismo())) return false;
        if (enfermedades.contains("colon") && !Boolean.TRUE.equals(comida.getAptaColonIrritable())) return false;

        return true;
    }

    private int calcularCaloriasTotales(Usuario usuario) {
        int edad = Period.between(usuario.getFechaNacimiento(), LocalDate.now()).getYears();
        double peso = usuario.getPeso().doubleValue();
        double altura = usuario.getAltura().doubleValue(); // en cm

        double tmb = usuario.getGenero().equals("masculino")
            ? 10 * peso + 6.25 * altura - 5 * edad + 5
            : 10 * peso + 6.25 * altura - 5 * edad - 161;

        double factorActividad = switch (usuario.getActividadFisica()) {
            case "sedentario" -> 1.2;
            case "ligero" -> 1.375;
            case "moderado" -> 1.55;
            case "intenso" -> 1.725;
            case "muy intenso" -> 1.9;
            default -> 1.55;
        };

        double mantenimiento = tmb * factorActividad;

        return switch (usuario.getObjetivo()) {
            case "perder_peso" -> (int)(mantenimiento - 500);
            case "ganar_peso" -> (int)(mantenimiento + 500);
            default -> (int)mantenimiento;
        };
    }

    private List<ComidaDiaria> generarPlanSemanal(List<ComidaModelo> comidas, int caloriasTotales, int comidasPorDia) {
        List<ComidaDiaria> plan = new ArrayList<>();
        Random random = new Random();
        int caloriasPorComida = caloriasTotales / comidasPorDia;

        // Mapea los tipos permitidos
        List<ComidaModelo.TipoComida> tiposPermitidos = switch (comidasPorDia) {
            case 3 -> List.of(ComidaModelo.TipoComida.desayuno, ComidaModelo.TipoComida.comida, ComidaModelo.TipoComida.cena);
            case 4 -> List.of(ComidaModelo.TipoComida.desayuno, ComidaModelo.TipoComida.comida, ComidaModelo.TipoComida.merienda, ComidaModelo.TipoComida.cena);
            case 5 -> List.of(ComidaModelo.TipoComida.desayuno, ComidaModelo.TipoComida.almuerzo, ComidaModelo.TipoComida.comida, ComidaModelo.TipoComida.merienda, ComidaModelo.TipoComida.cena);
            default -> List.of(ComidaModelo.TipoComida.desayuno, ComidaModelo.TipoComida.comida, ComidaModelo.TipoComida.cena);
        };

        for (ComidaDiaria.DiaSemana dia : ComidaDiaria.DiaSemana.values()) {
            for (ComidaModelo.TipoComida tipo : tiposPermitidos) {
                List<ComidaModelo> candidatas = comidas.stream()
                    .filter(c -> c.getTipoComida() == tipo && Math.abs(c.getCaloriasTotales() - caloriasPorComida) <= 200)
                    .toList();

                if (!candidatas.isEmpty()) {
                    ComidaModelo seleccionada = candidatas.get(random.nextInt(candidatas.size()));
                    plan.add(new ComidaDiaria(null, null, dia, tipo, seleccionada));
                }
            }
        }

        return plan;
    }
}
