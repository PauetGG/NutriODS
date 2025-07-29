import { useParams } from "react-router-dom";
import { useSeguimientoDieta } from "../hooks/useSeguimientoDieta";
import { useEstadisticasFisicas } from "../hooks/useEstadisticasFisicas";
import { useEstadisticasMentales } from "../hooks/useEstadisticasMentales";
import { isBefore, startOfToday } from "date-fns";
import { groupBy } from "lodash";

import { CaloriasTotalesGlobalCard } from "../components/charts/CaloriasTotalesGlobalCard";
import { ResumenGlobalCard } from "../components/charts/ResumenGlobalCard";
import { GraficoNotasComida } from "../components/charts/GraficoNotasComida";

import GraficoEntrenamientoResistencia from "../components/charts/GraficoEntrenamientoResistencia";
import GraficoEvolucionPeso from "../components/charts/GraficoEvolucionPeso";
import GraficoFuerza from "../components/charts/GraficoFuerza";
import GraficoCalistenia from "../components/charts/GraficoCalistenia";
import GraficoEstres from "../components/charts/GraficoEstres";
import GraficoCalidadSueno from "../components/charts/GraficoCalidadSueno";
import GraficoHorasSueno from "../components/charts/GraficoHoraSueno";
import GraficoAnimo from "../components/charts/GraficoAnimo";
import GraficoMotivacion from "../components/charts/GraficoMotivacion";
import GraficoAgua from "../components/charts/GraficoAgua";
import GraficoAireLibre from "../components/charts/GraficoAireLibre";
import GraficoPantallas from "../components/charts/GraficoPantallas";
import GraficoPasos from "../components/charts/GraficoPasos";

