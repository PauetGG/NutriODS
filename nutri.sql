CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100),
    altura DECIMAL(5,2),             
    peso DECIMAL(5,2),               
    fecha_nacimiento DATE,
    genero ENUM('masculino', 'femenino', 'otro') DEFAULT 'otro',
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

