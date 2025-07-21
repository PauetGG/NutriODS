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
    <div className="max-w-3xl mx-auto p-6">
      <h1 className="text-3xl font-bold mb-6 text-center text-blue-800">
        Tus estadísticas
      </h1>

      {/* NUTRITIVAS */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">🥗 Estadísticas nutritivas</summary>
        <div className="p-4 space-y-3 text-gray-700">
          <ResumenGlobalCard completadas={totalComidasConsumidas} total={totalComidasPlanificadas} />
          <CaloriasTotalesGlobalCard datos={datosCalorias} />
          <GraficoNotasComida notas={comidasHastaAyer.map(c => c.notas)} />
        </div>
      </details>

      {/* FÍSICAS */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">
          🏋️ Estadísticas físicas
        </summary>
        <div className="p-4 space-y-3 text-gray-700">
          {loading && <p>Cargando gráficos...</p>}
          {error && <p className="text-red-500">{error}</p>}
          {!loading && !error && (
            <div className="space-y-8">
              {pesoEvolucion && pesoEvolucion.length > 0 && (
                <GraficoEvolucionPeso datos={pesoEvolucion} />
              )}

              {entrenosResistencia && entrenosResistencia.length > 0 && (
                <GraficoEntrenamientoResistencia datos={entrenosResistencia} />
              )}

              {/* Gráfico de evolución por ejercicio */}
              {datos && datos.some(d => d.gimnasioEjercicios && d.gimnasioEjercicios.length > 0) && (
                <GraficoFuerza
                  titulo="Evolución del peso en ejercicios de gimnasio"
                  evolucionPorEjercicio={true}
                  datosEvolucion={
                    datos.flatMap((d) =>
                      d.gimnasioEjercicios.map((ej) => ({
                        ...ej,
                        fecha: d.fecha
                      }))
                    )
                  }
                />
              )}

              {/* Gráfico de evolución de calistenia */}
              {datos && datos.some(d => d.calisteniaEjercicios && d.calisteniaEjercicios.length > 0) && (
                <GraficoCalistenia
                  titulo="Evolución de repeticiones en Calistenia"
                  seguimientoFisico={datos}
                />
              )}
            </div>
          )}
        </div>
      </details>

      {/* MENTALES */}
      <details className="mb-4 border rounded-lg">
      <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">💤 Estadísticas del sueño</summary>
      <div className="p-4 space-y-6 text-gray-700">
        {loadingMentales && <p>Cargando datos del sueño...</p>}
        {errorMentales && <p className="text-red-500">{errorMentales}</p>}

        {!loadingMentales && !errorMentales && datosMentales && datosMentales.length > 0 && (
          <>
            <GraficoCalidadSueno
              datos={datosMentales.map(d => ({
                fecha: d.fecha,
                calidadSueno: d.calidadSueno
              }))}
            />

            <GraficoHorasSueno
              datos={datosMentales.map(d => ({
                fecha: d.fecha,
                suenoHoras: d.suenoHoras
              }))}
            />
          </>
        )}
      </div>
    </details>

      {/* ANÍMICAS */}
      <details className="mb-4 border rounded-lg">
      <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">💖 Estadísticas anímicas</summary>
      <div className="p-4 space-y-6 text-gray-700">
        {!loadingMentales && !errorMentales && datosMentales && datosMentales.length > 0 && (
          <>
          <GraficoEstres
            datos={datosMentales.map(d => ({
              fecha: d.fecha,
              estres: d.estres
            }))}
          />
          <GraficoAnimo
            datos={datosMentales.map(d => ({
              fecha: d.fecha,
              animo: d.animo
            }))}
          />

          <GraficoMotivacion
              datos={datosMentales.map(d => ({
                fecha: d.fecha,
                motivacion: d.motivacion
              }))}
            />
          </>
        )}
      </div>
    </details>

      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">
          🧼 Estadísticas de hábitos
        </summary>
        <div className="p-4 space-y-6 text-gray-700">
          {loadingMentales && <p>Cargando hábitos...</p>}
          {errorMentales && <p className="text-red-500">{errorMentales}</p>}

          {!loadingMentales && !errorMentales && datosMentales && datosMentales.length > 0 && (
            <>
              <GraficoAgua
                datos={datosMentales.map(d => ({
                  fecha: d.fecha,
                  agua: d.agua
                }))}
              />
              <GraficoAireLibre
                datos={datosMentales.map(d => ({
                  fecha: d.fecha,
                  aireLibre: d.aireLibre
                }))}
              />
              <GraficoPantallas
                datos={datosMentales.map(d => ({
                  fecha: d.fecha,
                  pantallas: d.pantallas
                }))}
              />
              <GraficoPasos
                datos={datosMentales.map(d => ({
                  fecha: d.fecha,
                  pasos: d.pasos
                }))}
              />
            </>
          )}
        </div>
      </details>
    </div>
  );
}

export default EstadisticasPage;
