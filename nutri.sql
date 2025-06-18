-- sql provisional pendent de revisar entre el grup pero veure si cambiem alguna cosa
Create Database nutri
USE nutri
CREATE TABLE usuario (Add commentMore actions
    id INT AUTO_INCREMENT PRIMARY KEY,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100),
    altura DECIMAL(5,2),             
    peso DECIMAL(5,2),                 
    peso DECIMAL(5,2),               
    fecha_nacimiento DATE,
    genero ENUM('masculino', 'femenino', 'otro') DEFAULT 'otro',
    objetivo TEXT,
    alergias TEXT,
    enfermedades TEXT,
    preferencias_comida TEXT,
    objetivo VARCHAR(255),                     -- antes TEXT
    alergias VARCHAR(255),                     -- antes TEXT
    enfermedades VARCHAR(255),                 -- antes TEXT
    preferencias_comida VARCHAR(255),          -- antes TEXT
    actividad_fisica ENUM('sedentario', 'ligero', 'moderado', 'intenso', 'muy intenso') DEFAULT 'moderado',
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
Show tables
describe usuario;
-- aqui esta la tabla de la dieta
CREATE TABLE dieta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,                     -- Ej: "Dieta para ganar masa"
    descripcion TEXT,                                 -- Opcional, resumen
    calorias_totales INT,                             -- Ej: 2200 kcal
    objetivo ENUM('perder_peso', 'mantener', 'ganar_peso') DEFAULT 'mantener',
    fecha_inicio DATE,
    fecha_fin DATE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_dieta FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);
----------------------------
-- vale aqui eh puesto la tabla de los alimentos / ingredientes como le queramos llamar ya lo veremos y si cambiamos alguna cosa
CREATE TABLE alimento_ingrediente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    calorias INT NOT NULL,               -- kcal por 100g
    proteinas DECIMAL(5,2),             -- gramos por 100g
    grasas DECIMAL(5,2),
    carbohidratos DECIMAL(5,2),
    fibra DECIMAL(5,2),
    azucar DECIMAL(5,2),
    tipo ENUM('fruta', 'verdura', 'carne', 'pescado', 'cereal', 'lácteo', 'legumbre', 'otro') DEFAULT 'otro',
    creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


