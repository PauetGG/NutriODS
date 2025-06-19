-- sql provisional pendent de revisar entre el grup pero veure si cambiem alguna cosa
DROP DATABASE IF EXISTS nutri;
CREATE DATABASE IF NOT EXISTS nutri;
USE nutri;

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

-- aqui esta la tabla de la dieta
CREATE TABLE dieta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    usuario_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    
    calorias_totales INT CHECK (calorias_totales >= 0),
    
    objetivo ENUM('perder_peso', 'mantener', 'ganar_peso') DEFAULT 'mantener',

    fecha_inicio DATE,
    fecha_fin DATE,

    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_dieta FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

----------------------------
-- vale aqui eh puesto la tabla de los alimentos / ingredientes como le queramos llamar ya lo veremos y si cambiamos alguna cosa
CREATE TABLE ingrediente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300),
    calorias INT NOT NULL,                -- kcal por 100g
    proteinas DECIMAL(5,2),
    grasas DECIMAL(5,2),
    carbohidratos DECIMAL(5,2),
    fibra DECIMAL(5,2),
    azucar DECIMAL(5,2),

    tipo ENUM('fruta', 'verdura', 'carne', 'pescado', 'cereal', 'lácteo', 'legumbre', 'fruto seco', 'semilla', 'bebida', 'otro') DEFAULT 'otro',

    sin_gluten BOOLEAN  DEFAULT FALSE,
    sin_lactosa BOOLEAN DEFAULT  FALSE,
    vegano BOOLEAN DEFAULT FALSE,

    imagen_url VARCHAR(255),

    creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE receta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(500),
    instrucciones TEXT NOT NULL,
    tiempo_preparacion INT NOT NULL,           -- en minutos
    dificultad ENUM('fácil', 'media', 'difícil') DEFAULT 'media',
    raciones INT NOT NULL DEFAULT 1,
    imagen_url VARCHAR(255),
    visible BOOLEAN DEFAULT TRUE,
    
    creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE receta_ingrediente (
    receta_id INT,
    ingrediente_id INT,
    cantidad DECIMAL(6,2) NOT NULL,  -- en gramos o unidades
    
    PRIMARY KEY (receta_id, ingrediente_id),
    FOREIGN KEY (receta_id) REFERENCES receta(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id) ON DELETE CASCADE
);

CREATE TABLE seguimiento_dieta (
    id INT AUTO_INCREMENT PRIMARY KEY,

    dieta_id INT NOT NULL,
    receta_id INT NOT NULL,

    dia_semana ENUM('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo') NOT NULL,
    comida ENUM('desayuno', 'almuerzo', 'cena', 'snack') NOT NULL,

    hora TIME,
    porciones DECIMAL(4,2) DEFAULT 1.0,
    consumido BOOLEAN DEFAULT FALSE,
    notas TEXT,
    fecha DATE,

    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (dieta_id) REFERENCES dieta(id) ON DELETE CASCADE,
    FOREIGN KEY (receta_id) REFERENCES receta(id) ON DELETE CASCADE
);
CREATE TABLE tema_foro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    contenido TEXT NOT NULL,
    categoria ENUM('dieta', 'recetas', 'entrenamiento', 'general') DEFAULT 'general',
    num_respuestas INT DEFAULT 0,
    visitas INT DEFAULT 0,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_foro FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);
CREATE TABLE like_foro (
    usuario_id INT NOT NULL,
    tema_foro_id INT NOT NULL,

    PRIMARY KEY (usuario_id, tema_foro_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (tema_foro_id) REFERENCES tema_foro(id) ON DELETE CASCADE
);
CREATE TABLE respuesta_foro (
    id INT AUTO_INCREMENT PRIMARY KEY,

    tema_foro_id INT NOT NULL,
    usuario_id INT NOT NULL,

    contenido TEXT NOT NULL,
    visitas INT DEFAULT 0,

    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_respuesta_tema FOREIGN KEY (tema_foro_id) REFERENCES tema_foro(id) ON DELETE CASCADE,
    CONSTRAINT fk_respuesta_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);
CREATE TABLE like_respuesta_foro (
    usuario_id INT NOT NULL,
    respuesta_id INT NOT NULL,

    PRIMARY KEY (usuario_id, respuesta_id),

    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (respuesta_id) REFERENCES respuesta_foro(id) ON DELETE CASCADE
);
CREATE TABLE articulo (
    id INT AUTO_INCREMENT PRIMARY KEY,

    titulo VARCHAR(150) NOT NULL,
    resumen VARCHAR(300),                           -- breve resumen para mostrar en listas
    contenido TEXT NOT NULL,
    imagen_url VARCHAR(255),

    categoria ENUM('nutricion', 'salud', 'recetas', 'deporte', 'otro') DEFAULT 'nutricion',
    autor VARCHAR(100),
    fecha_publicacion DATE,

    visible BOOLEAN DEFAULT TRUE,
    visitas INT DEFAULT 0,

    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE like_articulo (
    usuario_id INT NOT NULL,
    articulo_id INT NOT NULL,

    PRIMARY KEY (usuario_id, articulo_id),

    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (articulo_id) REFERENCES articulo(id) ON DELETE CASCADE
);
CREATE TABLE comentario_articulo (
    id INT AUTO_INCREMENT PRIMARY KEY,

    articulo_id INT NOT NULL,
    usuario_id INT NOT NULL,

    contenido TEXT NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (articulo_id) REFERENCES articulo(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);
CREATE TABLE favorito_articulo (
    usuario_id INT NOT NULL,
    articulo_id INT NOT NULL,

    PRIMARY KEY (usuario_id, articulo_id),

    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (articulo_id) REFERENCES articulo(id) ON DELETE CASCADE
);

