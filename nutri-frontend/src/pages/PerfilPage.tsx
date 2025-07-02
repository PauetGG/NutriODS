import { useEffect, useState } from "react";
import { useAuth } from "../context/useAuth";

type Usuario = {
  id: number;
  correo: string;
  username: string;
  nombre: string;
  apellidos?: string;
  altura?: number;
  peso?: number;
  fechaNacimiento?: string;
  genero: "masculino" | "femenino" | "otro";
  objetivo?: string;
  alergias: string[];
  enfermedades: string[];
  preferenciasComida: string[];
  actividadFisica: "sedentario" | "ligero" | "moderado" | "intenso" | "muy_intenso";
};

export default function PerfilPage() {
  const { id } = useAuth();
  const [usuario, setUsuario] = useState<Usuario | null>(null);
  const [mensaje, setMensaje] = useState("");
  const [password, setPassword] = useState({ actual: "", nueva: "" });
  const [mensajePassword, setMensajePassword] = useState("");
  const ALERGIAS = ["gluten", "lactosa", "frutos secos", "marisco", "soja", "huevo"];
  const ENFERMEDADES = ["diabetes", "hipertension", "obesidad", "anemia", "renal", "hipotiroidismo", "colon irritable"];
  const PREFERENCIAS = ["vegetariano", "vegano", "sin carne", "sin pescado"];
  const OBJETIVOS = [
    { value: "perder_peso", label: "Perder peso" },
    { value: "mantener", label: "Mantener peso" },
    { value: "ganar_peso", label: "Ganar masa muscular" },
  ];

  useEffect(() => {
    if (!id) return;

    fetch(`http://localhost:8080/api/usuarios/${id}`)
      .then(res => {
        if (!res.ok) throw new Error(`Error HTTP: ${res.status}`);
        return res.json();
      })
      .then(data => setUsuario(data))
      .catch(err => {
        console.error("Error al cargar usuario", err);
        setMensaje("No se pudo cargar el perfil del usuario");
      });
  }, [id]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    if (!usuario) return;
    setUsuario({ ...usuario, [name]: value });
  };

  const handleChangePassword = async () => {
    if (!id) return;

    try {
        const res = await fetch(`http://localhost:8080/api/usuarios/${id}/cambiar-password`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(password),
        });

        if (res.ok) {
        setMensajePassword("✅ Contraseña actualizada correctamente");
        setPassword({ actual: "", nueva: "" });
        } else if (res.status === 403) {
        setMensajePassword("❌ Contraseña actual incorrecta");
        } else {
        setMensajePassword("❌ Error al actualizar la contraseña");
        }
    } catch (error) {
        console.error(error);
        setMensajePassword("❌ Error de red");
    }
    };

  const handleSubmit = async () => {
    if (!id || !usuario) return;

    try {
      const res = await fetch(`http://localhost:8080/api/usuarios/${id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(usuario),
      });

      if (res.ok) {
        setMensaje("✅ Datos actualizados correctamente");
      } else {
        setMensaje("❌ Error al actualizar los datos");
      }
    } catch (error) {
      console.error(error);
      setMensaje("❌ Error de red al guardar");
    }
  };

  if (!usuario) return <p className="p-4">Cargando datos del perfil...</p>;

  return (
    <div className="max-w-3xl mx-auto p-6 pt-15">
      <h1 className="text-3xl font-bold mb-6 text-center">Mi perfil</h1>

      {/* Datos personales */}
      <details open className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">Datos personales</summary>
        <div className="p-4 space-y-4">
          <FormInput label="Nombre" name="nombre" value={usuario.nombre} onChange={handleChange} />
          <FormInput label="Apellidos" name="apellidos" value={usuario.apellidos || ""} onChange={handleChange} />
          <FormInput label="Usuario" name="username" value={usuario.username} disabled />
          <FormInput label="Correo electrónico" name="correo" value={usuario.correo} disabled />
          <FormInput label="Fecha de nacimiento" name="fechaNacimiento" type="date" value={usuario.fechaNacimiento || ""} onChange={handleChange} />
         <SelectInput
            label="Género"
            name="genero"
            value={usuario.genero}
            onChange={handleChange}
            options={[
                { value: "masculino", label: "Masculino" },
                { value: "femenino", label: "Femenino" },
                { value: "otro", label: "Otro" },
            ]}
            />
        </div>
      </details>

      {/* Medidas y actividad */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">Actividad y cuerpo</summary>
        <div className="p-4 space-y-4">
          <FormInput label="Altura (cm)" name="altura" value={usuario.altura || ""} onChange={handleChange} />
          <FormInput label="Peso (kg)" name="peso" value={usuario.peso || ""} onChange={handleChange} />
         <SelectInput
            label="Actividad física"
            name="actividadFisica"
            value={usuario.actividadFisica}
            onChange={handleChange}
            options={[
                { value: "sedentario", label: "Sedentario" },
                { value: "ligero", label: "Ligero" },
                { value: "moderado", label: "Moderado" },
                { value: "intenso", label: "Intenso" },
                { value: "muy_intenso", label: "Muy intenso" },
            ]}
            />
        </div>
      </details>

      {/* Salud y preferencias */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">Salud y preferencias</summary>
        <div className="p-4 space-y-4">
         <CheckboxGroup
            label="Alergias"
            name="alergias"
            options={ALERGIAS}
            selected={usuario.alergias}
            onChange={(updated) => setUsuario({ ...usuario, alergias: updated })}
            />

            <CheckboxGroup
            label="Enfermedades"
            name="enfermedades"
            options={ENFERMEDADES}
            selected={usuario.enfermedades}
            onChange={(updated) => setUsuario({ ...usuario, enfermedades: updated })}
            />

            <CheckboxGroup
            label="Preferencias alimentarias"
            name="preferenciasComida"
            options={PREFERENCIAS}
            selected={usuario.preferenciasComida}
            onChange={(updated) => setUsuario({ ...usuario, preferenciasComida: updated })}
            />

           <SelectInput
            label="Objetivo"
            name="objetivo"
            value={usuario.objetivo || ""}
            onChange={handleChange}
            options={OBJETIVOS}
            />
        </div>
      </details>

      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">Cambiar contraseña</summary>
        <div className="p-4 space-y-4">
            <FormInput
            label="Contraseña actual"
            name="actual"
            type="password"
            value={password.actual}
            onChange={e => setPassword({ ...password, actual: e.target.value })}
            />
            <FormInput
            label="Nueva contraseña"
            name="nueva"
            type="password"
            value={password.nueva}
            onChange={e => setPassword({ ...password, nueva: e.target.value })}
            />
            <button
            onClick={handleChangePassword}
            className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition"
            >
            Cambiar contraseña
            </button>
            {mensajePassword && <p className="text-sm text-blue-600">{mensajePassword}</p>}
        </div>
        </details>

      <div className="text-center">
        <button onClick={handleSubmit} className="bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 transition">
          Guardar cambios
        </button>
        {mensaje && <p className="mt-4 text-sm text-blue-600">{mensaje}</p>}
      </div>
    </div>
  );
}

// ✅ Subcomponentes corregidos

const FormInput = ({
  label,
  name,
  value,
  onChange,
  disabled = false,
  type = "text",
}: {
  label: string;
  name: string;
  value: string | number;
  onChange?: React.ChangeEventHandler<HTMLInputElement>;
  disabled?: boolean;
  type?: string;
}) => (
  <div>
    <label htmlFor={name} className="block font-medium mb-1">
      {label}
    </label>
    <input
      type={type}
      name={name}
      value={value}
      onChange={onChange}
      disabled={disabled}
      className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400 disabled:bg-gray-100"
    />
  </div>
);

const SelectInput = ({
  label,
  name,
  value,
  onChange,
  options,
}: {
  label: string;
  name: string;
  value: string;
  onChange: React.ChangeEventHandler<HTMLSelectElement>;
  options: { value: string; label: string }[];
}) => (
  <div>
    <label htmlFor={name} className="block font-medium mb-1">
      {label}
    </label>
    <select
      name={name}
      value={value}
      onChange={onChange}
      className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400"
    >
      {options.map((opt) => (
        <option key={opt.value} value={opt.value}>
          {opt.label}
        </option>
      ))}
    </select>
  </div>
);



const CheckboxGroup = ({
  label,
  name,
  options,
  selected,
  onChange,
}: {
  label: string;
  name: string;
  options: string[];
  selected: string[];
  onChange: (updated: string[]) => void;
}) => {
  const toggleValue = (value: string) => {
    if (selected.includes(value)) {
      onChange(selected.filter((item) => item !== value));
    } else {
      onChange([...selected, value]);
    }
  };

  return (
    <fieldset className="border rounded p-4">
      <legend className="text-sm font-semibold">{label}</legend>
      <div className="grid grid-cols-2 gap-2 mt-2">
        {options.map((opt) => (
          <label key={opt} className="flex items-center gap-2">
            <input
              type="checkbox"
              name={name}
              checked={selected.includes(opt)}
              onChange={() => toggleValue(opt)}
              className="accent-green-600"
            />
            {opt}
          </label>
        ))}
      </div>
    </fieldset>
  );
};