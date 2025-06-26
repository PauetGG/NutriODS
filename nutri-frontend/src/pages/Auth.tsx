import { useState } from "react";
import RegistroUsuario from "./RegistroUsuario";
import Login from "./Login";
import CompletarPerfil from "./CompletarPerfil";

const Auth = () => {
  const [mostrarRegistro, setMostrarRegistro] = useState(false);
  const [usuarioLogueado, setUsuarioLogueado] = useState(false);

  return (
    <div className="min-h-screen bg-gray-100 flex items-center justify-center">
      <div className="bg-white p-6 rounded-xl shadow-md w-full max-w-md">

        {/* Estado para debug */}
        <div className="text-center mb-4 font-bold">
          Estado usuarioLogueado: {usuarioLogueado ? "true" : "false"}
        </div>

        {usuarioLogueado ? (
          <CompletarPerfil />
        ) : mostrarRegistro ? (
          <RegistroUsuario onRegistroExitoso={() => setMostrarRegistro(false)} />
        ) : (
          <Login
            onLoginExitoso={() => {
              console.log("Login exitoso - cambiando estado");
              setUsuarioLogueado(true);
            }}
          />
        )}

        {!usuarioLogueado && (
          <div className="mt-6 text-center">
            {mostrarRegistro ? (
              <button
                className="text-blue-600 hover:underline"
                onClick={() => setMostrarRegistro(false)}
              >
                ¿Ya tienes cuenta? Inicia sesión
              </button>
            ) : (
              <button
                className="text-blue-600 hover:underline"
                onClick={() => setMostrarRegistro(true)}
              >
                ¿No tienes cuenta? Regístrate
              </button>
            )}
          </div>
        )}

      </div>
    </div>
  );
};

export default Auth;