function EstadisticasPage() {
  const { dietaId } = useParams<{ dietaId: string }>();
  const dietaIdNumber = Number(dietaId);
  const { seguimiento } = useSeguimientoDieta(dietaIdNumber);

  const hoy = startOfToday();
  const comidasHastaAyer = seguimiento.filter((c) => isBefore(new Date(c.fecha), hoy));

  const totalComidasPlanificadas = comidasHastaAyer.length;
  const totalComidasConsumidas = comidasHastaAyer.filter((c) => c.consumido).length;

  const agrupadasPorFecha = groupBy(comidasHastaAyer, (c) => c.fecha);

  const datosCalorias = Object.entries(agrupadasPorFecha).map(([fecha, comidas]) => {
    const consumido = comidas
      .filter((c) => c.consumido)
      .reduce((sum, c) => sum + c.comidaModelo.caloriasTotales, 0);

    const objetivo = comidas.reduce((sum, c) => sum + c.comidaModelo.caloriasTotales, 0);

    return {
      fecha,
      consumido,
      objetivo,
    };
  });

  const {
    loading,
    error,
    pesoEvolucion,
    entrenosResistencia,
    datos,
  } = useEstadisticasFisicas();

  const {
    datos: datosMentales,
    loading: loadingMentales,
    error: errorMentales,
  } = useEstadisticasMentales();

  return (
    <div className="max-w-7xl mx-auto p-6 bg-gray-100 min-h-screen">
      <h1 className="text-3xl font-bold mb-6 text-center text-emerald-700">
        Tus estadísticas
      </h1>

      {/* NUTRITIVAS */}
      <details className="mb-6 border rounded-lg shadow-sm">
      <summary className="cursor-pointer bg-emerald-50 hover:bg-emerald-100 active:bg-emerald-200 px-4 py-2 font-semibold text-lg text-emerald-800 rounded-t-lg transition-colors duration-200">
      🥗 Estadísticas nutritivas</summary>
        <div className="p-4 text-gray-700 bg-emerald-50">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <ResumenGlobalCard completadas={totalComidasConsumidas} total={totalComidasPlanificadas} />
           <GraficoNotasComida notas={comidasHastaAyer.map(c => c.notas)} />
          </div>
          <div className="mt-6">
            <CaloriasTotalesGlobalCard datos={datosCalorias} />
          </div>
        </div>
      </details>

      {/* FÍSICAS */}
      <details className="mb-6 border rounded-lg shadow-sm">
       <summary className="cursor-pointer bg-emerald-50 hover:bg-emerald-100 active:bg-emerald-200 px-4 py-2 font-semibold text-lg text-emerald-800 rounded-t-lg transition-colors duration-200">
        🏋️ Estadísticas físicas</summary>
        <div className="p-4 text-gray-700 bg-emerald-50">
          {loading && <p>Cargando gráficos...</p>}
          {error && <p className="text-red-500">{error}</p>}
          {!loading && !error && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {/* Primer gráfico en una columna */}
              {pesoEvolucion?.length > 0 && (
                <div className="col-span-1">
                  <GraficoEvolucionPeso datos={pesoEvolucion} />
                </div>
              )}

              {/* Segundo gráfico en una columna */}
              {entrenosResistencia?.length > 0 && (
                <div className="col-span-1">
                  <GraficoEntrenamientoResistencia datos={entrenosResistencia} />
                </div>
              )}

              {/* Tercero: Calistenia (izquierda) */}
              {datos?.some((d) => d.calisteniaEjercicios?.length > 0) && (
                <div className="col-span-1">
                  <GraficoCalistenia
                    titulo="Evolución de repeticiones en Calistenia"
                    seguimientoFisico={datos}
                  />
                </div>
              )}

              {/* Cuarto: Fuerza (derecha) */}
              {datos?.some((d) => d.gimnasioEjercicios?.length > 0) && (
                <div className="col-span-1">
                  <GraficoFuerza
                    titulo="Evolución del peso en ejercicios de gimnasio"
                    evolucionPorEjercicio={true}
                    datosEvolucion={datos.flatMap((d) =>
                      d.gimnasioEjercicios.map((ej) => ({
                        ...ej,
                        fecha: d.fecha,
                      }))
                    )}
                  />
                </div>
              )}
            </div>
          )}
        </div>
      </details>

      {/* SUEÑO */}
      <details className="mb-6 border rounded-lg shadow-sm">
       <summary className="cursor-pointer bg-emerald-50 hover:bg-emerald-100 active:bg-emerald-200 px-4 py-2 font-semibold text-lg text-emerald-800 rounded-t-lg transition-colors duration-200">
       💤 Estadísticas del sueño</summary>
        <div className="p-4 text-gray-700 bg-emerald-50">
          {loadingMentales && <p>Cargando datos del sueño...</p>}
          {errorMentales && <p className="text-red-500">{errorMentales}</p>}
          {!loadingMentales && !errorMentales && datosMentales?.length > 0 && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <GraficoCalidadSueno datos={datosMentales.map(d => ({ fecha: d.fecha, calidadSueno: d.calidadSueno }))} />
              <GraficoHorasSueno datos={datosMentales.map(d => ({ fecha: d.fecha, suenoHoras: d.suenoHoras }))} />
            </div>
          )}
        </div>
      </details>

     {/* ANÍMICAS */}
      <details className="mb-6 border rounded-lg shadow-sm">
       <summary className="cursor-pointer bg-emerald-50 hover:bg-emerald-100 active:bg-emerald-200 px-4 py-2 font-semibold text-lg text-emerald-800 rounded-t-lg transition-colors duration-200">
       💖 Estadísticas anímicas</summary>
        <div className="p-4 text-gray-700 bg-emerald-50">
          {!loadingMentales && !errorMentales && datosMentales?.length > 0 && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <GraficoEstres
                datos={datosMentales.map((d) => ({ fecha: d.fecha, estres: d.estres }))}
              />
              <GraficoAnimo
                datos={datosMentales.map((d) => ({ fecha: d.fecha, animo: d.animo }))}
              />
              <div className="md:col-span-2 flex justify-center">
                <div className="w-full md:max-w-xl">
                  <GraficoMotivacion
                    datos={datosMentales.map((d) => ({ fecha: d.fecha, motivacion: d.motivacion }))}
                  />
                </div>
              </div>
            </div>
          )}
        </div>
      </details>


      {/* HÁBITOS */}
      <details className="mb-6 border rounded-lg shadow-sm">
        <summary className="cursor-pointer bg-emerald-50 hover:bg-emerald-100 active:bg-emerald-200 px-4 py-2 font-semibold text-lg text-emerald-800 rounded-t-lg transition-colors duration-200">
        🧼 Estadísticas de hábitos </summary>
        <div className="p-4 text-gray-700 bg-emerald-50">
          {loadingMentales && <p>Cargando hábitos...</p>}
          {errorMentales && <p className="text-red-500">{errorMentales}</p>}
          {!loadingMentales && !errorMentales && datosMentales?.length > 0 && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <GraficoAgua datos={datosMentales.map(d => ({ fecha: d.fecha, agua: d.agua }))} />
              <GraficoAireLibre datos={datosMentales.map(d => ({ fecha: d.fecha, aireLibre: d.aireLibre }))} />
              <GraficoPantallas datos={datosMentales.map(d => ({ fecha: d.fecha, pantallas: d.pantallas }))} />
              <GraficoPasos datos={datosMentales.map(d => ({ fecha: d.fecha, pasos: d.pasos }))} />
            </div>
          )}
        </div>
      </details>
    </div>
  );
}

export default EstadisticasPage;
