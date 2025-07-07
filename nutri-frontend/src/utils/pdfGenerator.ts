import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import type { Seguimiento } from "../hooks/useSeguimientoDieta";

export const generarPDFMensualSimple = (
  seguimiento: Seguimiento[],
  fechaActual: Date
) => {
  const doc = new jsPDF("landscape");
  const diasSemana = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"];

  const year = fechaActual.getFullYear();
  const month = fechaActual.getMonth();
  const totalDiasMes = new Date(year, month + 1, 0).getDate();

  const semanas: string[][] = [];
  let semanaActual = Array(7).fill("");

  for (let dia = 1; dia <= totalDiasMes; dia++) {
    const fecha = new Date(year, month, dia);
    const diaSemana = (fecha.getDay() + 6) % 7;

    const fechaISO = fecha.toISOString().split("T")[0];
    const comidasDelDia = seguimiento
      .filter((c) => c.fecha.startsWith(fechaISO))
      .map((c) => c.comidaModelo.nombre);

    const textoComidas = comidasDelDia.length > 0
      ? `${dia}:\n${comidasDelDia.join("\n")}`
      : `${dia}:`;

    semanaActual[diaSemana] = textoComidas;

    if (diaSemana === 6 || dia === totalDiasMes) {
      semanas.push(semanaActual);
      semanaActual = Array(7).fill("");
    }
  }

  doc.setFontSize(14);
  doc.text(
    `Seguimiento mensual – ${fechaActual.toLocaleDateString("es-ES", {
      month: "long",
      year: "numeric",
    })}`,
    14,
    20
  );

  autoTable(doc, {
    head: [diasSemana],
    body: semanas,
    startY: 30,
    styles: {
      fontSize: 8,
      cellPadding: 3,
      minCellHeight: 28, // se aplica por defecto, pero lo ajustamos por seguridad
    },
    headStyles: {
      fillColor: [0, 102, 204],
      minCellHeight: 12, // explícitamente más bajo que el body
    },
    bodyStyles: {
      minCellHeight: 36, // altura mínima solo para las celdas de contenido
      valign: "top",
    },
  });

  doc.save("seguimiento-mensual.pdf");
};
