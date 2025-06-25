-- sql provisional pendent de revisar entre el grup pero veure si cambiem alguna cosa
DROP DATABASE IF EXISTS nutri;
CREATE DATABASE IF NOT EXISTS nutri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
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
    objetivo VARCHAR(255),
    alergias VARCHAR(255),
    enfermedades VARCHAR(255),
    preferencias_comida VARCHAR(255),
    actividad_fisica ENUM('sedentario', 'ligero', 'moderado', 'intenso', 'muy intenso') DEFAULT 'moderado',
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE dieta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    numero_comidas_dia INT CHECK (numero_comidas_dia >= 3 AND numero_comidas_dia <= 5),
    proteinas_objetivo DOUBLE,
    grasas_objetivo DOUBLE,
    carbohidratos_objetivo DOUBLE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_dieta FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE comida_modelo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_comida ENUM('desayuno', 'almuerzo', 'comida', 'merienda', 'cena') NOT NULL,
    calorias_totales INT NOT NULL,
    apta_diabetes BOOLEAN DEFAULT TRUE,
    apta_hipertension BOOLEAN DEFAULT TRUE,
    apta_hipercolesterolemia BOOLEAN DEFAULT TRUE,
    apta_celiacos BOOLEAN DEFAULT TRUE,
    apta_renal BOOLEAN DEFAULT TRUE,
    apta_anemia BOOLEAN DEFAULT TRUE,
    apta_obesidad BOOLEAN DEFAULT TRUE,
    apta_hipotiroidismo BOOLEAN DEFAULT TRUE,
    apta_colon_irritable BOOLEAN DEFAULT TRUE,
    sin_lactosa BOOLEAN DEFAULT FALSE,
    sin_frutos_secos BOOLEAN DEFAULT FALSE,
    sin_marisco BOOLEAN DEFAULT FALSE,
    sin_pescado_azul BOOLEAN DEFAULT FALSE,
    sin_huevo BOOLEAN DEFAULT FALSE,
    sin_soja BOOLEAN DEFAULT FALSE,
    sin_legumbres BOOLEAN DEFAULT FALSE,
    sin_sesamo BOOLEAN DEFAULT FALSE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ingrediente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300),
    calorias INT NOT NULL,
    proteinas DECIMAL(5,2),
    grasas DECIMAL(5,2),
    carbohidratos DECIMAL(5,2),
    fibra DECIMAL(5,2),
    azucar DECIMAL(5,2),
    tipo ENUM('fruta', 'verdura', 'carne', 'pescado', 'cereal', 'lácteo', 'legumbre', 'fruto_seco', 'semilla', 'bebida', 'huevo', 'otro') DEFAULT 'otro',
    creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE comida_ingrediente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comida_modelo_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    cantidad DECIMAL(6,2) NOT NULL, 
    unidad ENUM('g', 'ml', 'unidad') DEFAULT 'g',
    CONSTRAINT fk_comida_modelo FOREIGN KEY (comida_modelo_id) REFERENCES comida_modelo(id) ON DELETE CASCADE,
    CONSTRAINT fk_ingrediente FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id) ON DELETE CASCADE
);

CREATE TABLE comida_diaria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dieta_id INT NOT NULL,
    dia_semana ENUM('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo') NOT NULL,
    tipo_comida ENUM('desayuno', 'almuerzo', 'comida', 'merienda', 'cena') NOT NULL,
    comida_modelo_id INT NOT NULL,
    FOREIGN KEY (dieta_id) REFERENCES dieta(id) ON DELETE CASCADE,
    FOREIGN KEY (comida_modelo_id) REFERENCES comida_modelo(id) ON DELETE CASCADE
);
CREATE TABLE receta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(500),
    instrucciones TEXT NOT NULL,
    tiempo_preparacion INT NOT NULL,
    dificultad ENUM('fácil', 'media', 'difícil') DEFAULT 'media',
    raciones INT NOT NULL DEFAULT 1,
    imagen_url VARCHAR(255),
    visible BOOLEAN DEFAULT TRUE,
    creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE receta_ingrediente (
    receta_id INT,
    ingrediente_id INT,
    cantidad DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (receta_id, ingrediente_id),
    FOREIGN KEY (receta_id) REFERENCES receta(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE seguimiento_dieta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dieta_id INT NOT NULL,
    receta_id INT NOT NULL,
    dia_semana ENUM('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo') NOT NULL,
    comida ENUM('desayuno', 'almuerzo', 'comida', 'merienda', 'cena') NOT NULL,
    hora TIME,
    porciones DECIMAL(4,2) DEFAULT 1.0,
    consumido BOOLEAN DEFAULT FALSE,
    notas TEXT,
    fecha DATE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dieta_id) REFERENCES dieta(id) ON DELETE CASCADE,
    FOREIGN KEY (receta_id) REFERENCES receta(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE like_foro (
    usuario_id INT NOT NULL,
    tema_foro_id INT NOT NULL,
    PRIMARY KEY (usuario_id, tema_foro_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (tema_foro_id) REFERENCES tema_foro(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE like_respuesta_foro (
    usuario_id INT NOT NULL,
    respuesta_id INT NOT NULL,
    PRIMARY KEY (usuario_id, respuesta_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (respuesta_id) REFERENCES respuesta_foro(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE articulo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    resumen VARCHAR(300),
    contenido TEXT NOT NULL,
    imagen_url VARCHAR(255),
    categoria ENUM('nutricion', 'salud', 'recetas', 'deporte', 'otro') DEFAULT 'nutricion',
    autor VARCHAR(100),
    fecha_publicacion DATE,
    visible BOOLEAN DEFAULT TRUE,
    visitas INT DEFAULT 0,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE like_articulo (
    usuario_id INT NOT NULL,
    articulo_id INT NOT NULL,
    PRIMARY KEY (usuario_id, articulo_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (articulo_id) REFERENCES articulo(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE comentario_articulo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    articulo_id INT NOT NULL,
    usuario_id INT NOT NULL,
    contenido TEXT NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (articulo_id) REFERENCES articulo(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE favorito_articulo (
    usuario_id INT NOT NULL,
    articulo_id INT NOT NULL,
    PRIMARY KEY (usuario_id, articulo_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (articulo_id) REFERENCES articulo(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE glosario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    termino VARCHAR(100) NOT NULL UNIQUE,
    definicion TEXT NOT NULL,
    fuente VARCHAR(255),
    categoria ENUM('concepto','macronutriente','micronutriente','vitamina','mineral','suplemento','dieta','deporte','otro') DEFAULT 'otro',
    imagen_url VARCHAR(255),
    visible BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE multimedia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    url VARCHAR(255) NOT NULL,
    tipo ENUM('video', 'infografia', 'pdf', 'web', 'otro') DEFAULT 'video',
    categoria ENUM('nutricion', 'salud', 'ejercicio', 'mentalidad', 'otro') DEFAULT 'nutricion',
    visible BOOLEAN DEFAULT TRUE,
    fecha_publicacion DATE,
    creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO ingrediente (nombre, descripcion, calorias, proteinas, grasas, carbohidratos, fibra, azucar, tipo) VALUES
('Espinaca', 'Verdura de hoja verde rica en hierro y fibra.', 23, 2.9, 0.4, 1.1, 2.2, 0.4, 'verdura'),
('Acelga', 'Hortaliza de hoja ancha, muy baja en calorías.', 20, 1.8, 0.2, 1.8, 1.6, 0.4, 'verdura'),
('Zanahoria', 'Raíz comestible rica en betacarotenos.', 41, 0.9, 0.2, 9.6, 2.8, 4.7, 'verdura'),
('Calabacín', 'Verdura versátil y ligera, rica en agua.', 17, 1.2, 0.3, 3.1, 1.0, 1.7, 'verdura'),
('Berenjena', 'Verdura de piel morada y textura esponjosa.', 25, 1.0, 0.2, 6.0, 3.0, 3.5, 'verdura'),
('Pimiento rojo', 'Hortaliza dulce y rica en vitamina C.', 31, 1.0, 0.3, 6.0, 2.1, 4.2, 'verdura'),
('Tomate', 'Fruto usado como verdura, rico en licopeno.', 18, 0.9, 0.2, 3.9, 1.2, 2.6, 'verdura'),
('Brócoli', 'Verdura crucífera rica en antioxidantes.', 34, 2.8, 0.4, 6.6, 2.6, 1.7, 'verdura'),
('Coliflor', 'Flor comestible, rica en vitamina C.', 25, 2.0, 0.3, 5.0, 2.0, 1.9, 'verdura'),
('Cebolla', 'Bulbo aromático usado como base de cocción.', 40, 1.1, 0.1, 9.3, 1.7, 4.2, 'verdura'),
('Lechuga romana', 'Hortaliza de hoja verde ideal para ensaladas.', 15, 1.4, 0.2, 2.9, 1.3, 0.8, 'verdura'),
('Lechuga iceberg', 'Lechuga crujiente con alto contenido en agua.', 14, 0.9, 0.1, 3.0, 1.2, 1.4, 'verdura'),
('Apio', 'Verdura de tallo larga y fibrosa, muy diurética.', 16, 0.7, 0.2, 3.5, 1.6, 1.8, 'verdura'),
('Puerro', 'Verdura de sabor suave, parecida a la cebolla.', 29, 1.5, 0.3, 7.6, 1.8, 3.9, 'verdura'),
('Nabo', 'Raíz blanca rica en agua y muy baja en calorías.', 28, 0.9, 0.1, 6.4, 1.8, 3.8, 'verdura'),
('Rábano', 'Raíz pequeña y picante común en ensaladas.', 16, 0.7, 0.1, 3.4, 1.6, 1.9, 'verdura'),
('Remolacha', 'Raíz roja rica en antioxidantes y azúcares.', 43, 1.6, 0.2, 9.6, 2.8, 6.8, 'verdura'),
('Col lombarda', 'Variedad de col morada, rica en antocianinas.', 31, 1.4, 0.2, 7.4, 2.1, 3.8, 'verdura'),
('Col rizada (kale)', 'Verdura de hoja verde muy nutritiva.', 49, 4.3, 0.9, 8.8, 3.6, 2.3, 'verdura'),
('Repollo', 'Verdura de hoja verde de sabor suave.', 25, 1.3, 0.1, 5.8, 2.5, 3.2, 'verdura'),
('Hinojo', 'Verdura aromática con sabor a anís.', 31, 1.2, 0.2, 7.3, 3.1, 3.9, 'verdura'),
('Endibia', 'Verdura de sabor ligeramente amargo.', 17, 0.9, 0.1, 3.4, 1.6, 0.8, 'verdura'),
('Alcachofa', 'Flor comestible muy rica en fibra y antioxidantes.', 47, 3.3, 0.2, 10.5, 5.4, 0.5, 'verdura'),
('Judía verde', 'Vaina comestible rica en fibra y vitaminas.', 31, 1.8, 0.2, 7.1, 3.1, 1.4, 'verdura'),
('Pepino', 'Verdura muy refrescante y baja en calorías.', 12, 0.6, 0.1, 2.2, 0.5, 1.4, 'verdura'),
('Escarola', 'Verdura de hoja rizada y sabor amargo, ideal para ensaladas.', 17, 1.3, 0.2, 2.0, 3.1, 0.8, 'verdura'),
('Borraja', 'Verdura tradicional aragonesa, con tallos comestibles.', 21, 1.8, 0.3, 3.1, 1.5, 1.0, 'verdura'),
('Cardo', 'Verdura de invierno similar a la alcachofa, rica en fibra.', 17, 0.9, 0.1, 3.0, 1.5, 0.8, 'verdura'),
('Grelos', 'Brotes tiernos de nabo muy usados en Galicia.', 22, 2.2, 0.3, 1.9, 2.6, 0.6, 'verdura'),
('Berza', 'Col rizada de textura gruesa, típica de cocidos.', 32, 2.5, 0.3, 5.4, 3.5, 1.4, 'verdura'),
('Coles de Bruselas', 'Pequeñas coles con sabor intenso.', 43, 3.4, 0.3, 8.9, 3.8, 2.2, 'verdura'),
('Champiñón', 'Hongo comestible muy bajo en calorías.', 22, 3.1, 0.3, 3.3, 1.0, 1.0, 'verdura'),
('Seta ostra', 'Hongo comestible de textura carnosa.', 33, 3.3, 0.4, 6.1, 2.3, 1.0, 'verdura'),
('Raíz de apio (apionabo)', 'Raíz gruesa y aromática del apio.', 42, 1.5, 0.3, 9.2, 1.8, 1.6, 'verdura'),
('Habas verdes', 'Legumbre tierna usada como verdura.', 55, 4.0, 0.5, 9.0, 4.0, 1.5, 'verdura'),
('Manzana', 'Fruta crujiente y refrescante, rica en fibra.', 52, 0.3, 0.2, 13.8, 2.4, 10.4, 'fruta'),
('Plátano', 'Fruta tropical rica en potasio y energía rápida.', 89, 1.1, 0.3, 22.8, 2.6, 12.2, 'fruta'),
('Naranja', 'Fruta cítrica rica en vitamina C.', 47, 0.9, 0.1, 11.8, 2.4, 9.3, 'fruta'),
('Pera', 'Fruta jugosa con alto contenido de agua y fibra.', 57, 0.4, 0.1, 15.2, 3.1, 9.8, 'fruta'),
('Melocotón', 'Fruta dulce de verano, rica en antioxidantes.', 39, 0.9, 0.3, 9.5, 1.5, 8.4, 'fruta'),
('Albaricoque', 'Fruta pequeña con alto contenido en betacaroteno.', 48, 1.4, 0.4, 11.1, 2.0, 9.2, 'fruta'),
('Uva', 'Fruta dulce en racimos, rica en azúcares naturales.', 69, 0.7, 0.2, 18.1, 0.9, 15.5, 'fruta'),
('Fresa', 'Fruta roja y aromática, baja en calorías.', 32, 0.7, 0.3, 7.7, 2.0, 4.9, 'fruta'),
('Kiwi', 'Fruta ácida y verde, muy rica en vitamina C.', 61, 1.1, 0.5, 14.7, 3.0, 9.0, 'fruta'),
('Cereza', 'Fruta pequeña y dulce, rica en antioxidantes.', 50, 1.0, 0.3, 12.2, 1.6, 8.0, 'fruta'),
('Piña', 'Fruta tropical jugosa, rica en vitamina C y bromelina.', 50, 0.5, 0.1, 13.1, 1.4, 9.9, 'fruta'),
('Mango', 'Fruta carnosa, dulce y rica en betacarotenos.', 60, 0.8, 0.4, 15.0, 1.6, 13.7, 'fruta'),
('Papaya', 'Fruta tropical suave con enzimas digestivas como la papaína.', 43, 0.5, 0.3, 10.8, 1.7, 7.8, 'fruta'),
('Maracuyá', 'Fruta exótica con semillas comestibles y alto contenido en fibra.', 97, 2.2, 0.4, 23.4, 10.4, 11.2, 'fruta'),
('Guayaba', 'Fruta tropical muy rica en vitamina C y antioxidantes.', 68, 2.6, 1.0, 14.3, 5.4, 8.9, 'fruta'),
('Chirimoya', 'Fruta tropical dulce, de pulpa blanca y cremosa.', 75, 1.6, 0.7, 18.0, 3.0, 14.7, 'fruta'),
('Lichi', 'Fruta pequeña, dulce y aromática, con alto contenido en vitamina C.', 66, 0.8, 0.4, 16.5, 1.3, 15.2, 'fruta'),
('Pitahaya (fruta del dragón)', 'Fruta exótica con alto contenido de agua y fibra.', 50, 1.1, 0.4, 11.0, 3.0, 8.0, 'fruta'),
('Tamarindo', 'Fruta tropical agridulce rica en fibra y minerales.', 239, 2.8, 0.6, 62.5, 5.1, 38.8, 'fruta'),
('Carambola (fruta estrella)', 'Fruta exótica en forma de estrella, refrescante y baja en calorías.', 31, 1.0, 0.3, 6.7, 2.8, 3.7, 'fruta'),
('Frambuesa', 'Fruta roja pequeña, ácida y rica en fibra y antioxidantes.', 52, 1.2, 0.7, 11.9, 6.5, 4.4, 'fruta'),
('Arándano', 'Fruta pequeña azulada, muy rica en antocianinas.', 57, 0.7, 0.3, 14.5, 2.4, 9.7, 'fruta'),
('Mora', 'Fruta oscura y jugosa, con alto contenido en vitamina C.', 43, 1.4, 0.5, 9.6, 5.3, 4.9, 'fruta'),
('Grosella roja', 'Fruta ácida y brillante, usada en mermeladas y zumos.', 56, 1.4, 0.2, 13.8, 4.3, 7.4, 'fruta'),
('Grosella negra', 'Fruta rica en vitamina C y antocianinas.', 63, 1.4, 0.4, 15.4, 5.0, 7.4, 'fruta'),
('Endrina', 'Fruta silvestre de sabor muy ácido, base del pacharán.', 54, 0.9, 0.5, 13.5, 2.5, 9.5, 'fruta'),
('Escaramujo', 'Fruto del rosal silvestre, muy rico en vitamina C.', 162, 1.6, 0.3, 38.2, 24.1, 2.6, 'fruta'),
('Dátil seco', 'Fruta muy energética, rica en azúcares naturales y potasio.', 282, 2.5, 0.4, 75.0, 8.0, 63.4, 'fruta'),
('Higo seco', 'Fruta deshidratada con alto contenido en fibra y calcio.', 249, 3.3, 0.9, 63.9, 9.8, 47.9, 'fruta'),
('Uva pasa', 'Uva deshidratada, dulce y rica en antioxidantes.', 299, 3.1, 0.5, 79.2, 3.7, 59.2, 'fruta'),
('Ciruela pasa', 'Ciruela desecada rica en fibra soluble y potasio.', 240, 2.2, 0.4, 63.9, 7.1, 38.1, 'fruta'),
('Albaricoque seco', 'Fruta deshidratada de sabor intenso, rica en hierro y fibra.', 241, 3.4, 0.5, 62.6, 7.3, 53.4, 'fruta'),
('Granada', 'Fruta de otoño rica en antioxidantes y vitamina C.', 83, 1.7, 1.2, 18.7, 4.0, 13.7, 'fruta'),
('Caqui', 'Fruta dulce de otoño, muy energética y rica en vitamina A.', 70, 0.6, 0.2, 18.6, 3.6, 15.0, 'fruta'),
('Melón', 'Fruta refrescante de verano, con alto contenido en agua.', 34, 0.8, 0.2, 8.2, 0.9, 7.8, 'fruta'),
('Sandía', 'Fruta de verano muy hidratante, ideal para días calurosos.', 30, 0.6, 0.2, 7.6, 0.4, 6.2, 'fruta'),
('Higo fresco', 'Fruta de verano-otoño, dulce y muy digestiva.', 74, 0.8, 0.3, 19.2, 2.9, 16.3, 'fruta'),
('Níspero', 'Fruta de primavera con sabor entre ácido y dulce.', 47, 0.4, 0.2, 12.1, 1.7, 6.5, 'fruta'),
('Mandarina', 'Cítrico de invierno fácil de pelar y rico en vitamina C.', 53, 0.8, 0.3, 13.3, 1.8, 10.5, 'fruta'),
('Castaña', 'Fruto de otoño-invierno, alto en hidratos y muy saciante.', 196, 2.0, 1.3, 45.5, 8.1, 10.6, 'fruta'),
('Leche entera', 'Líquido nutritivo proveniente de la vaca, fuente de calcio.', 61, 3.2, 3.6, 4.8, 0.0, 4.8, 'lácteo'),
('Leche semidesnatada', 'Leche con menos grasa que la entera pero mantiene el calcio.', 47, 3.2, 1.6, 4.9, 0.0, 4.9, 'lácteo'),
('Leche desnatada', 'Leche sin grasa, ideal para dietas hipocalóricas.', 35, 3.4, 0.1, 5.0, 0.0, 5.0, 'lácteo'),
('Yogur natural', 'Producto fermentado a partir de la leche, fuente de probióticos.', 61, 3.5, 3.3, 4.7, 0.0, 4.7, 'lácteo'),
('Yogur griego 0%', 'Yogur espeso sin grasa, alto en proteínas.', 59, 10.0, 0.4, 3.6, 0.0, 3.6, 'lácteo'),
('Queso fresco', 'Queso blanco, tierno y suave, bajo en grasa.', 98, 11.0, 4.0, 3.0, 0.0, 2.8, 'lácteo'),
('Queso curado', 'Queso madurado de sabor intenso y alto valor calórico.', 402, 25.0, 33.0, 1.3, 0.0, 0.5, 'lácteo'),
('Queso de cabra', 'Queso elaborado con leche de cabra, de sabor fuerte.', 364, 22.0, 30.0, 2.0, 0.0, 0.5, 'lácteo'),
('Kéfir', 'Bebida fermentada con probióticos naturales.', 52, 3.6, 3.0, 4.0, 0.0, 3.8, 'lácteo'),
('Mantequilla', 'Grasa láctea sólida obtenida de la nata.', 717, 0.9, 81.1, 0.1, 0.0, 0.1, 'lácteo'),
('Queso crema', 'Queso untable suave, ideal para tostadas o repostería.', 342, 6.2, 34.0, 3.3, 0.0, 2.5, 'lácteo'),
('Leche condensada', 'Leche concentrada y azucarada, muy energética.', 321, 7.9, 8.7, 54.4, 0.0, 54.0, 'lácteo'),
('Nata para cocinar', 'Grasa láctea líquida, usada en salsas y cremas.', 195, 2.1, 20.0, 3.0, 0.0, 2.9, 'lácteo'),
('Nata para montar', 'Nata con más grasa, ideal para repostería.', 345, 2.1, 36.0, 2.8, 0.0, 2.8, 'lácteo'),
('Leche sin lactosa', 'Leche tratada para eliminar la lactosa, fácil de digerir.', 45, 3.2, 1.5, 4.9, 0.0, 2.0, 'lácteo'),
('Yogur sin lactosa', 'Yogur fermentado apto para intolerantes a la lactosa.', 50, 4.0, 2.0, 4.8, 0.0, 4.5, 'lácteo'),
('Queso rallado', 'Mezcla de quesos curados rallados para fundir.', 371, 25.0, 30.0, 1.3, 0.0, 0.9, 'lácteo'),
('Requesón', 'Producto lácteo suave, con alto contenido en agua.', 98, 11.0, 4.3, 3.0, 0.0, 2.8, 'lácteo'),
('Leche evaporada', 'Leche concentrada sin azúcar, para cocinar o café.', 135, 6.8, 7.5, 10.0, 0.0, 10.0, 'lácteo'),
('Batido de chocolate', 'Bebida láctea azucarada con sabor a cacao.', 72, 3.2, 1.2, 12.0, 0.0, 11.5, 'lácteo'),
('Lenteja cocida', 'Legumbre pequeña rica en hierro y proteínas vegetales.', 116, 9.0, 0.4, 20.1, 7.9, 1.8, 'legumbre'),
('Garbanzos cocidos', 'Legumbre redonda y cremosa, base del hummus.', 164, 8.9, 2.6, 27.4, 7.6, 4.8, 'legumbre'),
('Judía blanca cocida', 'Legumbre blanca suave, usada en cocidos y potajes.', 127, 8.7, 0.5, 23.7, 6.4, 0.6, 'legumbre'),
('Judía roja cocida', 'Legumbre rojiza rica en antioxidantes y fibra.', 127, 8.4, 0.5, 22.8, 6.4, 0.3, 'legumbre'),
('Soja cocida', 'Legumbre amarilla muy rica en proteína vegetal.', 172, 16.6, 9.0, 9.9, 6.0, 3.0, 'legumbre'),
('Alubia pinta cocida', 'Variedad de judía moteada, muy nutritiva.', 135, 9.0, 0.5, 24.0, 6.7, 0.5, 'legumbre'),
('Habas secas cocidas', 'Legumbre grande y algo astringente, rica en hierro.', 110, 8.0, 0.5, 19.0, 5.4, 1.0, 'legumbre'),
('Guistante cocido', 'Legumbre verde dulce, rica en proteínas y fibra.', 84, 5.4, 0.4, 14.5, 5.1, 5.0, 'legumbre'),
('Lenteja roja cocida', 'Lenteja sin piel de cocción rápida, muy digestiva.', 120, 9.0, 0.4, 20.0, 5.0, 1.5, 'legumbre'),
('Edamame', 'Soja verde inmadura, snack muy proteico.', 121, 11.9, 5.2, 8.9, 5.2, 2.2, 'legumbre'),
('Lenteja beluga cocida', 'Lenteja pequeña y negra, con textura firme y sabor suave.', 116, 9.2, 0.4, 20.1, 8.0, 1.7, 'legumbre'),
('Lenteja verde cocida', 'Lenteja de tamaño mediano y color verdoso, muy usada en ensaladas.', 117, 9.0, 0.4, 20.2, 7.5, 1.6, 'legumbre'),
('Azuki cocido', 'Judía roja japonesa, usada en platos dulces y salados.', 128, 7.5, 0.1, 25.0, 7.3, 0.3, 'legumbre'),
('Judión cocido', 'Legumbre grande y blanca típica de La Granja.', 130, 8.5, 0.5, 22.0, 6.5, 0.4, 'legumbre'),
('Soja texturizada', 'Proteína vegetal obtenida de la soja, usada como sustituto de carne.', 326, 49.0, 1.0, 18.0, 13.0, 7.0, 'legumbre'),
('Lupino cocido', 'Legumbre amarilla con alto contenido proteico, consumida encurtida.', 119, 15.6, 2.9, 12.4, 3.7, 1.1, 'legumbre'),
('Mungo cocido', 'Judía verde pequeña, muy usada en cocina asiática.', 105, 7.0, 0.4, 19.0, 7.0, 1.5, 'legumbre'),
('Guisante seco cocido', 'Guisante partido, más proteico que el fresco.', 118, 8.3, 0.4, 21.1, 6.5, 2.0, 'legumbre'),
('Soja negra cocida', 'Variedad oscura de soja, rica en antioxidantes.', 170, 15.5, 9.0, 10.0, 6.0, 2.0, 'legumbre'),
('Cacahuete cocido', 'Técnicamente una legumbre, muy calórico y proteico.', 318, 25.8, 24.4, 7.2, 8.0, 2.0, 'legumbre'),
('Merluza', 'Pescado blanco suave, bajo en grasa y muy digerible.', 72, 12.0, 2.0, 0.0, 0.0, 0.0, 'pescado'),
('Salmón', 'Pescado azul graso, fuente de omega-3 y proteínas.', 208, 20.4, 13.0, 0.0, 0.0, 0.0, 'pescado'),
('Atún', 'Pescado azul de carne roja y muy proteico.', 132, 23.0, 4.0, 0.0, 0.0, 0.0, 'pescado'),
('Bacalao fresco', 'Pescado blanco salado tradicional, bajo en grasa.', 82, 17.8, 0.7, 0.0, 0.0, 0.0, 'pescado'),
('Sardina', 'Pescado azul pequeño y graso, muy rico en calcio.', 208, 25.0, 11.0, 0.0, 0.0, 0.0, 'pescado'),
('Lenguado', 'Pescado blanco plano de sabor fino y textura delicada.', 91, 16.5, 2.0, 0.0, 0.0, 0.0, 'pescado'),
('Caballa', 'Pescado azul con alto contenido en ácidos grasos omega-3.', 205, 19.0, 14.0, 0.0, 0.0, 0.0, 'pescado'),
('Pez espada', 'Pescado grande de carne firme, ideal para la plancha.', 144, 20.5, 6.0, 0.0, 0.0, 0.0, 'pescado'),
('Trucha', 'Pescado de río semigraso, fuente de proteína y fósforo.', 119, 20.5, 4.0, 0.0, 0.0, 0.0, 'pescado'),
('Rape', 'Pescado blanco gelatinoso, muy usado en caldos.', 68, 14.5, 0.3, 0.0, 0.0, 0.0, 'pescado'),
('Arroz integral cocido', 'Cereal completo con mayor fibra y nutrientes.', 111, 2.6, 0.9, 23.0, 1.8, 0.4, 'cereal'),
('Avena en copos', 'Cereal integral rico en fibra soluble y energía sostenida.', 389, 13.0, 6.9, 66.3, 10.6, 1.0, 'cereal'),
('Quinoa cocida', 'Pseudocereal rico en proteína y aminoácidos esenciales.', 120, 4.1, 1.9, 21.3, 2.8, 0.9, 'cereal'),
('Pan blanco', 'Producto de harina refinada, bajo en fibra.', 265, 8.0, 3.2, 49.0, 2.5, 5.0, 'cereal'),
('Pan integral', 'Pan elaborado con harina de trigo integral, más saciante.', 247, 8.8, 3.5, 41.0, 6.0, 4.0, 'cereal'),
('Maíz cocido', 'Grano dulce muy consumido como guarnición o en ensaladas.', 96, 3.4, 1.5, 18.7, 2.7, 6.3, 'cereal'),
('Cuscús cocido', 'Sémola de trigo muy usada en platos del norte de África.', 112, 3.8, 0.2, 23.2, 1.4, 0.1, 'cereal'),
('Bulgur cocido', 'Trigo precocido con textura similar al arroz.', 83, 3.1, 0.2, 18.6, 4.5, 0.1, 'cereal'),
('Pasta cocida', 'Alimento hecho de harina de trigo y agua, muy versátil.', 131, 5.0, 1.1, 25.0, 1.8, 0.7, 'cereal'),
('Trigo sarraceno cocido', 'Pseudocereal sin gluten, muy nutritivo y fácil de digerir.', 92, 3.4, 0.6, 19.9, 2.7, 0.3, 'cereal'),
('Amaranto cocido', 'Pseudocereal sin gluten, con alto contenido proteico.', 102, 3.8, 1.6, 19.0, 2.1, 1.7, 'cereal'),
('Mijo cocido', 'Cereal sin gluten de grano pequeño, usado en dietas ligeras.', 119, 3.5, 1.0, 23.7, 1.3, 0.1, 'cereal'),
('Espelta cocida', 'Cereal ancestral con más proteína que el trigo común.', 127, 5.5, 1.0, 24.0, 3.8, 0.5, 'cereal'),
('Harina de trigo', 'Producto base para pan, pasta y repostería.', 364, 10.3, 1.0, 76.2, 2.7, 0.3, 'cereal'),
('Corn flakes', 'Copos de maíz tostados, cereal de desayuno clásico.', 357, 7.5, 0.4, 84.0, 3.0, 7.0, 'cereal'),
('Arroz inflado', 'Arroz tostado e inflado, muy usado en cereales y snacks.', 375, 6.9, 0.7, 87.5, 1.2, 0.3, 'cereal'),
('Copos de trigo integral', 'Cereal de desayuno alto en fibra y sin azúcar añadido.', 340, 11.2, 2.4, 72.0, 11.0, 1.0, 'cereal'),
('Harina de avena', 'Versión molida del grano, muy usada en repostería saludable.', 379, 13.3, 6.7, 67.7, 10.1, 1.1, 'cereal'),
('Fideos de arroz cocidos', 'Pasta sin gluten elaborada con arroz, muy común en cocina asiática.', 108, 2.0, 0.2, 25.0, 0.5, 0.1, 'cereal'),
('Arroz blanco', 'Cereal básico sin gluten, muy digestivo.', 365, 7.1, 0.7, 80.0, 1.3, 0.1, 'cereal'),
('Arroz integral', 'Versión completa del arroz, con más fibra y micronutrientes.', 362, 7.5, 2.7, 76.2, 3.4, 0.8, 'cereal'),
('Maíz', 'Cereal sin gluten, muy versátil y base de muchos productos.', 365, 9.4, 4.7, 74.3, 7.3, 1.1, 'cereal'),
('Copos de maíz', 'Cereal de desayuno sin gluten (versión certificada).', 370, 7.5, 1.0, 83.0, 2.5, 6.5, 'cereal'),
('Quinoa', 'Pseudocereal sin gluten, muy completo nutricionalmente.', 368, 14.1, 6.1, 64.2, 7.0, 1.0, 'cereal'),
('Trigo sarraceno', 'Pseudocereal sin gluten, ideal para panes y crepes.', 343, 13.3, 3.4, 71.5, 10.0, 0.9, 'cereal'),
('Mijo', 'Cereal ancestral sin gluten, usado en papillas o guarniciones.', 378, 11.0, 4.2, 73.0, 8.5, 1.5, 'cereal'),
('Fideos de arroz', 'Pasta sin gluten a base de arroz, muy usada en cocina asiática.', 364, 7.0, 0.9, 80.0, 1.2, 0.3, 'cereal'),
('Harina de arroz', 'Harina sin gluten usada para panes, tortitas y repostería.', 366, 6.0, 1.5, 80.1, 2.4, 0.5, 'cereal'),
('Pan sin gluten', 'Pan elaborado con harinas sin gluten como arroz o maíz.', 249, 5.8, 3.2, 49.0, 5.0, 4.0, 'cereal'),
('Almendra cruda', 'Fruto seco muy nutritivo, rico en calcio y vitamina E.', 579, 21.2, 49.9, 21.6, 12.5, 4.4, 'fruto_seco'),
('Nuez', 'Fruto seco con alto contenido en ácidos grasos omega-3.', 654, 15.2, 65.2, 13.7, 6.7, 2.6, 'fruto_seco'),
('Avellana', 'Fruto seco redondo, muy energético y sabroso.', 628, 14.1, 60.8, 16.7, 9.7, 4.0, 'fruto_seco'),
('Anacardo', 'Fruto seco cremoso y algo dulce, ideal como snack.', 553, 18.2, 43.8, 30.2, 3.3, 5.9, 'fruto_seco'),
('Pistacho', 'Fruto seco verde con gran contenido en proteínas y fibra.', 562, 20.2, 45.4, 27.5, 10.3, 7.7, 'fruto_seco'),
('Macadamia', 'Fruto seco muy graso, de textura crujiente y suave.', 718, 7.9, 75.8, 13.8, 8.6, 4.6, 'fruto_seco'),
('Piñón', 'Semilla comestible del pino, muy valorada en cocina.', 673, 13.7, 68.4, 13.1, 3.7, 3.6, 'fruto_seco'),
('Castaña seca', 'Fruto seco de otoño, con menos grasa y más hidratos.', 369, 6.0, 3.0, 79.0, 8.0, 14.0, 'fruto_seco'),
('Nuez pecana', 'Variedad americana de nuez, más dulce y aceitosa.', 691, 9.2, 72.0, 14.0, 9.6, 4.0, 'fruto_seco'),
('Almendra tostada', 'Versión ligeramente tostada, mantiene la mayoría de nutrientes.', 598, 20.6, 52.0, 21.0, 11.8, 4.2, 'fruto_seco');

INSERT INTO ingrediente (nombre, descripcion, calorias, proteinas, grasas, carbohidratos, fibra, azucar, tipo) VALUES
('Agua mineral', 'Bebida esencial sin calorías ni nutrientes energéticos.', 0, 0.0, 0.0, 0.0, 0.0, 0.0, 'bebida'),
('Zumo de naranja natural', 'Bebida exprimida rica en vitamina C y azúcares naturales.', 45, 0.7, 0.2, 10.0, 0.2, 8.4, 'bebida'),
('Zumo de piña envasado', 'Bebida dulce a base de concentrado de piña.', 55, 0.4, 0.1, 13.0, 0.1, 12.0, 'bebida'),
('Refresco de cola', 'Bebida carbonatada con cafeína y alto contenido en azúcar.', 42, 0.0, 0.0, 10.6, 0.0, 10.6, 'bebida'),
('Refresco de cola zero', 'Versión sin azúcar del refresco clásico.', 1, 0.0, 0.0, 0.1, 0.0, 0.0, 'bebida'),
('Cerveza sin alcohol', 'Bebida fermentada con bajo contenido en alcohol.', 22, 0.3, 0.0, 5.0, 0.0, 1.7, 'bebida'),
('Bebida vegetal de almendra', 'Alternativa vegetal a la leche, baja en calorías.', 17, 0.6, 1.1, 0.3, 0.2, 0.2, 'bebida'),
('Bebida vegetal de soja', 'Alternativa vegetal rica en proteína vegetal.', 33, 3.3, 1.8, 0.6, 0.4, 0.4, 'bebida'),
('Infusión', 'Bebida antioxidante sin calorías si se toma sin azúcar.', 0, 0.0, 0.0, 0.0, 0.0, 0.0, 'bebida'),
('Café solo', 'Infusión estimulante sin calorías si se toma sin azúcar.', 2, 0.3, 0.0, 0.0, 0.0, 0.0, 'bebida'),
('Bebida de soja', 'Alternativa vegetal rica en proteínas, similar nutricionalmente a la leche.', 33, 3.3, 1.8, 0.6, 0.4, 0.4, 'bebida'),
('Bebida de almendra sin azúcar', 'Bebida vegetal ligera y baja en calorías.', 13, 0.5, 1.1, 0.1, 0.3, 0.1, 'bebida'),
('Bebida de avena', 'Bebida vegetal cremosa, fuente de betaglucanos.', 47, 1.0, 1.5, 7.0, 0.8, 4.0, 'bebida'),
('Bebida de arroz', 'Bebida vegetal muy digestiva, rica en hidratos.', 49, 0.1, 1.0, 10.0, 0.2, 5.5, 'bebida'),
('Bebida de coco', 'Bebida vegetal refrescante, con grasas saludables.', 20, 0.2, 1.2, 2.2, 0.1, 1.9, 'bebida'),
('Bebida de avellanas', 'Bebida vegetal con sabor dulce y aromático.', 59, 1.2, 2.6, 8.8, 0.4, 5.8, 'bebida'),
('Bebida de espelta', 'Bebida de cereal con sabor suave, algo más proteica.', 50, 1.4, 1.0, 8.6, 0.8, 3.8, 'bebida'),
('Bebida de quinoa', 'Bebida vegetal exótica con aminoácidos esenciales.', 39, 1.2, 1.3, 6.0, 0.6, 3.5, 'bebida'),
('Bebida de chufa (horchata sin azúcar)', 'Bebida vegetal típica de Valencia, refrescante y digestiva.', 40, 0.6, 2.4, 4.8, 0.5, 2.0, 'bebida'),
('Bebida de mijo', 'Bebida vegetal menos común, sin gluten y fácil de digerir.', 36, 0.8, 1.1, 6.5, 0.6, 3.0, 'bebida'),
('Bebida isotónica con azúcar', 'Bebida deportiva con sales minerales y azúcares de absorción rápida.', 26, 0.0, 0.0, 6.4, 0.0, 6.0, 'bebida'),
('Bebida isotónica sin azúcar', 'Versión sin azúcares, aporta electrolitos sin calorías.', 4, 0.0, 0.0, 0.9, 0.0, 0.1, 'bebida'),
('Agua con electrolitos', 'Agua mineral enriquecida con sodio, potasio y magnesio.', 0, 0.0, 0.0, 0.0, 0.0, 0.0, 'bebida'),
('Bebida de recuperación post-entreno', 'Bebida isotónica con carbohidratos y algo de proteína.', 55, 2.0, 0.5, 10.5, 0.0, 8.0, 'bebida'),
('Bebida energética ligera', 'Versión isotónica con cafeína y vitaminas B.', 30, 0.0, 0.0, 7.3, 0.0, 7.0, 'bebida'),
('Refresco de naranja', 'Bebida carbonatada con sabor cítrico y azúcares añadidos.', 39, 0.0, 0.0, 9.7, 0.0, 9.7, 'bebida'),
('Refresco de limón', 'Bebida gasificada con aroma a limón y azúcar.', 38, 0.0, 0.0, 9.5, 0.0, 9.5, 'bebida'),
('Tónica', 'Bebida carbonatada con sabor amargo por la quinina.', 34, 0.0, 0.0, 8.5, 0.0, 8.5, 'bebida'),
('Gaseosa', 'Refresco sin saborizantes, solo agua carbonatada y azúcar.', 27, 0.0, 0.0, 6.6, 0.0, 6.6, 'bebida'),
('Bitter kas', 'Refresco amargo con extractos vegetales, típico en aperitivos.', 33, 0.0, 0.0, 8.1, 0.0, 8.1, 'bebida'),
('Refresco de manzana', 'Bebida carbonatada con aroma y sabor a manzana.', 40, 0.0, 0.0, 10.0, 0.0, 9.8, 'bebida'),
('Refresco de té con limón', 'Infusión fría azucarada y gasificada.', 28, 0.0, 0.0, 7.0, 0.0, 6.8, 'bebida'),
('Ternera magra', 'Corte limpio de ternera, alto en proteína y bajo en grasa.', 133, 21.3, 4.7, 0.0, 0.0, 0.0, 'carne'),
('Ternera picada', 'Carne de ternera molida, usada en guisos y hamburguesas.', 215, 18.0, 15.0, 0.0, 0.0, 0.0, 'carne'),
('Cerdo magro', 'Corte de cerdo bajo en grasa, como el lomo.', 143, 21.0, 5.5, 0.0, 0.0, 0.0, 'carne'),
('Lomo de cerdo', 'Corte limpio y magro, típico en filetes o asados.', 165, 20.0, 9.0, 0.0, 0.0, 0.0, 'carne'),
('Costilla de cerdo', 'Corte graso y sabroso, muy usado en barbacoas.', 286, 17.5, 25.0, 0.0, 0.0, 0.0, 'carne'),
('Cordero pierna', 'Carne roja sabrosa y jugosa, típica de celebraciones.', 206, 20.0, 14.0, 0.0, 0.0, 0.0, 'carne'),
('Chuleta de cerdo', 'Corte mixto con hueso, muy consumido a la plancha.', 250, 18.5, 20.0, 0.0, 0.0, 0.0, 'carne'),
('Chorizo curado', 'Embutido típico con pimentón, alto en grasa y sabor.', 455, 24.0, 38.0, 1.0, 0.0, 1.0, 'carne'),
('Jamón serrano', 'Pierna curada de cerdo, muy rica en proteína.', 241, 30.5, 14.0, 0.5, 0.0, 0.5, 'carne'),
('Morcilla', 'Embutido de sangre, arroz y grasa, muy calórico.', 379, 15.0, 35.0, 3.0, 0.0, 0.5, 'carne'),
('Jamón cocido (York)', 'Carne cocida magra, baja en grasa y salada.', 126, 18.0, 5.0, 1.0, 0.0, 1.0, 'carne'),
('Pechuga de pavo cocida', 'Fiambre magro, alto en proteína y bajo en grasa.', 102, 20.0, 2.0, 1.0, 0.0, 0.5, 'carne'),
('Salchichón curado', 'Embutido graso de cerdo con especias.', 420, 25.0, 36.0, 1.0, 0.0, 1.0, 'carne'),
('Fuet', 'Embutido catalán fino y curado, de cerdo.', 455, 24.0, 39.0, 1.5, 0.0, 1.5, 'carne'),
('Lomo embuchado', 'Corte de lomo curado con especias, bajo en carbohidratos.', 250, 37.0, 12.0, 0.5, 0.0, 0.5, 'carne'),
('Sobrasada', 'Embutido untuoso típico de Baleares, con pimentón.', 449, 14.0, 43.0, 1.0, 0.0, 0.5, 'carne'),
('Longaniza', 'Embutido curado de cerdo, similar al chorizo pero más suave.', 410, 23.0, 35.0, 1.5, 0.0, 1.0, 'carne'),
('Salami', 'Embutido curado y especiado, popular en bocadillos.', 430, 22.0, 38.0, 1.0, 0.0, 1.0, 'carne'),
('Mortadela', 'Fiambre de cerdo de textura blanda y sabor suave.', 311, 13.0, 28.0, 1.0, 0.0, 1.0, 'carne'),
('Salchicha tipo Frankfurt', 'Embutido cocido ahumado, típico de perritos calientes.', 301, 11.0, 27.0, 2.0, 0.0, 1.5, 'carne'),
('Hamburguesa de ternera', 'Carne picada de ternera en forma de hamburguesa, lista para cocinar.', 230, 18.0, 17.0, 0.5, 0.0, 0.2, 'carne'),
('Hamburguesa de cerdo', 'Versión más grasa que la de ternera, sabor intenso.', 260, 17.0, 21.0, 0.5, 0.0, 0.3, 'carne'),
('Hamburguesa mixta', 'Mezcla de carne de ternera y cerdo, habitual en supermercados.', 245, 17.5, 19.0, 0.6, 0.0, 0.3, 'carne'),
('Hamburguesa vegetal (no vegana)', 'Preparado vegetal con huevo y leche, sabor cárnico.', 160, 12.0, 6.0, 12.0, 3.0, 2.0, 'carne'),
('Albóndigas de carne', 'Bolas de carne picada cocinadas con salsa o guarnición.', 240, 15.0, 18.0, 2.5, 0.5, 1.0, 'carne'),
('Carne picada mixta', 'Carne molida de ternera y cerdo, sin formar.', 220, 18.0, 16.0, 0.0, 0.0, 0.0, 'carne'),
('Filete empanado de cerdo', 'Carne rebozada y frita, muy calórica.', 290, 16.0, 18.0, 15.0, 1.0, 1.0, 'carne'),
('Escalope de ternera', 'Filete rebozado de ternera, crujiente y jugoso.', 265, 17.0, 15.0, 14.0, 1.1, 0.9, 'carne'),
('Brocheta de carne adobada', 'Pincho con trozos de carne sazonada lista para asar.', 190, 20.0, 10.0, 1.0, 0.3, 0.5, 'carne'),
('Carne mechada', 'Carne cocida y desmenuzada, típica en bocadillos.', 225, 22.0, 15.0, 1.0, 0.0, 0.3, 'carne'),
('Semillas de chía', 'Ricas en omega-3, fibra y proteínas vegetales.', 486, 16.5, 30.7, 42.1, 34.4, 0.0, 'semilla'),
('Semillas de lino', 'Fuente vegetal de omega-3 y lignanos, muy digestivas si se muelen.', 534, 18.3, 42.2, 28.9, 27.3, 1.6, 'semilla'),
('Semillas de sésamo', 'Muy calóricas, fuente de calcio, fósforo y proteínas.', 573, 17.7, 49.7, 23.5, 11.8, 0.3, 'semilla'),
('Semillas de calabaza', 'Ricas en zinc, hierro y grasas saludables.', 559, 30.2, 49.0, 10.7, 6.0, 1.4, 'semilla'),
('Semillas de girasol', 'Fuente de vitamina E y grasas monoinsaturadas.', 584, 20.8, 51.5, 20.0, 8.6, 2.6, 'semilla'),
('Semillas de amapola', 'Pequeñas semillas aromáticas, fuente de calcio y fibra.', 525, 18.0, 42.0, 28.1, 20.0, 3.0, 'semilla'),
('Semillas de cáñamo', 'Contienen todos los aminoácidos esenciales, muy completas.', 553, 31.6, 48.8, 8.7, 4.0, 1.5, 'semilla'),
('Semillas de mostaza', 'Pequeñas y picantes, se usan para condimentar.', 508, 26.1, 36.2, 28.1, 12.2, 6.2, 'semilla'),
('Semillas de albahaca', 'Similares a la chía, se hinchan al contacto con agua.', 442, 14.8, 24.4, 43.0, 37.0, 0.0, 'semilla'),
('Semillas de hinojo', 'Aromáticas, se usan como infusión o en cocina.', 345, 15.8, 14.9, 52.3, 39.8, 0.5, 'semilla'),
('Azúcar blanco', 'Edulcorante refinado, aporta solo energía.', 387, 0.0, 0.0, 100.0, 0.0, 100.0, 'otro'),
('Azúcar moreno', 'Azúcar sin refinar, con trazas de melaza.', 380, 0.1, 0.0, 98.0, 0.2, 95.0, 'otro'),
('Miel', 'Edulcorante natural producido por abejas.', 304, 0.3, 0.0, 82.4, 0.2, 82.1, 'otro'),
('Sirope de agave', 'Jarabe vegetal dulce, con bajo índice glucémico.', 310, 0.1, 0.0, 76.0, 0.1, 75.0, 'otro'),
('Stevia', 'Edulcorante natural sin calorías, extraído de plantas.', 0, 0.0, 0.0, 0.0, 0.0, 0.0, 'otro'),
('Aceite de oliva virgen extra', 'Grasa saludable rica en antioxidantes.', 884, 0.0, 100.0, 0.0, 0.0, 0.0, 'otro'),
('Aceite de girasol', 'Aceite vegetal neutro, rico en vitamina E.', 884, 0.0, 100.0, 0.0, 0.0, 0.0, 'otro'),
('Vinagre de vino', 'Líquido ácido usado como aderezo y conservante.', 21, 0.0, 0.0, 0.0, 0.0, 0.0, 'otro'),
('Sal', 'Condimento básico, no aporta calorías pero sí sodio.', 0, 0.0, 0.0, 0.0, 0.0, 0.0, 'otro'),
('Pimienta negra', 'Especia picante, usada en múltiples recetas.', 251, 10.4, 3.3, 64.8, 25.3, 0.6, 'otro'),
('Cúrcuma', 'Especia amarilla con propiedades antiinflamatorias.', 354, 7.8, 9.9, 64.9, 21.1, 3.2, 'otro'),
('Canela en polvo', 'Especia dulce muy usada en repostería.', 247, 4.0, 1.2, 81.0, 53.1, 2.2, 'otro'),
('Pimentón dulce', 'Condimento en polvo típico de la cocina española.', 282, 14.1, 13.1, 54.7, 34.9, 10.3, 'otro'),
('Curry', 'Mezcla de especias aromáticas típicas de la India.', 325, 14.3, 14.0, 58.2, 33.0, 2.5, 'otro'),
('Comino', 'Semilla aromática muy usada en cocina árabe y española.', 375, 17.8, 22.3, 44.2, 10.5, 2.3, 'otro'),
('Mostaza en grano', 'Semilla picante y aromática usada en encurtidos y salsas.', 508, 26.1, 36.2, 28.1, 12.2, 6.2, 'otro'),
('Levadura de panadería seca', 'Agente leudante natural, usado en pan y masas.', 325, 40.0, 7.0, 41.0, 26.0, 0.0, 'otro'),
('Levadura química (impulsor)', 'Gasificante usado en bizcochos y repostería.', 97, 0.0, 0.0, 24.3, 0.0, 0.0, 'otro'),
('Masa madre deshidratada', 'Fermento natural en polvo, da sabor y textura al pan.', 255, 11.0, 1.5, 52.0, 3.0, 1.2, 'otro'),
('Bicarbonato sódico', 'Agente alcalino usado como gasificante o antiácido.', 0, 0.0, 0.0, 0.0, 0.0, 0.0, 'otro');

INSERT INTO ingrediente (nombre, descripcion, calorias, proteinas, grasas, carbohidratos, fibra, azucar, tipo) VALUES
('Hummus', 'Puré de garbanzos con aceite y tahini, rico en proteínas vegetales.', 166, 7.9, 9.6, 14.3, 6.0, 0.3, 'legumbre'),
('Tomate cherry', 'Variedad pequeña de tomate, dulce y bajo en calorías.', 18, 0.9, 0.2, 3.9, 1.2, 2.6, 'verdura'),
('Yogur vegetal', 'Alternativa sin lácteos, hecho a base de bebidas vegetales.', 55, 1.6, 2.4, 6.5, 0.7, 2.5, 'lácteo'),
('Tostada de arroz', 'Tostada ligera hecha con arroz inflado, sin gluten.', 380, 7.9, 2.8, 81.0, 3.5, 0.4, 'cereal'),
('Aguacate', 'Fruta rica en grasas saludables y fibra.', 160, 2.0, 14.7, 8.5, 6.7, 0.7, 'fruta'),
('Huevo duro', 'Huevo cocido, fuente de proteína y grasas saludables.', 155, 13.0, 11.0, 1.1, 0.0, 1.1, 'huevo'),
('Galletas sin gluten', 'Galletas elaboradas con harinas alternativas sin gluten.', 470, 5.0, 21.0, 65.0, 3.0, 18.0, 'cereal'),
('Compota de manzana', 'Purée natural de manzana cocida sin azúcar añadido.', 50, 0.2, 0.1, 13.0, 1.3, 10.0, 'fruta'),
('Tomate triturado', 'Tomate cocido y triturado, base para salsas.', 32, 1.3, 0.2, 6.0, 1.4, 4.0, 'verdura'),
('Bebida vegetal de coco', 'Bebida sin lactosa con sabor suave y tropical.', 24, 0.2, 1.1, 3.0, 0.2, 1.9, 'bebida'),
('Avena sin gluten', 'Cereal integral sin gluten, ideal para desayuno.', 370, 12.0, 7.0, 60.0, 9.0, 1.0, 'cereal'),
('Tostadas de maíz', 'Tostadas crujientes elaboradas con harina de maíz.', 370, 6.0, 4.5, 75.0, 5.0, 1.5, 'cereal'),
('Galletas sin lactosa', 'Galletas elaboradas sin ingredientes lácteos.', 460, 5.5, 20.0, 65.0, 2.0, 18.0, 'cereal'),
('Compota de pera', 'Purée de pera cocida, sin azúcar añadido.', 55, 0.2, 0.1, 14.0, 2.0, 10.0, 'fruta'),
('Tostadas de arroz', 'Variante ligera sin gluten, crujiente y saciante.', 380, 7.9, 2.8, 81.0, 3.5, 0.4, 'cereal'),
('Crema de almendras', 'Pasta de almendras rica en grasas saludables.', 610, 20.0, 55.0, 18.0, 10.0, 4.5, 'fruto_seco'),
('Pan de centeno', 'Pan integral con alto contenido en fibra y sabor intenso.', 250, 8.0, 3.3, 48.0, 5.0, 1.2, 'cereal'),
('Frutos rojos', 'Mezcla de frutas antioxidantes como arándanos, fresas y moras.', 45, 0.7, 0.3, 11.0, 3.0, 6.0, 'fruta'),
('Mermelada sin azúcar', 'Conserva de fruta edulcorada sin azúcares añadidos.', 30, 0.2, 0.1, 7.5, 1.0, 3.5, 'fruta'),
('Huevo', 'Alimento completo rico en proteínas de alto valor biológico.', 155, 13.0, 11.0, 1.1, 0.0, 1.1, 'huevo'),
('Galletas sin huevo', 'Galletas elaboradas sin trazas ni ingredientes con huevo.', 470, 5.0, 21.0, 65.0, 3.0, 18.0, 'cereal'),
('Tostadas integrales', 'Tostadas elaboradas con pan integral, altas en fibra.', 360, 10.0, 4.5, 65.0, 7.0, 2.5, 'cereal'),
('Tostadas sin huevo', 'Tostadas elaboradas sin huevo, aptas para alérgicos.', 360, 8.0, 4.5, 70.0, 6.0, 2.5, 'cereal'),
('Pisto', 'Mezcla de verduras cocinadas como base de plato vegetal.', 80, 1.5, 4.0, 8.0, 2.0, 4.0, 'verdura'),
('Pollo', 'Carne blanca magra rica en proteínas.', 165, 31.0, 3.6, 0.0, 0.0, 0.0, 'carne'),
('Patata', 'Tubérculo rico en hidratos de carbono complejos.', 77, 2.0, 0.1, 17.0, 2.2, 0.9, 'verdura'),
('Pasta sin gluten', 'Pasta elaborada con harinas sin gluten como arroz o maíz.', 350, 6.0, 1.5, 75.0, 2.5, 1.0, 'cereal'),
('Ensalada verde', 'Mezcla de lechugas, canónigos y otras hojas verdes.', 18, 1.0, 0.2, 3.0, 1.5, 1.5, 'verdura'),
('Tofu', 'Proteína vegetal derivada de la soja, rica en calcio.', 145, 15.0, 8.0, 3.9, 1.0, 0.6, 'legumbre'),
('Verduras salteadas', 'Mezcla de verduras ligeramente cocinadas en sartén.', 90, 2.0, 4.0, 10.0, 3.0, 4.0, 'verdura'),
('Calabaza', 'Hortaliza dulce rica en betacarotenos y fibra.', 26, 1.0, 0.1, 6.5, 0.5, 2.0, 'verdura'),
('Verduras asadas', 'Mezcla de pimientos, cebolla y calabacín al horno.', 75, 1.5, 2.5, 10.0, 3.0, 5.0, 'verdura'),
('Pasta integral', 'Pasta elaborada con trigo integral, rica en fibra.', 350, 12.0, 2.0, 68.0, 6.5, 2.0, 'cereal'),
('Crema de girasol', 'Pasta vegetal elaborada con semillas de girasol.', 595, 18.0, 52.0, 20.0, 6.0, 2.0, 'semilla'),
('Pescado blanco', 'Pescado bajo en grasa y alto en proteínas como merluza.', 90, 20.0, 1.5, 0.0, 0.0, 0.0, 'pescado'),
('Verduras al vapor', 'Mezcla cocida al vapor de brócoli, coliflor y zanahoria.', 40, 2.0, 0.5, 6.5, 3.0, 3.5, 'verdura');

INSERT INTO glosario (termino, definicion, fuente, categoria, imagen_url, visible)
VALUES
('Nutriente', 'Sustancia presente en los alimentos que es necesaria para el crecimiento, desarrollo y mantenimiento de la vida.', 'FAO/OMS', 'concepto', 'https://ejemplo.com/nutriente.jpg', TRUE),
('Caloría', 'Unidad de energía que indica la cantidad de energía que aporta un alimento al cuerpo humano.', 'Organización Mundial de la Salud', 'concepto', 'https://ejemplo.com/caloria.jpg', TRUE),
('Metabolismo', 'Conjunto de procesos químicos que ocurren en el organismo para mantener la vida, incluyendo la conversión de alimentos en energía.', 'MedlinePlus', 'concepto', 'https://ejemplo.com/metabolismo.jpg', TRUE),
('Índice glucémico', 'Medida de la velocidad con la que un alimento eleva el nivel de glucosa en sangre.', 'Harvard Medical School', 'concepto', 'https://ejemplo.com/indice-glucemico.jpg', TRUE),
('Densidad nutricional', 'Cantidad de nutrientes que contiene un alimento en relación con su aporte calórico.', 'EFSA', 'concepto', 'https://ejemplo.com/densidad-nutricional.jpg', TRUE),
('Digestión', 'Proceso por el cual el cuerpo descompone los alimentos en nutrientes que puede absorber y utilizar.', 'NIH', 'concepto', 'https://ejemplo.com/digestion.jpg', TRUE),
('Balance energético', 'Relación entre la energía que se consume a través de los alimentos y la que se gasta en las funciones corporales y actividad física.', 'FAO', 'concepto', 'https://ejemplo.com/balance-energetico.jpg', TRUE),
('Necesidades energéticas', 'Cantidad de energía que una persona requiere diariamente para mantener sus funciones vitales y nivel de actividad.', 'EFSA', 'concepto', 'https://ejemplo.com/necesidades-energeticas.jpg', TRUE),
('Ración', 'Cantidad estándar de un alimento utilizada como referencia para evaluar el consumo.', 'Ministerio de Sanidad España', 'concepto', 'https://ejemplo.com/racion.jpg', TRUE),
('Etiqueta nutricional', 'Información obligatoria que aparece en el envase de los alimentos sobre su composición nutricional.', 'AESAN', 'concepto', 'https://ejemplo.com/etiqueta-nutricional.jpg', TRUE),
('Valor nutricional', 'Conjunto de nutrientes y energía que aporta un alimento por una cantidad determinada.', 'AESAN', 'concepto', 'https://ejemplo.com/valor-nutricional.jpg', TRUE),
('Requerimientos diarios', 'Cantidad estimada de cada nutriente que debe consumir una persona diariamente para mantener la salud.', 'EFSA', 'concepto', 'https://ejemplo.com/requerimientos-diarios.jpg', TRUE),
('Saciedad', 'Sensación de plenitud que indica que no se necesita seguir comiendo.', 'FAO', 'concepto', 'https://ejemplo.com/saciedad.jpg', TRUE),
('Estado nutricional', 'Condición física resultante del equilibrio entre el consumo de nutrientes y las necesidades del organismo.', 'OMS', 'concepto', 'https://ejemplo.com/estado-nutricional.jpg', TRUE),
('Absorción', 'Proceso mediante el cual los nutrientes pasan del sistema digestivo a la sangre o linfa.', 'NIH', 'concepto', 'https://ejemplo.com/absorcion.jpg', TRUE),
('Malnutrición', 'Condición que resulta de una alimentación inadecuada o desequilibrada, ya sea por exceso o defecto.', 'OMS', 'concepto', 'https://ejemplo.com/malnutricion.jpg', TRUE),
('Alimento funcional', 'Alimento que, además de nutrir, proporciona beneficios adicionales para la salud.', 'EFSA', 'concepto', 'https://ejemplo.com/alimento-funcional.jpg', TRUE),
('Biodisponibilidad', 'Proporción de un nutriente que es absorbido y utilizado efectivamente por el organismo.', 'FAO', 'concepto', 'https://ejemplo.com/biodisponibilidad.jpg', TRUE),
('Perfil nutricional', 'Descripción de la cantidad de nutrientes y energía contenida en un alimento o dieta.', 'AESAN', 'concepto', 'https://ejemplo.com/perfil-nutricional.jpg', TRUE),
('Educación nutricional', 'Proceso que permite adquirir conocimientos y hábitos para mejorar la alimentación y la salud.', 'Ministerio de Sanidad', 'concepto', 'https://ejemplo.com/educacion-nutricional.jpg', TRUE),
('Hábitos alimentarios', 'Conjunto de comportamientos adquiridos por una persona o grupo respecto a la elección y consumo de alimentos.', 'FAO', 'concepto', 'https://ejemplo.com/habitos-alimentarios.jpg', TRUE),
('Dieta equilibrada', 'Plan de alimentación que proporciona todos los nutrientes necesarios en cantidades adecuadas para mantener la salud.', 'OMS', 'concepto', 'https://ejemplo.com/dieta-equilibrada.jpg', TRUE),
('Composición corporal', 'Distribución de masa muscular, grasa, hueso y otros componentes en el cuerpo.', 'NIH', 'concepto', 'https://ejemplo.com/composicion-corporal.jpg', TRUE),
('Nutrición personalizada', 'Enfoque dietético adaptado a las necesidades individuales según genética, metabolismo y estilo de vida.', 'EFSA', 'concepto', 'https://ejemplo.com/nutricion-personalizada.jpg', TRUE),
('Alimentación intuitiva', 'Estilo de alimentación basado en señales internas como el hambre y la saciedad, sin restricciones externas.', 'Academy of Nutrition and Dietetics', 'concepto', 'https://ejemplo.com/alimentacion-intuitiva.jpg', TRUE),
('Etiqueta de ingredientes', 'Lista que muestra todos los ingredientes presentes en un producto alimenticio, ordenados por cantidad.', 'AESAN', 'concepto', 'https://ejemplo.com/etiqueta-ingredientes.jpg', TRUE),
('Contaminante alimentario', 'Sustancia no deseada presente en alimentos que puede afectar la salud.', 'EFSA', 'concepto', 'https://ejemplo.com/contaminante-alimentario.jpg', TRUE),
('Nutrigenómica', 'Estudio de cómo los alimentos afectan la expresión genética y el metabolismo.', 'Genomics and Nutrition Journal', 'concepto', 'https://ejemplo.com/nutrigenomica.jpg', TRUE),
('Saciedad hormonal', 'Sensación de plenitud regulada por hormonas como la leptina y la grelina.', 'NIH', 'concepto', 'https://ejemplo.com/saciedad-hormonal.jpg', TRUE),
('Hidratación', 'Estado de equilibrio de líquidos en el organismo, esencial para el funcionamiento celular.', 'OMS', 'concepto', 'https://ejemplo.com/hidratacion.jpg', TRUE),
('Proteínas', 'Macronutrientes esenciales formados por aminoácidos que participan en la construcción y reparación de tejidos.', 'FAO/OMS', 'macronutriente', 'https://ejemplo.com/proteinas.jpg', TRUE),
('Carbohidratos', 'Macronutrientes que constituyen la principal fuente de energía del cuerpo, presentes en alimentos como cereales, frutas y legumbres.', 'EFSA', 'macronutriente', 'https://ejemplo.com/carbohidratos.jpg', TRUE),
('Grasas', 'Nutrientes energéticos que también cumplen funciones estructurales y hormonales, incluyendo grasas saturadas, insaturadas y trans.', 'OMS', 'macronutriente', 'https://ejemplo.com/grasas.jpg', TRUE),
('Fibra dietética', 'Tipo de carbohidrato no digerible que favorece el tránsito intestinal y la salud digestiva.', 'MedlinePlus', 'macronutriente', 'https://ejemplo.com/fibra.jpg', TRUE),
('Agua', 'Elemento vital que actúa como medio de transporte, regula la temperatura y permite múltiples funciones biológicas.', 'FAO', 'macronutriente', 'https://ejemplo.com/agua.jpg', TRUE),
('Vitamina A', 'Vitamina liposoluble que contribuye a la visión, el sistema inmunitario y la salud de la piel.', 'EFSA', 'vitamina', 'https://ejemplo.com/vitamina-a.jpg', TRUE),
('Vitamina D', 'Vitamina liposoluble que favorece la absorción del calcio y el fósforo, esencial para la salud ósea.', 'OMS', 'vitamina', 'https://ejemplo.com/vitamina-d.jpg', TRUE),
('Vitamina E', 'Antioxidante liposoluble que protege las células frente al daño oxidativo.', 'FAO', 'vitamina', 'https://ejemplo.com/vitamina-e.jpg', TRUE),
('Vitamina K', 'Vitamina liposoluble que interviene en la coagulación de la sangre y la salud ósea.', 'NIH', 'vitamina', 'https://ejemplo.com/vitamina-k.jpg', TRUE),
('Calcio', 'Mineral esencial para la formación y mantenimiento de huesos y dientes, también participa en la contracción muscular y la coagulación sanguínea.', 'EFSA', 'mineral', 'https://ejemplo.com/calcio.jpg', TRUE),
('Hierro', 'Mineral necesario para la formación de hemoglobina y el transporte de oxígeno en la sangre.', 'OMS', 'mineral', 'https://ejemplo.com/hierro.jpg', TRUE),
('Magnesio', 'Mineral que participa en más de 300 reacciones bioquímicas del cuerpo, incluyendo la función muscular y nerviosa.', 'NIH', 'mineral', 'https://ejemplo.com/magnesio.jpg', TRUE),
('Zinc', 'Mineral implicado en el sistema inmunológico, la cicatrización y la división celular.', 'FAO', 'mineral', 'https://ejemplo.com/zinc.jpg', TRUE),
('Potasio', 'Mineral que ayuda a mantener el equilibrio de líquidos, la función muscular y la actividad eléctrica del corazón.', 'OMS', 'mineral', 'https://ejemplo.com/potasio.jpg', TRUE),
('Fósforo', 'Mineral importante para la formación de huesos y dientes, así como para la producción de energía celular.', 'EFSA', 'mineral', 'https://ejemplo.com/fosforo.jpg', TRUE),
('Sodio', 'Mineral esencial para el equilibrio de líquidos y la función nerviosa, aunque su exceso puede afectar la salud cardiovascular.', 'AESAN', 'mineral', 'https://ejemplo.com/sodio.jpg', TRUE),
('Yodo', 'Mineral necesario para la producción de hormonas tiroideas que regulan el metabolismo.', 'FAO', 'mineral', 'https://ejemplo.com/yodo.jpg', TRUE),
('Selenio', 'Antioxidante que protege las células del daño y apoya la función inmunitaria y tiroidea.', 'NIH', 'mineral', 'https://ejemplo.com/selenio.jpg', TRUE),
('Cobre', 'Mineral que participa en la producción de energía, la formación de tejidos conectivos y el sistema nervioso.', 'OMS', 'mineral', 'https://ejemplo.com/cobre.jpg', TRUE),
('Manganeso', 'Mineral involucrado en el metabolismo de carbohidratos y lípidos, y en la formación de huesos.', 'EFSA', 'mineral', 'https://ejemplo.com/manganeso.jpg', TRUE),
('Flúor', 'Mineral que fortalece el esmalte dental y previene las caries.', 'OMS', 'mineral', 'https://ejemplo.com/fluor.jpg', TRUE),
('Cromo', 'Mineral que contribuye al metabolismo de la glucosa y mejora la acción de la insulina.', 'NIH', 'mineral', 'https://ejemplo.com/cromo.jpg', TRUE),
('Molibdeno', 'Mineral que forma parte de enzimas implicadas en el metabolismo de aminoácidos y purinas.', 'FAO', 'mineral', 'https://ejemplo.com/molibdeno.jpg', TRUE),
('Cloro', 'Mineral esencial para la producción de jugos gástricos y el equilibrio de líquidos en el organismo.', 'EFSA', 'mineral', 'https://ejemplo.com/cloro.jpg', TRUE),
('Níquel', 'Mineral traza que participa en algunas enzimas, aunque sus funciones en humanos no están completamente claras.', 'EFSA', 'mineral', 'https://ejemplo.com/niquel.jpg', TRUE),
('Silicio', 'Mineral que interviene en la síntesis del colágeno y puede contribuir a la salud ósea y cutánea.', 'NIH', 'mineral', 'https://ejemplo.com/silicio.jpg', TRUE),
('Boro', 'Mineral que podría estar relacionado con el metabolismo del calcio, magnesio y fósforo.', 'FAO', 'mineral', 'https://ejemplo.com/boro.jpg', TRUE),
('Litio', 'Oligoelemento que se estudia por su posible papel en la función neurológica y la salud mental.', 'NIH', 'mineral', 'https://ejemplo.com/litio.jpg', TRUE),
('Vanadio', 'Oligoelemento presente en pequeñas cantidades en el cuerpo, se investiga su papel en el metabolismo de lípidos y glucosa.', 'EFSA', 'mineral', 'https://ejemplo.com/vanadio.jpg', TRUE),
('Proteína en polvo', 'Suplemento alimenticio utilizado para aumentar la ingesta proteica, común en dietas deportivas o hipocalóricas.', 'EFSA', 'suplemento', 'https://ejemplo.com/proteina-polvo.jpg', TRUE),
('Creatina', 'Compuesto natural que mejora el rendimiento en ejercicios de alta intensidad y favorece la recuperación muscular.', 'NIH', 'suplemento', 'https://ejemplo.com/creatina.jpg', TRUE),
('Omega-3', 'Ácidos grasos esenciales que se suplementan por su efecto antiinflamatorio y beneficios cardiovasculares.', 'FAO', 'suplemento', 'https://ejemplo.com/omega-3.jpg', TRUE),
('Multivitamínico', 'Suplemento que combina varias vitaminas y minerales para cubrir requerimientos nutricionales diarios.', 'OMS', 'suplemento', 'https://ejemplo.com/multivitaminico.jpg', TRUE),
('Vitamina D3', 'Suplemento liposoluble usado para mantener niveles óptimos de vitamina D, especialmente en personas con baja exposición solar.', 'EFSA', 'suplemento', 'https://ejemplo.com/vitamina-d3.jpg', TRUE),
('Colágeno hidrolizado', 'Suplemento que aporta péptidos de colágeno, favoreciendo la salud articular, cutánea y ósea.', 'NIH', 'suplemento', 'https://ejemplo.com/colageno.jpg', TRUE),
('Magnesio en comprimidos', 'Forma suplementada de magnesio utilizada para prevenir calambres musculares y mejorar la calidad del sueño.', 'FAO', 'suplemento', 'https://ejemplo.com/magnesio-suplemento.jpg', TRUE),
('Cafeína', 'Suplemento estimulante que mejora la concentración, el estado de alerta y el rendimiento deportivo.', 'EFSA', 'suplemento', 'https://ejemplo.com/cafeina.jpg', TRUE),
('BCAA', 'Aminoácidos de cadena ramificada que se suplementan para preservar masa muscular y acelerar la recuperación.', 'NIH', 'suplemento', 'https://ejemplo.com/bcaa.jpg', TRUE),
('Glutamina', 'Aminoácido que puede apoyar la recuperación muscular y la función inmunológica en situaciones de alta exigencia física.', 'FAO', 'suplemento', 'https://ejemplo.com/glutamina.jpg', TRUE),
('Dieta mediterránea', 'Patrón alimentario basado en el consumo de frutas, verduras, legumbres, pescado, aceite de oliva y cereales integrales, característico de los países del Mediterráneo.', 'Fundación Dieta Mediterránea', 'dieta', 'https://ejemplo.com/dieta-mediterranea.jpg', TRUE),
('Dieta cetogénica', 'Dieta alta en grasas, moderada en proteínas y muy baja en carbohidratos, orientada a inducir cetosis para el uso de grasa como fuente principal de energía.', 'EFSA', 'dieta', 'https://ejemplo.com/dieta-cetogenica.jpg', TRUE),
('Dieta vegana', 'Dieta basada exclusivamente en alimentos de origen vegetal, excluyendo cualquier producto de origen animal.', 'The Vegan Society', 'dieta', 'https://ejemplo.com/dieta-vegana.jpg', TRUE),
('Dieta vegetariana', 'Dieta que excluye carne y pescado, pero puede incluir productos animales como huevos o lácteos.', 'Academy of Nutrition and Dietetics', 'dieta', 'https://ejemplo.com/dieta-vegetariana.jpg', TRUE),
('Dieta DASH', 'Dieta diseñada para reducir la presión arterial, rica en frutas, verduras, granos integrales y baja en sodio y grasas saturadas.', 'NIH', 'dieta', 'https://ejemplo.com/dieta-dash.jpg', TRUE),
('Dieta sin gluten', 'Dieta que elimina el gluten, una proteína presente en trigo, cebada y centeno, indicada para personas con celiaquía o sensibilidad al gluten.', 'AESAN', 'dieta', 'https://ejemplo.com/dieta-sin-gluten.jpg', TRUE),
('Dieta sin lactosa', 'Plan alimentario que excluye productos lácteos con lactosa, útil para personas con intolerancia a este azúcar.', 'EFSA', 'dieta', 'https://ejemplo.com/dieta-sin-lactosa.jpg', TRUE),
('Dieta hipocalórica', 'Dieta con un aporte energético reducido respecto a las necesidades del individuo, utilizada frecuentemente en procesos de pérdida de peso.', 'OMS', 'dieta', 'https://ejemplo.com/dieta-hipocalorica.jpg', TRUE),
('Dieta hiperproteica', 'Dieta rica en proteínas que busca preservar la masa muscular, especialmente en contextos de entrenamiento o pérdida de grasa.', 'NIH', 'dieta', 'https://ejemplo.com/dieta-hiperproteica.jpg', TRUE),
('Ayuno intermitente', 'Patrón de alimentación que alterna períodos de ingesta con períodos de ayuno, con el objetivo de mejorar la composición corporal o la salud metabólica.', 'Harvard Health Publishing', 'dieta', 'https://ejemplo.com/ayuno-intermitente.jpg', TRUE),
('Ejercicio aeróbico', 'Actividad física de intensidad moderada y larga duración que mejora la capacidad cardiovascular y la quema de grasa.', 'OMS', 'deporte', 'https://ejemplo.com/ejercicio-aerobico.jpg', TRUE),
('Ejercicio anaeróbico', 'Actividad de alta intensidad y corta duración que depende de reservas de energía sin oxígeno, como el entrenamiento de fuerza.', 'NIH', 'deporte', 'https://ejemplo.com/ejercicio-anaerobico.jpg', TRUE),
('VO2 máximo', 'Volumen máximo de oxígeno que el cuerpo puede utilizar durante el ejercicio intenso, indicador clave de resistencia cardiovascular.', 'EFSA', 'deporte', 'https://ejemplo.com/vo2max.jpg', TRUE),
('Recuperación muscular', 'Proceso fisiológico de regeneración de fibras musculares después del ejercicio, esencial para el rendimiento y prevención de lesiones.', 'FAO', 'deporte', 'https://ejemplo.com/recuperacion-muscular.jpg', TRUE),
('Gasto energético', 'Cantidad de energía que el cuerpo utiliza en reposo, actividad física y digestión.', 'EFSA', 'deporte', 'https://ejemplo.com/gasto-energetico.jpg', TRUE),
('Entrenamiento de resistencia', 'Actividad que implica la repetición de movimientos con carga para aumentar fuerza muscular y masa magra.', 'NIH', 'deporte', 'https://ejemplo.com/entrenamiento-resistencia.jpg', TRUE),
('Rendimiento deportivo', 'Capacidad de un atleta para ejecutar una actividad física con eficacia y eficiencia.', 'OMS', 'deporte', 'https://ejemplo.com/rendimiento-deportivo.jpg', TRUE);
INSERT INTO glosario (termino, definicion, fuente, categoria, imagen_url, visible)
VALUES
('Suplementación deportiva', 'Uso de productos nutricionales para optimizar el rendimiento, recuperación o salud en el contexto del deporte.', 'EFSA', 'deporte', 'https://ejemplo.com/suplementacion-deportiva.jpg', TRUE),
('Carga glucogénica', 'Técnica nutricional que busca maximizar los depósitos de glucógeno muscular antes de una competición.', 'NIH', 'deporte', 'https://ejemplo.com/carga-glucogenica.jpg', TRUE),
('Deshidratación', 'Estado de déficit de agua corporal que puede afectar el rendimiento físico y mental.', 'OMS', 'deporte', 'https://ejemplo.com/deshidratacion.jpg', TRUE),
('Ácido fólico', 'Forma sintética del folato, una vitamina B necesaria para la producción de ADN y el desarrollo celular, especialmente importante en el embarazo.', 'OMS', 'micronutriente', 'https://ejemplo.com/acido-folico.jpg', TRUE),
('Colina', 'Micronutriente relacionado con la vitamina B que participa en funciones hepáticas, desarrollo cerebral y síntesis de neurotransmisores.', 'NIH', 'micronutriente', 'https://ejemplo.com/colina.jpg', TRUE),
('Carotenoides', 'Pigmentos vegetales con propiedades antioxidantes, precursores de la vitamina A, presentes en frutas y verduras de color naranja y rojo.', 'EFSA', 'micronutriente', 'https://ejemplo.com/carotenoides.jpg', TRUE),
('Flavonoides', 'Compuestos bioactivos con función antioxidante y antiinflamatoria, presentes en frutas, verduras, té y vino tinto.', 'FAO', 'micronutriente', 'https://ejemplo.com/flavonoides.jpg', TRUE),
('Luteína', 'Carotenoide que se acumula en la retina y puede ayudar a proteger la salud ocular.', 'NIH', 'micronutriente', 'https://ejemplo.com/luteina.jpg', TRUE),
('Licopeno', 'Carotenoide con potentes propiedades antioxidantes, abundante en el tomate y otros frutos rojos.', 'EFSA', 'micronutriente', 'https://ejemplo.com/licopeno.jpg', TRUE),
('Inositol', 'Micronutriente involucrado en funciones celulares, hormonales y del sistema nervioso, a menudo clasificado con el complejo B.', 'FAO', 'micronutriente', 'https://ejemplo.com/inositol.jpg', TRUE),
('Coenzima Q10', 'Compuesto antioxidante que participa en la producción de energía celular y puede apoyar la salud cardiovascular.', 'NIH', 'micronutriente', 'https://ejemplo.com/coenzima-q10.jpg', TRUE),
('Taurina', 'Aminoácido sulfonado con funciones antioxidantes y reguladoras de la presión osmótica, presente en muchos tejidos humanos.', 'EFSA', 'micronutriente', 'https://ejemplo.com/taurina.jpg', TRUE),
('Betacaroteno', 'Precursor de la vitamina A con función antioxidante, presente en alimentos de origen vegetal como la zanahoria.', 'OMS', 'micronutriente', 'https://ejemplo.com/betacaroteno.jpg', TRUE),
('Alimento ultraprocesado', 'Producto industrial comestible con múltiples ingredientes y aditivos, asociado a un bajo valor nutricional y alto riesgo de enfermedades crónicas.', 'NOVA', 'otro', 'https://ejemplo.com/ultraprocesado.jpg', TRUE),
('Nutrición emocional', 'Relación entre la alimentación y las emociones, que puede afectar hábitos como el hambre emocional o el atracón.', 'Harvard Health', 'otro', 'https://ejemplo.com/nutricion-emocional.jpg', TRUE),
('Carga glucémica', 'Indicador que combina el índice glucémico y la cantidad de carbohidratos de un alimento para estimar su impacto glucémico real.', 'EFSA', 'otro', 'https://ejemplo.com/carga-glucemica.jpg', TRUE),
('Etiquetado nutricional', 'Información obligatoria o voluntaria que figura en los envases de alimentos sobre su composición y propiedades.', 'AESAN', 'otro', 'https://ejemplo.com/etiquetado.jpg', TRUE),
('Conservantes', 'Sustancias añadidas a los alimentos para evitar su deterioro microbiano o químico.', 'FAO', 'otro', 'https://ejemplo.com/conservantes.jpg', TRUE),
('Aditivos alimentarios', 'Sustancias utilizadas para mejorar el sabor, color, textura o conservación de los productos alimenticios.', 'EFSA', 'otro', 'https://ejemplo.com/aditivos.jpg', TRUE),
('Nutracéutico', 'Producto derivado de alimentos con beneficios médicos o de salud, incluyendo suplementos o alimentos funcionales.', 'NIH', 'otro', 'https://ejemplo.com/nutraceutico.jpg', TRUE),
('Transgénico', 'Organismo modificado genéticamente (OMG) al que se le han insertado genes de otra especie para mejorar su rendimiento o resistencia.', 'FAO', 'otro', 'https://ejemplo.com/transgenico.jpg', TRUE),
('Sostenibilidad alimentaria', 'Capacidad de los sistemas de alimentación para proporcionar alimentos seguros y nutritivos sin comprometer los recursos de las generaciones futuras.', 'FAO', 'otro', 'https://ejemplo.com/sostenibilidad.jpg', TRUE),
('Huella ecológica', 'Indicador del impacto ambiental de una persona o sistema, incluyendo la cantidad de recursos naturales consumidos.', 'WWF', 'otro', 'https://ejemplo.com/huella-ecologica.jpg', TRUE),
('Huella hídrica', 'Cantidad de agua utilizada directa o indirectamente para producir un alimento o servicio.', 'Water Footprint Network', 'otro', 'https://ejemplo.com/huella-hidrica.jpg', TRUE),
('Desperdicio alimentario', 'Pérdida de alimentos comestibles en cualquier etapa de la cadena alimentaria, desde la producción hasta el consumo.', 'FAO', 'otro', 'https://ejemplo.com/desperdicio-alimentario.jpg', TRUE),
('Proximidad alimentaria', 'Consumo de alimentos producidos localmente para reducir transporte, emisiones y apoyar la economía local.', 'Slow Food', 'otro', 'https://ejemplo.com/proximidad-alimentaria.jpg', TRUE),
('Alimentación consciente', 'Actitud de comer con plena atención al acto de alimentarse, respetando el hambre, la saciedad y el entorno.', 'Harvard T.H. Chan', 'otro', 'https://ejemplo.com/alimentacion-consciente.jpg', TRUE),
('Alimentación sostenible', 'Dieta saludable que tiene bajo impacto ambiental, protege la biodiversidad y promueve la equidad económica y social.', 'EFSA', 'otro', 'https://ejemplo.com/alimentacion-sostenible.jpg', TRUE),
('Ecoetiquetado', 'Sistema de etiquetado que informa sobre el impacto ambiental de un producto, promoviendo elecciones responsables.', 'UE', 'otro', 'https://ejemplo.com/ecoetiquetado.jpg', TRUE),
('Kilómetro cero', 'Concepto que promueve el consumo de alimentos producidos cerca del punto de venta o consumo, para reducir emisiones.', 'Slow Food', 'otro', 'https://ejemplo.com/km0.jpg', TRUE),
('Economía circular alimentaria', 'Modelo que busca reutilizar, reciclar y reducir el desperdicio en toda la cadena alimentaria.', 'Circular Economy EU', 'otro', 'https://ejemplo.com/economia-circular.jpg', TRUE);

INSERT INTO multimedia (titulo, descripcion, url, tipo, categoria, visible, fecha_publicacion)
VALUES
('¿Qué es una dieta saludable?', 'Vídeo educativo de la OMS que explica qué significa comer sano, con recomendaciones prácticas.', 
 'https://www.youtube.com/watch?v=3FFp9U2yNhc', 'video', 'nutricion', TRUE, '2021-05-12'),
('Nutrición y salud cardiovascular – Harvard T.H. Chan', 'Artículo web de la Escuela de Salud Pública de Harvard sobre cómo la dieta impacta en el corazón.', 
 'https://www.hsph.harvard.edu/nutritionsource/healthy-eating-plate/', 'web', 'salud', TRUE, '2023-07-20'),
('Ejercicio físico: guía visual para principiantes – NHS UK', 'Infografía sencilla sobre rutinas de ejercicio físico para todos los niveles, según el Servicio de Salud Británico.', 
 'https://www.nhs.uk/live-well/exercise/', 'web', 'ejercicio', TRUE, '2022-09-10'),
('Cómo leer una etiqueta nutricional – FDA (EE.UU.)', 'PDF oficial que enseña a interpretar etiquetas de alimentos en EE.UU., útil como ejemplo visual.', 
 'https://www.fda.gov/media/99069/download', 'pdf', 'nutricion', TRUE, '2021-04-01'),
('Mindful Eating explicado por The Nutrition Source – Harvard', 'Artículo que introduce la alimentación consciente con base científica y consejos prácticos.', 
 'https://www.hsph.harvard.edu/nutritionsource/mindful-eating/', 'web', 'mentalidad', TRUE, '2022-11-15'),
('Ejercicio físico: beneficios para la salud – Canal UNED', 'Vídeo educativo de la Universidad Nacional de Educación a Distancia sobre cómo el ejercicio impacta la salud física y mental.', 
 'https://www.youtube.com/watch?v=wFRkLfhXSaY', 'video', 'ejercicio', TRUE, '2020-04-28'),
('Rutina de ejercicios para hacer en casa sin material – Vitónica', 'Artículo con rutinas fáciles y sin equipamiento, ideal para principiantes.', 
 'https://www.vitonica.com/entrenamiento/rutina-ejercicios-casa-sin-material-para-principiantes', 'web', 'ejercicio', TRUE, '2023-01-10'),
('¿Cuánto ejercicio necesitas? – OMS', 'Infografía y guía de la Organización Mundial de la Salud con recomendaciones por edad y nivel.', 
 'https://www.who.int/es/news-room/fact-sheets/detail/physical-activity', 'web', 'ejercicio', TRUE, '2022-11-03'),
('Guía de entrenamiento de fuerza – EFSA/EuropeActive', 'PDF con pautas científicas para entrenar fuerza muscular de forma segura.', 
 'https://www.europeactive.eu/sites/europeactive.eu/files/projects/Guidelines_StructuredStrength.pdf', 'pdf', 'ejercicio', TRUE, '2021-09-01'),
('HIIT para principiantes en casa – Sergio Peinado', 'Vídeo dinámico en español con ejercicios HIIT guiados para mejorar resistencia y quemar grasa.', 
 'https://www.youtube.com/watch?v=z5qX2Nb4pmI', 'video', 'ejercicio', TRUE, '2023-02-15'),
 ('Alimentación antes y después del ejercicio – Clínica Mayo', 'Consejos prácticos sobre qué comer antes y después del entrenamiento para mejorar el rendimiento.', 
 'https://www.mayoclinic.org/es/healthy-lifestyle/fitness/in-depth/exercise/art-20045506', 'web', 'nutricion', TRUE, '2022-06-12'),
('¿Qué comer antes de entrenar? – Sergio Peinado', 'Vídeo en español con ejemplos reales de comidas pre-entreno según tipo de entrenamiento.', 
 'https://www.youtube.com/watch?v=Rj7QQoOnrRc', 'video', 'nutricion', TRUE, '2021-03-28'),
('Nutrición deportiva básica – MedlinePlus', 'Artículo introductorio que explica los fundamentos de la alimentación para deportistas.', 
 'https://medlineplus.gov/spanish/sportsnutrition.html', 'web', 'nutricion', TRUE, '2023-05-10'),
('Guía sobre proteínas para deportistas – Harvard Health', 'Análisis sobre cuánta proteína se necesita según el tipo de ejercicio y objetivos.', 
 'https://www.health.harvard.edu/blog/how-much-protein-do-you-need-every-day-201506183418', 'web', 'nutricion', TRUE, '2022-08-04'),
('Errores comunes al combinar ejercicio y dieta – PowerExplosive', 'Vídeo en español explicando mitos y errores comunes al entrenar y seguir una dieta.', 
 'https://www.youtube.com/watch?v=FeDQ6Y_OrJQ', 'video', 'nutricion', TRUE, '2022-10-20'),
 ('¿Qué es la creatina y cómo tomarla? – PowerExplosive', 'Vídeo detallado sobre la creatina, su eficacia, seguridad y cómo usarla para mejorar el rendimiento deportivo.', 
 'https://www.youtube.com/watch?v=Ulwbvf7UVdo', 'video', 'nutricion', TRUE, '2021-07-12'),
('Guía de suplementos deportivos – MedlinePlus', 'Artículo informativo sobre los principales suplementos utilizados en el deporte: proteína, creatina, cafeína y más.', 
 'https://medlineplus.gov/spanish/dietarysupplements.html', 'web', 'nutricion', TRUE, '2023-01-10'),
('¿Necesitas proteína en polvo? – Sergio Peinado', 'Vídeo explicativo para entender cuándo y cómo usar proteína en polvo en una dieta equilibrada.', 
 'https://www.youtube.com/watch?v=c2TPQJ_rMX8', 'video', 'nutricion', TRUE, '2022-05-20'),
('Suplementación en deportistas – European Food Safety Authority (EFSA)', 'Documento técnico que revisa la evidencia científica sobre suplementos populares en Europa.', 
 'https://www.efsa.europa.eu/en/topics/topic/nutrition', 'web', 'nutricion', TRUE, '2021-11-05'),
('Cafeína y rendimiento deportivo – G-SE', 'Artículo técnico que analiza los efectos de la cafeína sobre el rendimiento, la concentración y la fatiga.', 
 'https://g-se.com/la-cafeina-y-su-relacion-con-el-rendimiento-deportivo-bp-c57cfb26e6e29e', 'web', 'nutricion', TRUE, '2020-09-18'),
 ('Cómo llevar una dieta vegana equilibrada – Dietista-Nutricionista Lucía Redondo', 'Vídeo educativo que explica cómo estructurar una dieta 100% vegetal sin carencias.', 
 'https://www.youtube.com/watch?v=bAYOXIGMiDM', 'video', 'nutricion', TRUE, '2022-06-01'),
('¿Es posible ganar masa muscular siendo vegano? – Fitónica', 'Vídeo en español sobre estrategias para aumentar músculo con alimentación vegetal.', 
 'https://www.youtube.com/watch?v=iXQ1ix_XdWU', 'video', 'nutricion', TRUE, '2021-04-10'),
('Proteína vegetal vs animal – Veganismo en serio', 'Artículo detallado sobre la calidad y combinación de proteínas vegetales en dietas activas.', 
 'https://veganismo.org/2021/11/proteinas-vegetales-vs-animales/', 'web', 'nutricion', TRUE, '2021-11-05'),
('Vitamina B12 en dietas veganas – Vegan Society', 'Página oficial que explica la importancia de la suplementación con B12 y cómo tomarla correctamente.', 
 'https://www.vegansociety.com/resources/nutrition-and-health/vitamin-b12', 'web', 'nutricion', TRUE, '2023-03-20'),
('Suplementos clave en el deporte vegano – G-SE', 'Artículo técnico que analiza las necesidades especiales en deportistas veganos: B12, hierro, omega 3, creatina.', 
 'https://g-se.com/suplementos-clave-en-dietas-veganas-para-deportistas-bp-c603c0b3b53b4e', 'web', 'nutricion', TRUE, '2020-12-07'),
 ('Mindful Eating: cómo reconectar con la comida – TEDx Talks', 'Charla TEDx que explora cómo practicar la alimentación consciente para mejorar la relación con la comida.', 
 'https://www.youtube.com/watch?v=8QvWqw2sMHg', 'video', 'mentalidad', TRUE, '2019-11-13'),
('Cómo evitar comer por ansiedad – Psicóloga Miriam Al Adib', 'Vídeo que explica cómo gestionar el hambre emocional y las señales del cuerpo.', 
 'https://www.youtube.com/watch?v=x3OTOV5vP4M', 'video', 'mentalidad', TRUE, '2021-06-22'),
('Hábitos saludables y motivación – El Podcast de Cristina Mitre', 'Episodio donde se abordan los bloqueos mentales más comunes a la hora de cambiar de hábitos.', 
 'https://cristinamitre.substack.com/p/ep-200-motivacion-y-habitos', 'web', 'mentalidad', TRUE, '2022-09-25'),
('Autocompasión y alimentación – Psiquiatra Marian Rojas Estapé', 'Vídeo donde se explora la importancia de tratarse con amabilidad para mantener hábitos duraderos.', 
 'https://www.youtube.com/watch?v=8YScWkXhL8c', 'video', 'mentalidad', TRUE, '2022-02-10'),
('Cómo formar hábitos sostenibles – Fundación MAPFRE', 'Artículo con herramientas psicológicas para adoptar hábitos saludables sin frustración.', 
 'https://www.fundacionmapfre.org/salud/habitos-saludables/como-formar-habitos-saludables/', 'web', 'mentalidad', TRUE, '2023-04-03'),
 ('Ejercicio físico y salud mental – Colegio Oficial de Psicología de Madrid', 'Vídeo educativo sobre los beneficios del ejercicio para la ansiedad, la depresión y el bienestar general.', 
 'https://www.youtube.com/watch?v=Hb7cp3vW4aI', 'video', 'mentalidad', TRUE, '2022-03-15'),
('El deporte como medicina para la mente – Fundación Española del Corazón', 'Artículo que analiza cómo el deporte reduce el estrés, mejora el sueño y la autoestima.', 
 'https://fundaciondelcorazon.com/prevencion/ejercicio-fisico/2042-el-deporte-como-medicina-para-la-mente.html', 'web', 'mentalidad', TRUE, '2023-01-17'),
('Deporte y salud mental: el impacto psicológico del ejercicio – EFAD', 'Artículo técnico de la Escuela de Formación Abierta Deportiva sobre cómo influye el ejercicio en el cerebro.', 
 'https://efadeporte.com/deporte-y-salud-mental/', 'web', 'mentalidad', TRUE, '2021-10-05'),
('La importancia del ejercicio en trastornos mentales – Psicóloga Silvia Congost', 'Charla divulgativa sobre cómo el movimiento regula el estado de ánimo y combate la rumiación mental.', 
 'https://www.youtube.com/watch?v=b8_hvNFOTAc', 'video', 'mentalidad', TRUE, '2022-09-12'),
('Running y salud mental: ¿por qué correr mejora el ánimo? – Runners World España', 'Artículo que explica los mecanismos neurológicos y emocionales tras el “subidón del corredor”.', 
 'https://www.runnersworld.com/es/salud/a37185732/running-y-salud-mental/', 'web', 'mentalidad', TRUE, '2023-05-09');
 
INSERT INTO articulo (titulo, resumen, contenido, imagen_url, categoria, autor, fecha_publicacion, visible, visitas)
VALUES
(
  'Los pilares de una dieta equilibrada',
  'Descubre los principios básicos para mantener una alimentación saludable y sostenible en el tiempo.',
  'Una dieta equilibrada no se trata de contar calorías, sino de aportar al cuerpo todos los nutrientes esenciales: proteínas, grasas saludables, carbohidratos complejos, fibra, vitaminas y minerales. Incorporar variedad de alimentos, respetar las señales de hambre y saciedad, y adaptar las porciones a nuestras necesidades individuales son claves. También es importante evitar el exceso de ultraprocesados, priorizar alimentos frescos, hidratarse adecuadamente y mantener horarios estables de comida.',
  'https://ejemplo.com/imagenes/dieta-equilibrada.jpg',
  'nutricion',
  'Laura Martínez, Dietista-Nutricionista',
  '2024-04-12',
  TRUE,
  0
),
(
  '¿Qué son los ultraprocesados y cómo reducir su consumo?',
  'Aprende a identificar los alimentos ultraprocesados y por qué es recomendable limitarlos en tu dieta diaria.',
  'Los ultraprocesados son productos industriales con múltiples ingredientes, alto contenido en azúcares, grasas saturadas, aditivos y poca calidad nutricional. Algunos ejemplos comunes son bollería industrial, refrescos, snacks salados, embutidos o cereales azucarados. El consumo frecuente de estos alimentos se asocia con mayor riesgo de obesidad, enfermedades metabólicas y cardiovasculares. Para reducir su consumo, es útil planificar las comidas, cocinar más en casa y leer bien las etiquetas.',
  'https://ejemplo.com/imagenes/ultraprocesados.jpg',
  'nutricion',
  'Carlos Gómez, Nutricionista deportivo',
  '2024-05-05',
  TRUE,
  0
),
(
  'El papel de la fibra en la salud digestiva',
  'Conoce cómo la fibra alimentaria mejora tu tránsito intestinal, regula el azúcar en sangre y favorece la saciedad.',
  'La fibra es un componente vegetal no digerible que cumple múltiples funciones beneficiosas. La fibra soluble, presente en frutas, legumbres y avena, ayuda a controlar el colesterol y la glucosa. La fibra insoluble, abundante en verduras, cereales integrales y frutos secos, mejora el tránsito intestinal. Su consumo diario favorece la salud digestiva, reduce el riesgo de estreñimiento y promueve una microbiota intestinal equilibrada. Se recomienda consumir entre 25 y 30 g de fibra al día.',
  'https://ejemplo.com/imagenes/fibra-salud.jpg',
  'nutricion',
  'María López, Educadora en salud',
  '2024-06-01',
  TRUE,
  0
),
(
  'Cómo mejorar la calidad del sueño de forma natural',
  'Dormir bien es esencial para la salud física y mental. Te explicamos hábitos que favorecen un descanso reparador.',
  'La calidad del sueño impacta directamente en el sistema inmunológico, la concentración, el estado de ánimo y el metabolismo. Para mejorarla, es recomendable mantener horarios regulares, evitar el uso de pantallas antes de dormir, reducir el consumo de cafeína por la tarde, y crear un ambiente oscuro y silencioso. Técnicas como la meditación, respiración profunda o infusiones relajantes también pueden ayudar. Dormir entre 7 y 9 horas diarias es clave para el bienestar general.',
  'https://ejemplo.com/imagenes/sueno-saludable.jpg',
  'salud',
  'Sara Aguilar, Psicóloga especialista en salud',
  '2024-03-18',
  TRUE,
  0
),
(
  'Cómo fortalecer el sistema inmunológico con hábitos diarios',
  'Descubre qué factores fortalecen tus defensas y cómo mejorar tu salud inmunitaria con acciones cotidianas.',
  'El sistema inmunológico es la defensa natural del cuerpo frente a enfermedades. Para mantenerlo fuerte, es esencial llevar una alimentación rica en frutas, verduras, legumbres y frutos secos, realizar ejercicio físico moderado, dormir bien y reducir el estrés crónico. El contacto social, la exposición moderada al sol (vitamina D) y una buena hidratación también juegan un papel clave. Evitar el tabaco y el alcohol, y realizar chequeos médicos periódicos, cierra el círculo del autocuidado inmunológico.',
  'https://ejemplo.com/imagenes/sistema-inmune.jpg',
  'salud',
  'Dr. Javier Ruiz, Médico general',
  '2024-04-08',
  TRUE,
  0
),
(
  'El impacto del estrés crónico en la salud física',
  'El estrés sostenido no solo afecta la mente, también tiene consecuencias reales sobre el cuerpo.',
  'Cuando el estrés se vuelve crónico, el cuerpo permanece en estado de alerta constante, lo que puede derivar en insomnio, fatiga, hipertensión, problemas digestivos, debilitamiento del sistema inmune e incluso enfermedades cardiovasculares. Es importante aprender a identificar los síntomas del estrés sostenido y aplicar estrategias para gestionarlo: ejercicio regular, técnicas de relajación, establecer límites laborales, y buscar apoyo emocional. Cuidar la salud mental es una inversión en salud global.',
  'https://ejemplo.com/imagenes/estres-cuerpo.jpg',
  'salud',
  'Nuria Esteve, Terapeuta ocupacional',
  '2024-05-12',
  TRUE,
  0
),
(
  '3 desayunos saludables para empezar el día con energía',
  'Ideas de desayunos equilibrados, fáciles y rápidos, ideales para mantener buenos niveles de energía desde la mañana.',
  'El desayuno es una oportunidad para aportar nutrientes esenciales al cuerpo tras el ayuno nocturno. Aquí te proponemos tres opciones prácticas:\n\n1. **Tostadas de pan integral con aguacate, huevo duro y semillas de chía.** Aporta grasas saludables, proteína y fibra.\n\n2. **Yogur griego natural con frambuesas, copos de avena y nueces.** Ideal para cuidar la microbiota y obtener energía sostenida.\n\n3. **Batido vegetal con plátano, espinacas, bebida de almendras y proteína en polvo.** Muy saciante y completo para quien entrena por la mañana.',
  'https://ejemplo.com/imagenes/desayunos-saludables.jpg',
  'recetas',
  'Clara Soler, Técnica en Dietética',
  '2024-03-02',
  TRUE,
  0
),
(
  'Ideas de cenas ligeras y nutritivas para dormir mejor',
  'Comer bien por la noche puede ayudarte a descansar mejor. Estas recetas son saciantes pero suaves para la digestión.',
  'Las cenas copiosas dificultan el descanso. Aquí van tres ideas ligeras:\n\n1. **Crema de calabacín con picatostes integrales y huevo poché.** Rica en fibra y proteína, ideal para reconfortar el estómago.\n\n2. **Salteado de tofu con verduras y salsa de soja baja en sal.** Aporte vegetal con buena cantidad de proteína.\n\n3. **Tortilla francesa con espinacas y ensalada de tomate cherry.** Fácil, rápida y equilibrada.\n\nLo ideal es cenar al menos 2 horas antes de irse a la cama para favorecer la digestión.',
  'https://ejemplo.com/imagenes/cenas-nutritivas.jpg',
  'recetas',
  'Lucía Castaño, Coach en nutrición consciente',
  '2024-04-20',
  TRUE,
  0
),
(
  'Snacks saludables para media mañana o tarde',
  'Evita los ultraprocesados y opta por estos snacks caseros ricos en fibra, vitaminas y energía.',
  'Comer entre horas no tiene por qué ser insano. Aquí tienes opciones de snacks saludables:\n\n- **Hummus con palitos de zanahoria y pepino.** Fuente vegetal de proteína y fibra.\n- **Bol de fruta fresca con semillas de lino.** Ideal para aportar energía y micronutrientes.\n- **Tostadas de maíz con crema de cacahuete 100% natural.** Perfecto para media mañana o merienda tras entrenar.\n- **Puñado de frutos secos naturales (nueces, almendras, anacardos).** Rico en grasas saludables y saciante.\n\nElegir snacks reales te ayuda a mantener un patrón saludable sin restricciones.',
  'https://ejemplo.com/imagenes/snacks-saludables.jpg',
  'recetas',
  'Andrés Romero, Educador nutricional',
  '2024-05-30',
  TRUE,
  0
),
(
  '¿Cuánto ejercicio necesitas a la semana para estar saludable?',
  'Descubre las recomendaciones oficiales de actividad física y cómo adaptarlas a tu estilo de vida.',
  'La Organización Mundial de la Salud recomienda un mínimo de 150 minutos semanales de actividad aeróbica moderada o 75 minutos intensa, combinados con ejercicios de fuerza al menos 2 días a la semana. Esto incluye caminar rápido, nadar, bailar, correr, hacer pesas o yoga. Si llevas una vida sedentaria, puedes empezar con 10-15 minutos diarios e ir aumentando progresivamente. Lo importante no es hacer mucho de golpe, sino crear un hábito sostenible.',
  'https://ejemplo.com/imagenes/actividad-fisica.jpg',
  'deporte',
  'Sonia Navarro, Licenciada en Ciencias del Deporte',
  '2024-04-01',
  TRUE,
  0
),
(
  'Entrenamiento de fuerza: beneficios más allá de los músculos',
  'Hacer pesas o ejercicios con el propio peso no es solo para quienes quieren ganar volumen. Tiene múltiples beneficios.',
  'El entrenamiento de fuerza mejora la masa muscular, la densidad ósea, el metabolismo y la salud cardiovascular. Además, es clave para prevenir lesiones, mantener una buena postura y retrasar el envejecimiento físico. No hace falta ir al gimnasio: ejercicios como sentadillas, flexiones, planchas o subir escaleras también cuentan. Incluir al menos 2 sesiones semanales puede marcar una gran diferencia en tu salud a largo plazo.',
  'https://ejemplo.com/imagenes/fuerza-beneficios.jpg',
  'deporte',
  'Iván Torres, Preparador físico',
  '2024-04-18',
  TRUE,
  0
),
(
  'Cómo empezar a correr sin lesionarte: guía para principiantes',
  'Si estás pensando en empezar a correr, esta guía te ayudará a hacerlo de forma segura y efectiva.',
  'Correr es una forma excelente de mejorar la salud cardiovascular, liberar estrés y aumentar la resistencia. Pero empezar demasiado rápido o sin técnica puede provocar lesiones. Para iniciarte correctamente, comienza con caminatas rápidas alternadas con pequeños tramos de trote. Usa calzado adecuado, evita superficies muy duras, y escucha a tu cuerpo. Lo ideal es seguir un plan progresivo como el "Couch to 5K" y mantener la constancia más allá de la motivación inicial.',
  'https://ejemplo.com/imagenes/empezar-a-correr.jpg',
  'deporte',
  'Nerea Vidal, Entrenadora personal',
  '2024-05-07',
  TRUE,
  0
),
(
  '¿Qué es la huella ecológica y cómo reducirla desde tu cocina?',
  'La forma en que comemos impacta en el medio ambiente. Aprende cómo minimizar tu huella ecológica desde casa.',
  'La huella ecológica mide el impacto ambiental de nuestras acciones. En la alimentación, esta huella se refleja en la cantidad de recursos utilizados para producir, transportar y desechar los alimentos. Reducir el consumo de carne, optar por productos locales y de temporada, evitar el desperdicio alimentario y elegir envases reutilizables son pasos clave. Cocinar con planificación, congelar sobras y apoyar mercados de proximidad también ayuda a construir un sistema alimentario más sostenible.',
  'https://ejemplo.com/imagenes/huella-ecologica-cocina.jpg',
  'otro',
  'Helena Puig, Ambientalista y divulgadora',
  '2024-03-10',
  TRUE,
  0
),
(
  'La importancia del descanso en el bienestar integral',
  'Descansar bien no solo es dormir. Te explicamos por qué el descanso físico, mental y emocional es clave para tu salud.',
  'El descanso integral va más allá del sueño. También incluye momentos de desconexión mental, pausas activas, tiempo libre sin pantallas y espacios de autocuidado. En un mundo acelerado, no descansar correctamente puede afectar la concentración, el estado de ánimo y la salud física. Incorporar microdescansos durante el día, priorizar actividades recreativas, y respetar los ritmos circadianos mejora significativamente la calidad de vida.',
  'https://ejemplo.com/imagenes/descanso-bienestar.jpg',
  'otro',
  'Martina Rey, Psicóloga holística',
  '2024-04-15',
  TRUE,
  0
),
(
  'Cómo construir hábitos duraderos: más allá de la motivación',
  'El cambio real no viene de la fuerza de voluntad, sino de construir sistemas sostenibles. Aprende a formar hábitos.',
  'Muchos inician cambios con entusiasmo pero abandonan al poco tiempo. La clave está en transformar pequeñas acciones en rutinas diarias. Empezar poco a poco, usar recordatorios visuales, crear contextos favorables y recompensar el progreso ayuda a consolidar nuevos hábitos. Además, es importante aceptar retrocesos como parte del proceso y centrarse en la constancia más que en la perfección. No necesitas motivación constante, necesitas estructura y compromiso amable contigo mismo.',
  'https://ejemplo.com/imagenes/habitos-duraderos.jpg',
  'otro',
  'Raúl Estrada, Coach de hábitos',
  '2024-05-26',
  TRUE,
  0
);

INSERT INTO comida_modelo (
    nombre, tipo_comida, calorias_totales,
    apta_diabetes, apta_hipertension, apta_hipercolesterolemia, apta_celiacos, apta_renal,
    apta_anemia, apta_obesidad, apta_hipotiroidismo, apta_colon_irritable,
    sin_lactosa, sin_frutos_secos, sin_marisco, sin_pescado_azul,
    sin_huevo, sin_soja, sin_legumbres, sin_sesamo
) VALUES
-- Desayuno 1: Avena con bebida de almendra, plátano y semillas de chía
('Avena con bebida de almendra, plátano y semillas de chía', 'desayuno', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),

-- Desayuno 2: Pan sin gluten con hummus y tomate cherry
('Pan sin gluten con hummus y tomate cherry', 'desayuno', 300,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, FALSE),

-- Desayuno 3: Yogur vegetal con frambuesas y semillas de lino
('Yogur vegetal con frambuesas y semillas de lino', 'desayuno', 250,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, FALSE),
 -- Desayuno 4: Tostadas de arroz con aguacate y huevo duro
('Tostadas de arroz con aguacate y huevo duro', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),

-- Desayuno 5: Smoothie de bebida vegetal con fresa y kiwi
('Smoothie de bebida vegetal con fresa y kiwi', 'desayuno', 220,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

-- Desayuno 6: Galletas sin gluten con compota de manzana e infusión
('Galletas sin gluten con compota de manzana e infusión', 'desayuno', 280,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

-- Desayuno 7: Yogur vegetal con plátano y nuez moscada
('Yogur vegetal con plátano y nuez moscada', 'desayuno', 260,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

-- Desayuno 8: Tostadas sin gluten con aceite de oliva y tomate triturado
('Tostadas sin gluten con aceite de oliva y tomate triturado', 'desayuno', 300,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

 -- Desayuno 9: Smoothie de plátano, bebida de coco y avena sin gluten
('Smoothie de plátano, bebida de coco y avena sin gluten', 'desayuno', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

-- Desayuno 10: Tostadas de maíz con aguacate y tomate
('Tostadas de maíz con aguacate y tomate', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

-- Desayuno 11: Galletas sin lactosa con compota de pera
('Galletas sin lactosa con compota de pera', 'desayuno', 280,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

-- Desayuno 12: Yogur vegetal de soja con arándanos y avena sin gluten
('Yogur vegetal de soja con arándanos y avena sin gluten', 'desayuno', 290,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),

-- Desayuno 13: Tostadas de arroz con crema de almendras y plátano
('Tostadas de arroz con crema de almendras y plátano', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),

 -- Diabetes tipo 2: Tostadas de centeno integral con aguacate y tomate
('Tostadas de centeno integral con aguacate y tomate', 'desayuno', 300,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Hipertensión: Avena cocida en agua con manzana y canela
('Avena cocida en agua con manzana y canela', 'desayuno', 270,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Hipercolesterolemia: Smoothie de frutos rojos y bebida de avena
('Smoothie de frutos rojos y bebida de avena', 'desayuno', 250,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Enfermedad celíaca: Pan sin gluten con hummus y pepino
('Pan sin gluten con hummus y pepino', 'desayuno', 310,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, FALSE, FALSE),

-- Insuficiencia renal: Tostadas de arroz con mermelada sin azúcar
('Tostadas de arroz con mermelada sin azúcar', 'desayuno', 260,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Anemia: Avena cocida con bebida de almendra y fresas
('Avena con bebida de almendra y fresas', 'desayuno', 290,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Obesidad: Yogur vegetal sin azúcar con kiwi y semillas de lino
('Yogur vegetal sin azúcar con kiwi y semillas de lino', 'desayuno', 230,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Hipotiroidismo: Pan integral con aguacate y tomate triturado
('Pan integral con aguacate y tomate triturado', 'desayuno', 320,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Colon irritable (SII): Tortilla de calabacín con tostadas de arroz
('Tortilla de calabacín con tostadas de arroz', 'desayuno', 310,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- Alergia a frutos secos: Yogur vegetal con mango y avena
('Yogur vegetal con mango y avena', 'desayuno', 280,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Alergia al marisco: Pan integral con aguacate y semillas de lino
('Pan integral con aguacate y semillas de lino', 'desayuno', 310,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Alergia a pescado azul: Smoothie de plátano con bebida de avena
('Smoothie de plátano con bebida de avena', 'desayuno', 240,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Alergia al huevo: Galletas sin huevo con compota de manzana
('Galletas sin huevo con compota de manzana', 'desayuno', 290,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- Alergia a la soja: Tostadas de arroz con aceite de oliva y tomate
('Tostadas de arroz con aceite de oliva y tomate', 'desayuno', 300,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 28. Diabetes tipo 2
('1 manzana + puñado de nueces', 'almuerzo', 200,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 29. Hipertensión
('1 plátano + tostadas de arroz', 'almuerzo', 220,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 30. Hipercolesterolemia
('Yogur vegetal + semillas de chía', 'almuerzo', 180,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE),

-- 31. Celiaquía
('Pan sin gluten con hummus', 'almuerzo', 240,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, FALSE, FALSE),

-- 32. Insuficiencia renal
('1 pera + bebida vegetal de arroz', 'almuerzo', 190,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 33. Anemia
('Zumo de naranja natural + puñado de almendras', 'almuerzo', 210,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 34. Obesidad
('1 kiwi + yogur vegetal sin azúcar', 'almuerzo', 170,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 35. Intolerancia a la lactosa
('Smoothie vegetal con fruta', 'almuerzo', 200,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 36. Hipotiroidismo
('Tostadas integrales con aguacate', 'almuerzo', 230,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 37. Colon irritable
('1 plátano + yogur vegetal sin FODMAP', 'almuerzo', 210,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 38. Alergia a frutos secos
('1 mandarina + pan integral', 'almuerzo', 190,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 39. Alergia al marisco
('1 manzana + yogur vegetal', 'almuerzo', 180,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 40. Alergia a pescado azul
('Smoothie vegetal con fresas', 'almuerzo', 200,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 41. Alergia al huevo
('1 manzana + tostadas sin huevo', 'almuerzo', 190,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 42. Alergia a la soja
('1 plátano + pan integral', 'almuerzo', 210,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 43. Diabetes tipo 2
('Arroz integral con pisto y huevo a la plancha', 'comida', 520,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 44. Hipertensión
('Pollo hervido con patata y judías verdes', 'comida', 500,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 45. Hipercolesterolemia
('Lentejas estofadas con zanahoria y espinacas', 'comida', 530,
TRUE, TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 46. Celiaquía
('Pasta sin gluten con brócoli y atún', 'comida', 510,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 47. Insuficiencia renal
('Arroz blanco con tortilla francesa y calabacín hervido', 'comida', 480,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 48. Anemia
('Ternera con quinoa, pimiento rojo y espinacas', 'comida', 550,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 49. Obesidad
('Crema de calabacín con huevo duro y ensalada verde', 'comida', 470,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 50. Intolerancia a la lactosa
('Arroz salteado con tofu y verduras', 'comida', 500,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 51. Hipotiroidismo
('Pollo al horno con calabaza asada y arroz integral', 'comida', 520,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 52. Colon irritable
('Merluza a la plancha con arroz y zanahoria hervida', 'comida', 510,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 53. Alergia a frutos secos
('Tortilla de patata con pisto y ensalada', 'comida', 530,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 54. Alergia al marisco
('Arroz con pollo al curry suave y calabacín', 'comida', 500,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 55. Alergia a pescado azul
('Quinoa con verduras asadas y huevo cocido', 'comida', 490,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 56. Alergia al huevo
('Macarrones integrales con tomate natural y tofu', 'comida', 510,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 57. Alergia a la soja
('Arroz integral con pollo y espinacas', 'comida', 520,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE);


INSERT INTO comida_ingrediente (comida_modelo_id, ingrediente_id, cantidad, unidad) VALUES
(1, 127, 40, 'g'),    -- avena en copos
(1, 171, 200, 'ml'),  -- bebida de almendra
(1, 37, 120, 'g'),-- plátano
(1, 227, 10, 'g'),    -- semillas de chía
(2, 154, 60, 'g'),    -- pan sin gluten
(2, 257, 40, 'g'),    -- hummus
(2, 258, 50, 'g'),    -- tomate cherry
(3, 259, 125, 'g'),   -- yogur vegetal
(3, 56, 50, 'g'),    -- frambuesas
(3, 228, 10, 'g'),   -- semillas de lino
-- Desayuno 4
(4, 260, 30, 'g'),   -- tostadas de arroz
(4, 261, 50, 'g'),    -- aguacate
(4, 43, 60, 'g'),-- huevo duro

-- Desayuno 5
(5, 171, 200, 'ml'), -- bebida de almendra
(5, 43, 60, 'g'),    -- fresa
(5, 44, 75, 'g'),-- kiwi

-- Desayuno 6
(6, 263, 40, 'g'),   -- galletas sin gluten
(6, 264, 60, 'g'),   -- compota de manzana
(6, 173, 200, 'ml'), -- infusión

-- Desayuno 7
(7, 259, 125, 'g'),  -- yogur vegetal
(7, 37, 120, 'g'),-- plátano
(7, 156, 1, 'g'),    -- nuez moscada

-- Desayuno 8
(8, 154, 60, 'g'),   -- pan sin gluten
(8, 242, 10, 'ml'),  -- aceite de oliva
(8, 265, 50, 'g'),    -- tomate triturado

-- Desayuno 9
(9, 37, 120, 'g'),    -- plátano
(9, 266, 200, 'ml'),     -- bebida vegetal de coco
(9, 267, 30, 'g'),       -- avena sin gluten

-- Desayuno 10
(10, 268, 30, 'g'),  -- tostadas de maíz
(10, 261, 50, 'g'),       -- aguacate
(10, 265, 50, 'g'),       -- tomate triturado

-- Desayuno 11
(11, 269, 40, 'g'),      -- galletas sin lactosa
(11, 270, 60, 'g'),      -- compota de pera

-- Desayuno 12
(12, 259, 125, 'g'),     -- yogur vegetal de soja
(12, 57, 40, 'g'),       -- arándanos
(12, 267, 30, 'g'),      -- avena sin gluten

-- Desayuno 13
(13, 271, 30, 'g'),      -- tostadas de arroz
(13, 272, 15, 'g'),      -- crema de almendras
(13, 37, 120, 'g'),   -- plátano

-- Desayuno 14: Diabetes tipo 2
(14, 273, 60, 'g'),    -- pan_centeno
(14, 261, 50, 'g'),     -- aguacate
(14, 7, 50, 'g'),     -- tomate

-- Desayuno 15: Hipertensión
(15, 127, 40, 'g'),    -- avena
(15, 36, 150, 'g'), -- manzana
(15, 248, 1, 'g'),     -- canela

-- Desayuno 16: Hipercolesterolemia
(16, 274, 80, 'g'),    -- frutos_rojos
(16, 177, 200, 'ml'),  -- bebida_avena

-- Desayuno 17: Celiaquía
(17, 154, 60, 'g'),    -- pan sin gluten
(17, 257, 40, 'g'),    -- hummus
(17, 25, 50, 'g'),    -- pepino

-- Desayuno 18: Insuficiencia renal
(18, 271, 30, 'g'),    -- tostadas de arroz
(18, 275, 20, 'g'),    -- mermelada sin azúcar

-- Desayuno 19: Anemia
(19, 127, 40, 'g'),    -- avena
(19, 171, 200, 'ml'),  -- bebida de almendra
(19, 43, 50, 'g'),     -- fresas

-- Desayuno 20: Obesidad
(20, 259, 125, 'g'),   -- yogur vegetal
(20, 44, 75, 'g'), -- kiwi
(20, 228, 10, 'g'),    -- semillas de lino

-- Desayuno 21: Hipotiroidismo
(21, 130, 60, 'g'),    -- pan integral
(21, 261, 50, 'g'),     -- aguacate
(21, 265, 50, 'g'),    -- tomate triturado

-- Desayuno 22: Colon irritable (SII)
(22, 4, 60, 'g'),    -- calabacín
(22, 276, 60, 'g'), -- huevo
(22, 260, 30, 'g'),    -- tostadas de arroz

-- Desayuno 23: Alergia a frutos secos
(23, 259, 125, 'g'),   -- yogur vegetal
(23, 47, 50, 'g'),    -- mango
(23, 127, 30, 'g'),    -- avena

-- Desayuno 24: Alergia al marisco
(24, 130, 60, 'g'),    -- pan integral
(24, 261, 40, 'g'),     -- aguacate
(24, 228, 10, 'g'),    -- semillas de lino

-- Desayuno 25: Alergia a pescado azul
(25, 37, 120, 'g'), -- plátano
(25, 177, 200, 'ml'),  -- bebida de avena

-- Desayuno 26: Alergia al huevo
(26, 277, 40, 'g'),    -- galletas sin huevo
(26, 264, 60, 'g'),    -- compota de manzana

-- Desayuno 27: Alergia a la soja
(27, 271, 30, 'g'),    -- tostadas de arroz
(27, 242, 10, 'ml'),   -- aceite de oliva
(27, 7, 50, 'g'),    -- tomate

-- 28. Diabetes tipo 2
(28, 36, 150, 'g'),       -- manzana
(28, 156, 15, 'g'),          -- nueces

-- 29. Hipertensión
(29, 37, 120, 'g'),       -- plátano
(29, 271, 30, 'g'),          -- tostadas de arroz

-- 30. Hipercolesterolemia
(30, 259, 125, 'g'),         -- yogur vegetal
(30, 227, 10, 'g'),          -- semillas de chía

-- 31. Celiaquía
(31, 154, 60, 'g'),          -- pan sin gluten
(31, 257, 40, 'g'),          -- hummus

-- 32. Insuficiencia renal
(32, 39, 160, 'g'),       -- pera
(32, 178, 200, 'ml'),        -- bebida vegetal de arroz

-- 33. Anemia
(33, 166, 200, 'ml'),        -- zumo de naranja natural
(33, 155, 15, 'g'),          -- almendras

-- 34. Obesidad
(34, 44, 75, 'g'),       -- kiwi
(34, 259, 125, 'g'),         -- yogur vegetal sin azúcar

-- 35. Intolerancia a la lactosa
(35, 171, 150, 'ml'),        -- bebida de almendra
(35, 37, 120, 'g'),       -- plátano
(35, 44, 75, 'g'),       -- kiwi

-- 36. Hipotiroidismo
(36, 278, 30, 'g'),          -- tostadas integrales
(36, 261, 50, 'g'),           -- aguacate

-- 37. Colon irritable
(37, 37, 120, 'g'),       -- plátano
(37, 259, 125, 'g'),         -- yogur vegetal sin FODMAP

-- 38. Alergia a frutos secos
(38, 74, 120, 'g'),      -- mandarina
(38, 130, 40, 'g'),          -- pan integral

-- 39. Alergia al marisco
(39, 36, 150, 'g'),       -- manzana
(39, 259, 125, 'g'),         -- yogur vegetal

-- 40. Alergia a pescado azul
(40, 177, 150, 'ml'),        -- bebida de avena
(40, 44, 80, 'g'),         -- fresas

-- 41. Alergia al huevo
(41, 36, 150, 'g'),       -- manzana
(41, 279, 30, 'g'),          -- tostadas sin huevo

-- 42. Alergia a la soja
(42, 37, 120, 'g'),       -- plátano
(42, 130, 40, 'g');          -- pan integral

INSERT INTO comida_modelo (
    nombre, tipo_comida, calorias_totales,
    apta_diabetes, apta_hipertension, apta_hipercolesterolemia, apta_celiacos, apta_renal,
    apta_anemia, apta_obesidad, apta_hipotiroidismo, apta_colon_irritable,
    sin_lactosa, sin_frutos_secos, sin_marisco, sin_pescado_azul,
    sin_huevo, sin_soja, sin_legumbres, sin_sesamo
) VALUES
-- 58. Diabetes tipo 2
('Yogur vegetal con plátano en rodajas', 'merienda', 180,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 59. Hipertensión
('Batido de fresa con bebida de avena', 'merienda', 170,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 60. Hipercolesterolemia
('Tostadas de arroz con aguacate', 'merienda', 200,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 61. Celiaquía
('Galletas sin gluten con compota de manzana', 'merienda', 190,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 62. Insuficiencia renal
('1 plátano con bebida vegetal de arroz', 'merienda', 160,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 63. Anemia
('Zumo de naranja + pan integral con espinacas', 'merienda', 220,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 64. Obesidad
('Yogur vegetal sin azúcar + kiwi', 'merienda', 170,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 65. Intolerancia a la lactosa
('Smoothie vegetal de fresa y plátano', 'merienda', 180,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 66. Hipotiroidismo
('Tostadas integrales con aguacate y tomate', 'merienda', 210,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 67. Colon irritable
('Yogur vegetal sin FODMAP con arándanos', 'merienda', 180,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 68. Alergia a frutos secos
('Batido de frutas con pan integral', 'merienda', 200,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 69. Alergia al marisco
('Pan integral con aguacate y plátano', 'merienda', 220,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 70. Alergia a pescado azul
('Smoothie de fresa y bebida vegetal de avena', 'merienda', 180,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 71. Alergia al huevo
('Galletas sin huevo con compota de pera', 'merienda', 190,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 72. Alergia a la soja
('Tostadas de arroz con plátano y crema de girasol', 'merienda', 210,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 73. Diabetes tipo 2
('Crema de calabacín + huevo duro + tostadas integrales', 'cena', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 74. Hipertensión
('Pescado blanco con patata hervida y zanahoria', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 75. Hipercolesterolemia
('Verduras al vapor + tortilla francesa + pan integral', 'cena', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 76. Celiaquía
('Pasta sin gluten con tomate natural y calabacín', 'cena', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 77. Insuficiencia renal
('Arroz blanco + tortilla francesa + calabacín hervido', 'cena', 380,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 78. Anemia
('Revuelto de espinacas y huevo + pan integral', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 79. Obesidad
('Sopa de verduras + yogur vegetal sin azúcar', 'cena', 360,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 80. Intolerancia a la lactosa
('Tofu a la plancha con verduras y arroz integral', 'cena', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 81. Hipotiroidismo
('Pollo a la plancha + puré de calabaza', 'cena', 430,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 82. Colon irritable
('Merluza al vapor con zanahoria y arroz blanco', 'cena', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 83. Alergia a frutos secos
('Huevos revueltos + patata hervida + ensalada verde', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 84. Alergia al marisco
('Pollo al curry suave + arroz + calabacín al horno', 'cena', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 85. Alergia a pescado azul
('Tortilla francesa + verduras salteadas + pan integral', 'cena', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 86. Alergia al huevo
('Pasta integral con tomate natural y tofu', 'cena', 430,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 87. Alergia a la soja
('Crema de verduras + pan integral + plátano', 'cena', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE);


INSERT INTO comida_ingrediente (comida_modelo_id, ingrediente_id, cantidad, unidad) VALUES
-- 43. Diabetes tipo 2
(43, 146, 60, 'g'),    -- arroz_integral
(43, 280, 100, 'g'),   -- pisto
 (43, 276, 60, 'g'), -- huevo

-- 44. Hipertensión
(44, 281, 100, 'g'),   -- pollo
(44, 282, 120, 'g'),   -- patata
(44, 24, 100, 'g'),   -- judías verdes

-- 45. Hipercolesterolemia
(45, 96, 60, 'g'),    -- lentejas
(45, 3, 50, 'g'),     -- zanahoria
(45, 1, 50, 'g'),      -- espinacas

-- 46. Celiaquía
(46, 283, 70, 'g'),    -- pasta sin gluten
(46, 8, 60, 'g'),    -- brócoli
(46, 118, 80, 'g'),    -- atún

-- 47. Insuficiencia renal
(47, 145, 60, 'g'),    -- arroz blanco
(47, 276, 60, 'g'),-- tortilla francesa
(47, 4, 80, 'g'),     -- calabacín

-- 48. Anemia
(48, 197, 100, 'g'),   -- ternera
(48, 149, 60, 'g'),    -- quinoa
(48, 6, 50, 'g'),    -- pimiento rojo
(48, 1, 40, 'g'),      -- espinacas

-- 49. Obesidad
(49, 4, 100, 'g'),    -- calabacín
 (49, 276, 60, 'g'), -- huevo
(49, 284, 50, 'g'),    -- ensalada verde

-- 50. Intolerancia a la lactosa
(50, 146, 60, 'g'),    -- arroz integral
(50, 285, 80, 'g'),    -- tofu
(50, 286, 100, 'g'),   -- verduras salteadas

-- 51. Hipotiroidismo
(51, 281, 100, 'g'),   -- pollo
(51, 287, 80, 'g'),    -- calabaza
(51, 146, 60, 'g'),    -- arroz integral

-- 52. Colon irritable
(52, 116, 100, 'g'),   -- merluza
(52, 145, 60, 'g'),    -- arroz blanco
(52, 3, 50, 'g'),     -- zanahoria

-- 53. Alergia a frutos secos
(53, 282, 100, 'g'),   -- patata
 (53, 276, 120, 'g'), -- huevo
(53, 280, 80, 'g'),    -- pisto
(53, 284, 50, 'g'),    -- ensalada verde

-- 54. Alergia al marisco
(54, 145, 60, 'g'),    -- arroz blanco
(54, 281, 100, 'g'),   -- pollo
(54, 250, 5, 'g'),     -- curry suave
(54, 4, 60, 'g'),     -- calabacín

-- 55. Alergia a pescado azul
(55, 149, 60, 'g'),    -- quinoa
(55, 288, 100, 'g'),   -- verduras asadas
 (55, 276, 60, 'g'), -- huevo

-- 56. Alergia al huevo
(56, 289, 70, 'g'),    -- macarrones integrales
(56, 265, 60, 'g'),    -- tomate natural
(56, 285, 80, 'g'),    -- tofu

-- 57. Alergia a la soja
(57, 146, 60, 'g'),    -- arroz integral
(57, 281, 100, 'g'),   -- pollo
(57, 1, 60, 'g'),   -- espinacas

-- 58. Diabetes tipo 2
(58, 259, 125, 'g'),       -- yogur vegetal
(59, 37, 120, 'g'),     -- plátano

-- 59. Hipertensión
(59, 43, 60, 'g'),         -- fresa
(59, 177, 150, 'ml'),      -- bebida de avena

-- 60. Hipercolesterolemia
(60, 260, 30, 'g'),        -- tostadas de arroz
(60, 261, 40, 'g'),         -- aguacate

-- 61. Celiaquía
(61, 263, 40, 'g'),        -- galletas sin gluten
(61, 264, 60, 'g'),        -- compota de manzana

-- 62. Insuficiencia renal
(62, 37, 120, 'g'),     -- plátano
(62, 178, 150, 'ml'),      -- bebida vegetal de arroz

-- 63. Anemia
(63, 166, 200, 'ml'),      -- zumo de naranja
(63, 130, 30, 'g'),        -- pan integral
(63, 1, 20, 'g'),          -- espinacas

-- 64. Obesidad
(64, 259, 125, 'g'),       -- yogur vegetal sin azúcar
(64, 44, 75, 'g'),     -- kiwi

-- 65. Intolerancia a la lactosa
(65, 43, 50, 'g'),         -- fresa
(65, 37, 120, 'g'),     -- plátano
(65, 177, 150, 'ml'),      -- bebida de avena

-- 66. Hipotiroidismo
(66, 278, 30, 'g'),        -- tostadas integrales
(66, 261, 40, 'g'),         -- aguacate
(66, 7, 30, 'g'),         -- tomate

-- 67. Colon irritable
(67, 259, 125, 'g'),       -- yogur vegetal sin FODMAP
(67, 57, 40, 'g'),         -- arándanos

-- 68. Alergia a frutos secos
(68, 37, 120, 'g'),     -- plátano
(68, 43, 50, 'g'),         -- fresa
(68, 178, 150, 'ml'),      -- bebida vegetal de arroz
(68, 130, 30, 'g'),      -- pan integral

-- 69. Alergia al marisco
(69, 130, 30, 'g'),        -- pan integral
(69, 261, 30, 'g'),         -- aguacate
(69, 37, 120, 'g'),     -- plátano

-- 70. Alergia a pescado azul
(70, 43, 60, 'g'),         -- fresa
(70, 177, 150, 'ml'),      -- bebida de avena

-- 71. Alergia al huevo
(71, 263, 40, 'g'),        -- galletas sin huevo
(71, 264, 60, 'g'),        -- compota de pera

-- 72. Alergia a la soja
(72, 271, 30, 'g'),        -- tostadas de arroz
(72, 37, 120, 'g'),     -- plátano
(72, 290, 15, 'g'),       -- crema de girasol

-- 73. Diabetes tipo 2
(73, 4, 100, 'g'),        -- calabacín
 (73, 276, 60, 'g'),     -- huevo
(73, 278, 30, 'g'),        -- tostadas integrales

-- 74. Hipertensión
(74, 291, 100, 'g'),       -- pescado blanco
(74, 282, 120, 'g'),       -- patata
(74, 3, 50, 'g'),         -- zanahoria

-- 75. Hipercolesterolemia
(75, 292, 120, 'g'),       -- verduras al vapor
(75, 276, 60, 'g'),    -- tortilla francesa
(75, 130, 30, 'g'),        -- pan integral

-- 76. Celiaquía
(76, 283, 70, 'g'),        -- pasta sin gluten
(76, 265, 60, 'g'),        -- tomate natural
(76, 4, 60, 'g'),         -- calabacín

-- 77. Insuficiencia renal
(77, 145, 60, 'g'),        -- arroz blanco
(77, 276, 60, 'g'),    -- tortilla francesa
(77, 4, 60, 'g'),         -- calabacín

-- 78. Anemia
(78, 1, 80, 'g'),          -- espinacas
 (78, 276, 60, 'g'),     -- huevo
(78, 130, 30, 'g'),        -- pan integral

-- 79. Obesidad
(79, 3, 60, 'g'),         -- zanahoria  
(79, 14, 40, 'g'),        -- puerro  
(79, 4, 50, 'g'),         -- calabacín  
(79, 265, 50, 'g'),        -- tomate natural  
(79, 259, 125, 'g'),        -- yogur vegetal sin azúcar  

-- 80. Intolerancia a la lactosa
(80, 285, 100, 'g'),       -- tofu
(80, 286, 100, 'g'),       -- verduras salteadas
(80, 146, 60, 'g'),        -- arroz integral

-- 81. Hipotiroidismo
(81, 281, 100, 'g'),       -- pollo
(81, 287, 150, 'g'),       -- puré de calabaza

-- 82. Colon irritable
(82, 116, 100, 'g'),       -- merluza
(82, 3, 50, 'g'),         -- zanahoria
(82, 145, 60, 'g'),        -- arroz blanco

-- 83. Alergia a frutos secos
 (83, 276, 60, 'g'),     -- huevo
(83, 282, 100, 'g'),       -- patata
(83, 284, 50, 'g'),        -- ensalada verde

-- 84. Alergia al marisco
(84, 281, 100, 'g'),       -- pollo
(84, 250, 5, 'g'),         -- curry suave
(84, 145, 60, 'g'),        -- arroz blanco
(84, 4, 60, 'g'),         -- calabacín

-- 85. Alergia a pescado azul
(85, 276, 60, 'g'),    -- tortilla francesa
(85, 286, 100, 'g'),       -- verduras salteadas
(85, 130, 30, 'g'),        -- pan integral

-- 86. Alergia al huevo
(86, 289, 70, 'g'),        -- pasta integral
(86, 265, 60, 'g'),        -- tomate natural
(86, 285, 80, 'g'),        -- tofu

-- 87. Alergia a la soja
(87, 8, 60, 'g'),        -- brócoli  
(87, 3, 60, 'g'),         -- zanahoria  
(87, 287, 80, 'g'),        -- calabaza  
(87, 130, 30, 'g'),        -- pan integral  
(87, 37, 1, 'unidad')      -- plátano

INSERT INTO comida_modelo (
    nombre, tipo_comida, calorias_totales,
    apta_diabetes, apta_hipertension, apta_hipercolesterolemia, apta_celiacos, apta_renal,
    apta_anemia, apta_obesidad, apta_hipotiroidismo, apta_colon_irritable,
    sin_lactosa, sin_frutos_secos, sin_marisco, sin_pescado_azul,
    sin_huevo, sin_soja, sin_legumbres, sin_sesamo
) VALUES
-- 88. Ensalada de quinoa y garbanzos
('Ensalada de quinoa y garbanzos', 'comida', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, FALSE, TRUE),

-- 89. Crema de calabaza con pan de centeno
('Crema de calabaza con pan de centeno', 'cena', 350,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 90. Desayuno de yogur vegetal con frutas rojas
('Desayuno de yogur vegetal con frutas rojas', 'desayuno', 310,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 91. Hamburguesa vegetal con ensalada verde
('Hamburguesa vegetal con ensalada verde', 'comida', 430,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, FALSE, FALSE, TRUE),

-- 92. Tofu con verduras al vapor y arroz integral
('Tofu con verduras al vapor y arroz integral', 'cena', 440,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 93. Bowl de lentejas beluga con espinacas
('Bowl de lentejas beluga con espinacas', 'comida', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 94. Pan sin gluten con aguacate y tomate
('Pan sin gluten con aguacate y tomate', 'desayuno', 360,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 95. Merluza al horno con puré de patata
('Merluza al horno con puré de patata', 'cena', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 96. Batido vegetal con avena y plátano
('Batido vegetal con avena y plátano', 'desayuno', 330,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 97. Espaguetis integrales con verduras salteadas
('Espaguetis integrales con verduras salteadas', 'comida', 450,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

 -- 98. Bowl de arroz integral con verduras y huevo
('Bowl de arroz integral con verduras y huevo', 'comida', 440,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 99. Pasta sin gluten con hummus y tomate cherry
('Pasta sin gluten con hummus y tomate cherry', 'cena', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 100. Tostadas de maíz con aguacate y kiwi
('Tostadas de maíz con aguacate y kiwi', 'desayuno', 360,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 101. Crema de zanahoria y lentejas rojas
('Crema de zanahoria y lentejas rojas', 'comida', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 102. Revuelto de tofu con verduras
('Revuelto de tofu con verduras', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 103. Pan integral con tomate y aceite de oliva
('Pan integral con tomate y aceite de oliva', 'desayuno', 370,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 104. Curry de garbanzos y arroz
('Curry de garbanzos y arroz', 'comida', 450,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 105. Sopa de verduras con huevo duro
('Sopa de verduras con huevo duro', 'cena', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 106. Smoothie de frutas con bebida vegetal de coco
('Smoothie de frutas con bebida vegetal de coco', 'desayuno', 330,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 107. Hamburguesa de lentejas y ensalada verde
('Hamburguesa de lentejas y ensalada verde', 'comida', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, FALSE, TRUE),

-- 108. Tacos de tofu con verduras y maíz
('Tacos de tofu con verduras y maíz', 'comida', 430,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 109. Galletas sin gluten con compota de manzana
('Galletas sin gluten con compota de manzana', 'desayuno', 360,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 110. Merluza a la plancha con ensalada verde
('Merluza a la plancha con ensalada verde', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 111. Batido de avena con plátano y fresa
('Batido de avena con plátano y fresa', 'desayuno', 320,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 112. Pasta integral con espinacas y tomate
('Pasta integral con espinacas y tomate', 'comida', 440,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 113. Guiso de lentejas verdes con zanahoria
('Guiso de lentejas verdes con zanahoria', 'cena', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 114. Bocadillo de pan sin gluten con hummus y espinaca
('Bocadillo de pan sin gluten con hummus y espinaca', 'comida', 380,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 115. Yogur vegetal con granada y nuez
('Yogur vegetal con granada y nuez', 'desayuno', 350,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 116. Trucha al horno con calabacín y arroz
('Trucha al horno con calabacín y arroz', 'cena', 440,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 117. Crema de espinacas con pan integral
('Crema de espinacas con pan integral', 'comida', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 118. Ensalada de garbanzos con tomate y cebolla
('Ensalada de garbanzos con tomate y cebolla', 'comida', 410,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 119. Porridge de avena con manzana y canela
('Porridge de avena con manzana y canela', 'desayuno', 360,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 120. Pechuga de pavo con quinoa y calabacín
('Pechuga de pavo con quinoa y calabacín', 'cena', 430,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 121. Bocadillo de pan integral con aguacate y huevo
('Bocadillo de pan integral con aguacate y huevo', 'comida', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 122. Yogur vegetal con frambuesas y sirope de agave
('Yogur vegetal con frambuesas y sirope de agave', 'desayuno', 330,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 123. Lentejas con arroz y zanahoria
('Lentejas con arroz y zanahoria', 'comida', 440,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 124. Sopa de fideos de arroz con espinacas
('Sopa de fideos de arroz con espinacas', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 125. Tostadas integrales con tomate y jamón cocido
('Tostadas integrales con tomate y jamón cocido', 'desayuno', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 126. Hamburguesa vegetal con arroz y verduras
('Hamburguesa vegetal con arroz y verduras', 'comida', 450,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, FALSE, TRUE, TRUE),

-- 127. Pisto de verduras con huevo y pan integral
('Pisto de verduras con huevo y pan integral', 'cena', 440,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE);

INSERT INTO comida_ingrediente (comida_modelo_id, ingrediente_id, cantidad, g) VALUES
-- 88. Ensalada de quinoa y garbanzos
(88, 149, 60, 'g'),  -- Quinoa
(88, 97, 100, 'g'),  -- Garbanzos cocidos
(88, 1, 30, 'g'),    -- Espinaca

-- 89. Crema de calabaza con pan de centeno
(89, 287, 150, 'g'), -- Calabaza
(89, 273, 50, 'g'),  -- Pan de centeno
(89, 14, 20, 'g'),   -- Puerro

-- 90. Desayuno de yogur vegetal con frutas rojas
(90, 259, 125, 'g'), -- Yogur vegetal
(90, 274, 40, 'g'),  -- Frutos rojos
(90, 36, 1, 'g'), -- Manzana

-- 91. Hamburguesa vegetal con ensalada verde
(91, 220, 100, 'g'), -- Hamburguesa vegetal (no vegana)
(91, 284, 60, 'g'),  -- Ensalada verde
(91, 265, 40, 'g'),  -- Tomate triturado

-- 92. Tofu con verduras al vapor y arroz integral
(92, 285, 100, 'g'), -- Tofu
(92, 292, 100, 'g'), -- Verduras al vapor
(92, 146, 60, 'g'),  -- Arroz integral

-- 93. Bowl de lentejas beluga con espinacas
(93, 106, 80, 'g'),  -- Lenteja beluga cocida
(93, 1, 50, 'g'),    -- Espinaca
(93, 130, 30, 'g'),  -- Pan integral

-- 94. Pan sin gluten con aguacate y tomate
(94, 154, 50, 'g'),  -- Pan sin gluten
(94, 261, 30, 'g'),  -- Aguacate
(94, 7, 30, 'g'),    -- Tomate

-- 95. Merluza al horno con puré de patata
(95, 116, 100, 'g'), -- Merluza
(95, 282, 150, 'g'), -- Patata
(95, 4, 50, 'g'),    -- Calabacín

-- 96. Batido vegetal con avena y plátano
(96, 177, 150, 'ml'),-- Bebida de avena
(96, 127, 30, 'g'),  -- Avena en copos
(96, 37, 1, 'g'),-- Plátano

-- 97. Espaguetis integrales con verduras salteadas
(97, 289, 80, 'g'),  -- Pasta integral
(97, 286, 100, 'g'), -- Verduras salteadas
(97, 265, 40, 'g'),  -- Tomate triturado

-- 98. Bowl de arroz integral con verduras y huevo
(98, 146, 60, 'g'),     -- Arroz integral
(98, 286, 100, 'g'),    -- Verduras salteadas
(98, 276, 1, 'g'), -- Huevo

-- 99. Pasta sin gluten con hummus y tomate cherry
(99, 283, 80, 'g'),     -- Pasta sin gluten
(99, 257, 50, 'g'),     -- Hummus
(99, 258, 40, 'g'),     -- Tomate cherry

-- 100. Tostadas de maíz con aguacate y kiwi
(100, 268, 40, 'g'),    -- Tostadas de maíz
(100, 261, 30, 'g'),    -- Aguacate
(100, 44, 1, 'g'), -- Kiwi

-- 101. Crema de zanahoria y lentejas rojas
(101, 3, 80, 'g'),      -- Zanahoria
(101, 104, 60, 'g'),    -- Lenteja roja cocida
(101, 14, 30, 'g'),     -- Puerro

-- 102. Revuelto de tofu con verduras
(102, 285, 100, 'g'),   -- Tofu
(102, 286, 80, 'g'),    -- Verduras salteadas
(102, 265, 30, 'g'),    -- Tomate triturado

-- 103. Pan integral con tomate y aceite de oliva
(103, 130, 40, 'g'),    -- Pan integral
(103, 265, 30, 'g'),    -- Tomate triturado
(103, 242, 10, 'ml'),   -- Aceite de oliva virgen extra

-- 104. Curry de garbanzos y arroz
(104, 97, 100, 'g'),    -- Garbanzos cocidos
(104, 145, 60, 'g'),    -- Arroz blanco
(104, 250, 5, 'g'),     -- Curry

-- 105. Sopa de verduras con huevo duro
(105, 292, 100, 'g'),   -- Verduras al vapor
(105, 276, 1, 'g'),-- Huevo
(105, 1, 20, 'g'),      -- Espinaca

-- 106. Smoothie de frutas con bebida vegetal de coco
(106, 179, 150, 'ml'),  -- Bebida de coco
(106, 274, 50, 'g'),    -- Frutos rojos
(106, 36, 1, 'g'), -- Manzana

-- 107. Hamburguesa de lentejas y ensalada verde
(107, 96, 80, 'g'),     -- Lenteja cocida
(107, 220, 1, 'g'),-- Hamburguesa vegetal (no vegana)
(107, 284, 50, 'g'),  -- Ensalada verde

-- 108. Tacos de tofu con verduras y maíz
(108, 285, 80, 'g'),    -- Tofu
(108, 286, 100, 'g'),   -- Verduras salteadas
(108, 147, 40, 'g'),    -- Maíz

-- 109. Galletas sin gluten con compota de manzana
(109, 263, 40, 'g'),    -- Galletas sin gluten
(109, 264, 60, 'g'),    -- Compota de manzana
(109, 36, 1, 'g'), -- Manzana

-- 110. Merluza a la plancha con ensalada verde
(110, 116, 100, 'g'),   -- Merluza
(110, 284, 60, 'g'),    -- Ensalada verde
(110, 3, 50, 'g'),      -- Zanahoria

-- 111. Batido de avena con plátano y fresa
(111, 177, 150, 'ml'),  -- Bebida de avena
(111, 37, 1, 'g'), -- Plátano
(111, 43, 50, 'g'),     -- Fresa

-- 112. Pasta integral con espinacas y tomate
(112, 289, 80, 'g'),    -- Pasta integral
(112, 1, 50, 'g'),      -- Espinaca
(112, 7, 40, 'g'),      -- Tomate

-- 113. Guiso de lentejas verdes con zanahoria
(113, 107, 80, 'g'),    -- Lenteja verde cocida
(113, 3, 60, 'g'),      -- Zanahoria
(113, 14, 30, 'g'),     -- Puerro

-- 114. Bocadillo de pan sin gluten con hummus y espinaca
(114, 154, 50, 'g'),    -- Pan sin gluten
(114, 257, 40, 'g'),    -- Hummus
(114, 1, 30, 'g'),      -- Espinaca

-- 115. Yogur vegetal con granada y nuez
(115, 259, 125, 'g'),   -- Yogur vegetal
(115, 68, 40, 'g'),     -- Granada
(115, 156, 10, 'g'),    -- Nuez

-- 116. Trucha al horno con calabacín y arroz
(116, 124, 100, 'g'),   -- Trucha
(116, 4, 60, 'g'),      -- Calabacín
(116, 145, 60, 'g'),    -- Arroz blanco

-- 117. Crema de espinacas con pan integral
(117, 1, 100, 'g'),     -- Espinaca
(117, 14, 30, 'g'),     -- Puerro
(117, 130, 40, 'g'),    -- Pan integral

-- 118. Ensalada de garbanzos con tomate y cebolla
(118, 97, 100, 'g'),    -- Garbanzos cocidos
(118, 7, 50, 'g'),      -- Tomate
(118, 10, 30, 'g'),     -- Cebolla

-- 119. Porridge de avena con manzana y canela
(119, 127, 50, 'g'),    -- Avena en copos
(119, 36, 1, 'g'), -- Manzana
(119, 239, 1, 'g'),     -- Canela en polvo

-- 120. Pechuga de pavo con quinoa y calabacín
(120, 207, 100, 'g'),   -- Pechuga de pavo cocida
(120, 149, 60, 'g'),    -- Quinoa cocida
(120, 4, 60, 'g'),      -- Calabacín

-- 121. Bocadillo de pan integral con aguacate y huevo
(121, 130, 40, 'g'),    -- Pan integral
(121, 261, 30, 'g'),    -- Aguacate
(121, 276, 1, 'g'),-- Huevo

-- 122. Yogur vegetal con frambuesas y sirope de agave
(122, 259, 125, 'g'),   -- Yogur vegetal
(122, 53, 40, 'g'),     -- Frambuesa
(122, 244, 5, 'ml'),    -- Sirope de agave

-- 123. Lentejas con arroz y zanahoria
(123, 96, 80, 'g'),     -- Lenteja cocida
(123, 145, 60, 'g'),    -- Arroz blanco
(123, 3, 50, 'g'),      -- Zanahoria

-- 124. Sopa de fideos de arroz con espinacas
(124, 142, 60, 'g'),    -- Fideos de arroz
(124, 1, 40, 'g'),      -- Espinaca
(124, 14, 20, 'g'),     -- Puerro

-- 125. Tostadas integrales con tomate y jamón cocido
(125, 278, 30, 'g'),    -- Tostadas integrales
(125, 7, 40, 'g'),      -- Tomate
(125, 199, 60, 'g'),    -- Jamón cocido (York)

-- 126. Hamburguesa vegetal con arroz y verduras
(126, 220, 1, 'g'),-- Hamburguesa vegetal (no vegana)
(126, 146, 60, 'g'),    -- Arroz integral
(126, 292, 80, 'g'),    -- Verduras al vapor

-- 127. Pisto de verduras con huevo y pan integral
(127, 280, 100, 'g'),   -- Pisto
(127, 276, 1, 'g'),-- Huevo
(127, 130, 30, 'g');    -- Pan integral

INSERT INTO comida_modelo (
    nombre, tipo_comida, calorias_totales,
    apta_diabetes, apta_hipertension, apta_hipercolesterolemia, apta_celiacos, apta_renal,
    apta_anemia, apta_obesidad, apta_hipotiroidismo, apta_colon_irritable,
    sin_lactosa, sin_frutos_secos, sin_marisco, sin_pescado_azul,
    sin_huevo, sin_soja, sin_legumbres, sin_sesamo
) VALUES
-- 128. Tostadas de pan de centeno con queso fresco y miel
('Tostadas de pan de centeno con queso fresco y miel', 'desayuno', 380,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 129. Salmón a la plancha con espárragos y patata
('Salmón a la plancha con espárragos y patata', 'comida', 450,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 130. Crema de calabacín y puerro
('Crema de calabacín y puerro', 'cena', 300,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 131. Batido de fresa y plátano con leche
('Batido de fresa y plátano con leche', 'desayuno', 320,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 132. Arroz con pollo y verduras
('Arroz con pollo y verduras', 'comida', 480,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 133. Ensalada de lentejas con aguacate y tomate
('Ensalada de lentejas con aguacate y tomate', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 134. Porridge de avena con nueces y manzana
('Porridge de avena con nueces y manzana', 'desayuno', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 135. Lomo de cerdo a la plancha con pimientos
('Lomo de cerdo a la plancha con pimientos', 'comida', 460,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 136. Sopa de miso con tofu y algas
('Sopa de miso con tofu y algas', 'cena', 250,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE),

-- 137. Tostadas con aguacate y semillas de chía
('Tostadas con aguacate y semillas de chía', 'desayuno', 350,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 138. Pechuga de pavo al horno con batata
('Pechuga de pavo al horno con batata', 'comida', 430,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 139. Revuelto de champiñones y espinacas
('Revuelto de champiñones y espinacas', 'cena', 320,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 140. Yogur natural con arándanos y almendras
('Yogur natural con arándanos y almendras', 'desayuno', 310,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 141. Quinoa con verduras y garbanzos
('Quinoa con verduras y garbanzos', 'comida', 420,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 142. Brócoli al vapor con aceite de oliva y limón
('Brócoli al vapor con aceite de oliva y limón', 'cena', 280,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 143. Pan integral con hummus y pepino
('Pan integral con hummus y pepino', 'desayuno', 360,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 144. Ternera guisada con patatas y zanahorias
('Ternera guisada con patatas y zanahorias', 'comida', 500,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 145. Ensalada caprese
('Ensalada caprese', 'cena', 350,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 146. Smoothie de mango y coco
('Smoothie de mango y coco', 'desayuno', 300,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 147. Lentejas estofadas con chorizo
('Lentejas estofadas con chorizo', 'comida', 520,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 148. Puré de calabaza con picatostes
('Puré de calabaza con picatostes', 'cena', 330,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 149. Tostada francesa con sirope de arce
('Tostada francesa con sirope de arce', 'desayuno', 400,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 150. Paella de marisco
('Paella de marisco', 'comida', 550,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 151. Gazpacho andaluz
('Gazpacho andaluz', 'cena', 200,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 152. Huevos revueltos con jamón
('Huevos revueltos con jamón', 'desayuno', 380,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 153. Pollo al curry con arroz basmati
('Pollo al curry con arroz basmati', 'comida', 480,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 154. Ensalada César con pollo
('Ensalada César con pollo', 'cena', 420,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 155. Café con leche y tostada con mermelada
('Café con leche y tostada con mermelada', 'desayuno', 320,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 156. Fabada asturiana
('Fabada asturiana', 'comida', 600,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 157. Crema de champiñones
('Crema de champiñones', 'cena', 300,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 158. Tortitas americanas con nata y sirope
('Tortitas americanas con nata y sirope', 'desayuno', 450,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 159. Marmitako de bonito
('Marmitako de bonito', 'comida', 530,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 160. Sándwich mixto
('Sándwich mixto', 'cena', 380,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 161. Zumo de naranja natural y galletas María
('Zumo de naranja natural y galletas María', 'desayuno', 290,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 162. Bacalao a la vizcaína
('Bacalao a la vizcaína', 'comida', 490,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 163. Sopa juliana
('Sopa juliana', 'cena', 250,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 164. Croissant a la plancha con mantequilla y mermelada
('Croissant a la plancha con mantequilla y mermelada', 'desayuno', 420,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 165. Albóndigas con tomate
('Albóndigas con tomate', 'comida', 510,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 166. Yogur griego con miel y nueces
('Yogur griego con miel y nueces', 'cena', 370,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 167. Chocolate caliente con churros
('Chocolate caliente con churros', 'desayuno', 500,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, FALSE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 168. Lasaña de carne
('Lasaña de carne', 'comida', 580,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, FALSE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 169. Ensalada mixta
('Ensalada mixta', 'cena', 300,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 170. Cereal con leche y cacao en polvo
('Cereal con leche y cacao en polvo', 'desayuno', 340,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 171. Cocido madrileño
('Cocido madrileño', 'comida', 650,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE),

-- 172. Dorada a la sal
('Dorada a la sal', 'cena', 390,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 173. Bizcocho de yogur
('Bizcocho de yogur', 'desayuno', 380,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 174. Risotto de setas
('Risotto de setas', 'comida', 520,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 175. Tortilla francesa
('Tortilla francesa', 'cena', 310,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 176. Muesli con yogur y frutas
('Muesli con yogur y frutas', 'desayuno', 360,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 177. Canelones de atún
('Canelones de atún', 'comida', 540,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, FALSE, TRUE, TRUE,
FALSE, TRUE, TRUE, FALSE,
TRUE, TRUE, TRUE, TRUE),

-- 178. Espinacas a la crema
('Espinacas a la crema', 'cena', 340,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 179. Gofre con chocolate
('Gofre con chocolate', 'desayuno', 430,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, FALSE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 180. Entrecot a la plancha con patatas fritas
('Entrecot a la plancha con patatas fritas', 'comida', 620,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 181. Pescado al horno con verduras
('Pescado al horno con verduras', 'cena', 400,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 182. Avena cocida con leche y canela
('Avena cocida con leche y canela', 'desayuno', 350,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 183. Macarrones con tomate y queso rallado
('Macarrones con tomate y queso rallado', 'comida', 500,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 184. Sandwich vegetal con atún
('Sandwich vegetal con atún', 'cena', 410,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, FALSE,
FALSE, TRUE, TRUE, TRUE),

-- 185. Tazón de leche con galletas de chocolate
('Tazón de leche con galletas de chocolate', 'desayuno', 370,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 186. Cordero asado con patatas panadera
('Cordero asado con patatas panadera', 'comida', 630,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, FALSE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 187. Judías verdes con patata
('Judías verdes con patata', 'cena', 320,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 188. Magdalenas caseras
('Magdalenas caseras', 'desayuno', 390,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 189. Solomillo de cerdo a la pimienta
('Solomillo de cerdo a la pimienta', 'comida', 560,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 190. Revuelto de ajetes y gambas
('Revuelto de ajetes y gambas', 'cena', 360,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 191. Cereales de arroz inflado con yogur
('Cereales de arroz inflado con yogur', 'desayuno', 330,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 192. Cachopo de ternera
('Cachopo de ternera', 'comida', 700,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, FALSE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 193. Calamares a la romana
('Calamares a la romana', 'cena', 450,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 194. Pan con chocolate
('Pan con chocolate', 'desayuno', 410,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, FALSE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 195. Potaje de garbanzos
('Potaje de garbanzos', 'comida', 570,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, FALSE, TRUE),

-- 196. Berenjenas rellenas de carne
('Berenjenas rellenas de carne', 'cena', 480,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 197. Bollería industrial
('Bollería industrial', 'desayuno', 470,
FALSE, FALSE, FALSE, FALSE, FALSE,
FALSE, FALSE, FALSE, FALSE,
FALSE, FALSE, FALSE, FALSE,
FALSE, FALSE, FALSE, FALSE),

-- 198. Fideuá
('Fideuá', 'comida', 590,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE),

-- 199. Salmorejo cordobés
('Salmorejo cordobés', 'cena', 350,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE),

-- 200. Tarta de queso
('Tarta de queso', 'desayuno', 440,
TRUE, TRUE, TRUE, FALSE, TRUE,
TRUE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE, TRUE, TRUE);

INSERT INTO comida_ingrediente (comida_modelo_id, ingrediente_id, cantidad, g) VALUES
-- 128. Tostadas de pan de centeno con queso fresco y miel
(128, 273, 60, 'g'), -- pan de centeno
(128, 81, 40, 'g'),  -- Queso fresco
(128, 239, 15, 'g'),  -- Miel

-- 129. Salmón a la plancha con espárragos y patata
(129, 117, 150, 'g'), -- Salmón
(129, 24, 80, 'g'),   -- Judía verde (como espárragos)
(129, 282, 100, 'g'), -- patata

-- 130. Crema de calabacín y puerro
(130, 4, 200, 'g'),  -- Calabacín
(130, 14, 50, 'g'),   -- Puerro
(130, 282, 50, 'g'),   -- Patata

-- 131. Batido de fresa y plátano con leche
(131, 43, 80, 'g'),   -- Fresa
(131, 37, 1, 'g'), -- Plátano
(131, 77, 150, 'ml'), -- Leche semidesnatada

-- 132. Arroz con pollo y verduras
(132, 145, 80, 'g'),  -- Arroz blanco
(132, 281, 120, 'g'), -- pollo
(132, 286, 100, 'g'), -- verduras salteadas

-- 133. Ensalada de lentejas con aguacate y tomate
(133, 96, 150, 'g'),  -- Lenteja cocida
(133, 261, 50, 'g'),  -- Aguacate
(133, 7, 60, 'g'),    -- Tomate

-- 134. Porridge de avena con nueces y manzana
(134, 127, 50, 'g'),  -- Avena en copos
(134, 156, 20, 'g'),  -- Nuez
(134, 36, 1, 'g'), -- Manzana

-- 135. Lomo de cerdo a la plancha con pimientos
(135, 200, 150, 'g'), -- Lomo de cerdo
(135, 6, 100, 'g'),  -- Pimiento rojo
(135, 242, 10, 'ml'), -- Aceite de oliva virgen extra

-- 136. Sopa de miso con tofu y algas
(136, 285, 80, 'g'),  -- tofu
(136, 1, 30, 'g'), -- Espinaca (simulando alga)
(136, 100, 20, 'g'), -- Soja cocida

-- 137. Tostadas con aguacate y semillas de chía
(137, 278, 60, 'g'), -- tostadas integrales
(137, 261, 40, 'g'), -- Aguacate
(137, 227, 10, 'g'), -- Semillas de chía

-- 138. Pechuga de pavo al horno con batata
(138, 208, 150, 'g'), -- Pechuga de pavo cocida
(138, 282, 150, 'g'), -- patata (como batata)
(138, 3, 50, 'g'), -- Zanahoria

-- 139. Revuelto de champiñones y espinacas
(139, 276, 2, 'g'), -- huevo
(139, 32, 100, 'g'), -- Champiñón
(139, 1, 50, 'g'),  -- Espinaca

-- 140. Yogur natural con arándanos y almendras
(140, 79, 125, 'g'),  -- Yogur natural
(140, 57, 40, 'g'),   -- Arándano
(140, 155, 15, 'g'),  -- Almendra cruda

-- 141. Quinoa con verduras y garbanzos
(141, 149, 80, 'g'),  -- Quinoa
(141, 286, 100, 'g'), -- verduras salteadas
(141, 97, 80, 'g'),   -- Garbanzos cocidos

-- 142. Brócoli al vapor con aceite de oliva y limón
(142, 8, 200, 'g'),   -- Brócoli
(142, 242, 15, 'ml'), -- Aceite de oliva virgen extra
(142, 191, 5, 'ml'), -- Refresco de limón (zumo)

-- 143. Pan integral con hummus y pepino
(143, 130, 60, 'g'),  -- Pan integral
(143, 257, 40, 'g'),  -- hummus
(143, 25, 50, 'g'),   -- Pepino

-- 144. Ternera guisada con patatas y zanahorias
(144, 197, 150, 'g'), -- Ternera magra
(144, 282, 150, 'g'), -- patata
(144, 3, 80, 'g'),    -- Zanahoria

-- 145. Ensalada caprese
(145, 7, 100, 'g'),   -- Tomate
(145, 81, 80, 'g'),  -- Queso fresco
(145, 242, 10, 'ml'), -- Aceite de oliva virgen extra

-- 146. Smoothie de mango y coco
(146, 47, 100, 'g'),  -- Mango
(146, 179, 150, 'ml'), -- Bebida de coco
(146, 37, 0.5, 'g'), -- Plátano

-- 147. Lentejas estofadas con chorizo
(147, 96, 150, 'g'),  -- Lenteja cocida
(147, 204, 30, 'g'),  -- Chorizo curado
(147, 282, 50, 'g'),  -- patata

-- 148. Puré de calabaza con picatostes
(148, 287, 200, 'g'), -- Calabaza
(148, 129, 20, 'g'),  -- Pan blanco (picatostes)
(148, 14, 30, 'g'),   -- Puerro

-- 149. Tostada francesa con sirope de arce
(149, 129, 60, 'g'),  -- Pan blanco
(149, 276, 1, 'g'), -- huevo
(149, 77, 50, 'ml'), -- Leche semidesnatada

-- 150. Paella de marisco
(150, 145, 80, 'g'),  -- Arroz blanco
(150, 116, 50, 'g'),  -- Merluza (simulando marisco)
(150, 6, 40, 'g'),    -- Pimiento rojo

-- 151. Gazpacho andaluz
(151, 7, 200, 'g'),   -- Tomate
(151, 25, 50, 'g'),   -- Pepino
(151, 6, 30, 'g'),    -- Pimiento rojo

-- 152. Huevos revueltos con jamón
(152, 276, 2, 'g'), -- huevo
(152, 205, 40, 'g'),  -- Jamón serrano
(152, 242, 5, 'ml'),  -- Aceite de oliva virgen extra

-- 153. Pollo al curry con arroz basmati
(153, 281, 120, 'g'), -- pollo
(153, 250, 10, 'g'),  -- Curry
(153, 145, 80, 'g'),  -- Arroz blanco

-- 154. Ensalada César con pollo
(154, 11, 100, 'g'),  -- Lechuga romana
(154, 281, 80, 'g'), -- pollo
(154, 82, 20, 'g'),  -- Queso curado

-- 155. Café con leche y tostada con mermelada
(155, 174, 150, 'ml'), -- Café solo + leche
(155, 129, 40, 'g'),  -- Pan blanco
(155, 275, 20, 'g'),  -- mermelada sin azúcar

-- 156. Fabada asturiana
(156, 98, 150, 'g'),  -- Judía blanca cocida
(156, 206, 50, 'g'),  -- Morcilla
(156, 204, 50, 'g'),  -- Chorizo curado

-- 157. Crema de champiñones
(157, 32, 200, 'g'), -- Champiñón
(157, 88, 50, 'ml'),  -- Nata para cocinar
(157, 10, 30, 'g'),   -- Cebolla

-- 158. Tortitas americanas con nata y sirope
(158, 139, 100, 'g'), -- Harina de trigo
(158, 276, 1, 'g'), -- huevo
(158, 89, 30, 'g'),  -- Nata para montar

-- 159. Marmitako de bonito
(159, 118, 150, 'g'), -- Atún (como bonito)
(159, 282, 150, 'g'), -- patata
(159, 6, 50, 'g'),    -- Pimiento rojo

-- 160. Sándwich mixto
(160, 129, 60, 'g'),  -- Pan blanco
(160, 207, 40, 'g'),  -- Jamón cocido (York)
(160, 81, 30, 'g'),   -- Queso fresco

-- 161. Zumo de naranja natural y galletas María
(161, 166, 200, 'ml'), -- Zumo de naranja natural
(161, 269, 40, 'g'),  -- galletas sin lactosa (como María)
(161, 78, 50, 'ml'),  -- Leche desnatada

-- 162. Bacalao a la vizcaína
(162, 119, 150, 'g'), -- Bacalao fresco
(162, 7, 100, 'g'),   -- Tomate
(162, 6, 50, 'g'),    -- Pimiento rojo

-- 163. Sopa juliana
(163, 3, 50, 'g'),    -- Zanahoria
(163, 14, 30, 'g'),   -- Puerro
(163, 13, 30, 'g'),   -- Apio

-- 164. Croissant a la plancha con mantequilla y mermelada
(164, 129, 80, 'g'),  -- Pan blanco (como croissant)
(164, 85, 10, 'g'),   -- Mantequilla
(164, 275, 20, 'g'),  -- mermelada sin azúcar

-- 165. Albóndigas con tomate
(165, 221, 150, 'g'), -- Albóndigas de carne
(165, 265, 100, 'g'), -- tomate triturado
(165, 139, 10, 'g'), -- Harina de trigo

-- 166. Yogur griego con miel y nueces
(166, 80, 125, 'g'),  -- Yogur griego 0%
(166, 239, 15, 'g'),  -- Miel
(166, 156, 20, 'g'),  -- Nuez

-- 167. Chocolate caliente con churros
(167, 95, 150, 'ml'),  -- Batido de chocolate
(167, 139, 100, 'g'), -- Harina de trigo
(167, 237, 20, 'g'),  -- Azúcar blanco

-- 168. Lasaña de carne
(168, 134, 80, 'g'),  -- Pasta cocida
(168, 222, 120, 'g'), -- Carne picada mixta
(168, 82, 30, 'g'),   -- Queso rallado

-- 169. Ensalada mixta
(169, 11, 80, 'g'),   -- Lechuga romana
(169, 7, 50, 'g'),    -- Tomate
(169, 118, 50, 'g'),  -- Atún

-- 170. Cereal con leche y cacao en polvo
(170, 140, 40, 'g'),  -- Corn flakes
(170, 77, 150, 'ml'), -- Leche semidesnatada
(170, 237, 10, 'g'),  -- Azúcar blanco

-- 171. Cocido madrileño
(171, 97, 100, 'g'),  -- Garbanzos cocidos
(171, 197, 80, 'g'),  -- Ternera magra
(171, 204, 30, 'g'),  -- Chorizo curado

-- 172. Dorada a la sal
(172, 291, 150, 'g'), -- pescado blanco (como dorada)
(172, 245, 100, 'g'),  -- Sal
(172, 242, 10, 'ml'), -- Aceite de oliva virgen extra

-- 173. Bizcocho de yogur
(173, 139, 100, 'g'), -- Harina de trigo
(173, 79, 125, 'g'),  -- Yogur natural
(173, 276, 1, 'g'), -- huevo

-- 174. Risotto de setas
(174, 145, 80, 'g'),  -- Arroz blanco
(174, 33, 100, 'g'),  -- Seta ostra
(174, 82, 30, 'g'),   -- Queso rallado

-- 175. Tortilla francesa
(175, 276, 2, 'g'), -- huevo
(175, 245, 2, 'g'),    -- Sal
(175, 242, 5, 'ml'),  -- Aceite de oliva virgen extra

-- 176. Muesli con yogur y frutas
(176, 127, 40, 'g'),  -- Avena en copos
(176, 79, 125, 'g'),  -- Yogur natural
(176, 43, 30, 'g'),   -- Fresa

-- 177. Canelones de atún
(177, 134, 80, 'g'),  -- Pasta cocida
(177, 118, 100, 'g'), -- Atún
(177, 88, 50, 'ml'),  -- Nata para cocinar

-- 178. Espinacas a la crema
(178, 1, 150, 'g'),   -- Espinaca
(178, 88, 50, 'ml'),  -- Nata para cocinar
(178, 82, 20, 'g'),   -- Queso rallado

-- 179. Gofre con chocolate
(179, 139, 80, 'g'),  -- Harina de trigo
(179, 276, 1, 'g'), -- huevo
(179, 95, 50, 'ml'),  -- Batido de chocolate

-- 180. Entrecot a la plancha con patatas fritas
(180, 197, 200, 'g'), -- Ternera magra (entrecot)
(180, 282, 150, 'g'), -- patata
(180, 243, 20, 'ml'), -- Aceite de girasol

-- 181. Pescado al horno con verduras
(181, 291, 150, 'g'), -- pescado blanco
(181, 288, 100, 'g'), -- verduras asadas
(181, 282, 80, 'g'),  -- patata

-- 182. Avena cocida con leche y canela
(182, 127, 50, 'g'),  -- Avena en copos
(182, 77, 200, 'ml'), -- Leche semidesnatada
(182, 248, 2, 'g'),   -- Canela en polvo

-- 183. Macarrones con tomate y queso rallado
(183, 134, 80, 'g'),  -- Pasta cocida
(183, 265, 100, 'g'), -- tomate triturado
(183, 92, 30, 'g'),   -- Queso rallado

-- 184. Sandwich vegetal con atún
(184, 129, 60, 'g'),  -- Pan blanco
(184, 118, 60, 'g'),  -- Atún
(184, 11, 40, 'g'),   -- Lechuga romana

-- 185. Tazón de leche con galletas de chocolate
(185, 77, 200, 'ml'), -- Leche semidesnatada
(185, 269, 50, 'g'),  -- galletas sin lactosa (como de chocolate)
(185, 276, 0, 'g'), -- para marcar que no lleva huevo

-- 186. Cordero asado con patatas panadera
(186, 202, 200, 'g'), -- Cordero pierna
(186, 282, 150, 'g'), -- patata
(186, 10, 50, 'g'),   -- Cebolla

-- 187. Judías verdes con patata
(187, 24, 150, 'g'),  -- Judía verde
(187, 282, 100, 'g'), -- patata
(187, 242, 10, 'ml'), -- Aceite de oliva virgen extra

-- 188. Magdalenas caseras
(188, 139, 100, 'g'), -- Harina de trigo
(188, 276, 1, 'g'), -- huevo
(188, 77, 50, 'ml'), -- Leche semidesnatada

-- 189. Solomillo de cerdo a la pimienta
(189, 200, 150, 'g'), -- Lomo de cerdo (como solomillo)
(189, 88, 50, 'ml'),  -- Nata para cocinar
(189, 246, 5, 'g'),   -- Pimienta negra

-- 190. Revuelto de ajetes y gambas
(190, 276, 2, 'g'), -- huevo
(190, 10, 50, 'g'),   -- Cebolla (como ajetes)
(190, 116, 80, 'g'), -- Merluza (como gambas)

-- 191. Cereales de arroz inflado con yogur
(191, 141, 40, 'g'),  -- Arroz inflado
(191, 79, 125, 'g'),  -- Yogur natural
(191, 43, 30, 'g'),   -- Fresa

-- 192. Cachopo de ternera
(192, 224, 200, 'g'), -- Escalope de ternera
(192, 205, 50, 'g'),  -- Jamón serrano
(192, 82, 50, 'g'),   -- Queso curado

-- 193. Calamares a la romana
(193, 291, 150, 'g'), -- pescado blanco (como calamares)
(193, 139, 50, 'g'),  -- Harina de trigo
(193, 276, 1, 'g'), -- huevo

-- 194. Pan con chocolate
(194, 129, 80, 'g'),  -- Pan blanco
(194, 95, 40, 'g'),  -- Batido de chocolate (como tableta)
(194, 85, 5, 'g'),   -- Mantequilla

-- 195. Potaje de garbanzos
(195, 97, 150, 'g'),  -- Garbanzos cocidos
(195, 1, 50, 'g'),    -- Espinaca
(195, 276, 1, 'g'), -- huevo

-- 196. Berenjenas rellenas de carne
(196, 5, 200, 'g'),   -- Berenjena
(196, 222, 100, 'g'), -- Carne picada mixta
(196, 82, 30, 'g'),   -- Queso rallado

-- 197. Bollería industrial
(197, 139, 100, 'g'), -- Harina de trigo
(197, 237, 30, 'g'),  -- Azúcar blanco
(197, 85, 20, 'g'),   -- Mantequilla

-- 198. Fideuá
(198, 152, 80, 'g'),  -- Fideos de arroz (como fideos de fideuá)
(198, 291, 100, 'g'), -- pescado blanco
(198, 116, 50, 'g'), -- Merluza (como marisco)

-- 199. Salmorejo cordobés
(199, 7, 200, 'g'),   -- Tomate
(199, 129, 50, 'g'),  -- Pan blanco
(199, 242, 20, 'ml'), -- Aceite de oliva virgen extra

-- 200. Tarta de queso
(200, 86, 100, 'g'), -- Queso crema
(200, 269, 50, 'g'),  -- galletas sin lactosa (base)
(200, 276, 1, 'g'); -- huevo

INSERT INTO comida_modelo (
    nombre, tipo_comida, calorias_totales,
    apta_diabetes, apta_hipertension, apta_hipercolesterolemia, apta_celiacos, apta_renal,
    apta_anemia, apta_obesidad, apta_hipotiroidismo, apta_colon_irritable,
    sin_lactosa, sin_frutos_secos, sin_marisco, sin_pescado_azul,
    -- 201. Wok de verduras con fideos de arroz
('Wok de verduras con fideos de arroz', 'comida', 420,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 202. Ensalada de quinoa con aguacate y mango
('Ensalada de quinoa con aguacate y mango', 'comida', 450,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 203. Sopa fría de pepino y yogur
('Sopa fría de pepino y yogur', 'cena', 250,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 204. Tostadas de boniato con hummus
('Tostadas de boniato con hummus', 'desayuno', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 205. Brochetas de pavo y pimiento
('Brochetas de pavo y pimiento', 'comida', 400,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 206. Revuelto de tofu ahumado con champiñones
('Revuelto de tofu ahumado con champiñones', 'cena', 380,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 207. Pudding de chía con leche de coco y frambuesas
('Pudding de chía con leche de coco y frambuesas', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 208. Lentejas beluga con arroz integral y verduras
('Lentejas beluga con arroz integral y verduras', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 209. Crema de remolacha y manzana
('Crema de remolacha y manzana', 'cena', 280,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 210. Batido verde de espinaca, kale y piña
('Batido verde de espinaca, kale y piña', 'desayuno', 300,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 211. Salteado de garbanzos con espinacas y pimentón
('Salteado de garbanzos con espinacas y pimentón', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 212. Tabulé de cuscús integral
('Tabulé de cuscús integral', 'cena', 350,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 213. Yogur de soja con granola casera y kiwi
('Yogur de soja con granola casera y kiwi', 'desayuno', 390,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 214. Curry de verduras con leche de coco
('Curry de verduras con leche de coco', 'comida', 460,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 215. Trucha al horno con almendras
('Trucha al horno con almendras', 'cena', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, FALSE,
 TRUE, TRUE, TRUE, TRUE),
-- 216. Tostada integral con crema de anacardos y plátano
('Tostada integral con crema de anacardos y plátano', 'desayuno', 380,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 217. Poke bowl de salmón y edamame
('Poke bowl de salmón y edamame', 'comida', 500,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 TRUE, FALSE, TRUE, TRUE),
-- 218. Ensalada de pepino y rábano con vinagreta de eneldo
('Ensalada de pepino y rábano con vinagreta de eneldo', 'cena', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 219. Avena nocturna con cacao y mantequilla de cacahuete
('Avena nocturna con cacao y mantequilla de cacahuete', 'desayuno', 400,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 220. Guiso de alubias blancas con verduras
('Guiso de alubias blancas con verduras', 'comida', 470,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 221. Carpaccio de calabacín con parmesano y piñones
('Carpaccio de calabacín con parmesano y piñones', 'cena', 310,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 222. Tortitas de trigo sarraceno con compota de arándanos
('Tortitas de trigo sarraceno con compota de arándanos', 'desayuno', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 223. Berenjenas rellenas de mijo y verduras
('Berenjenas rellenas de mijo y verduras', 'comida', 440,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 224. Crema de espárragos verdes
('Crema de espárragos verdes', 'cena', 260,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 225. Kéfir con melocotón y nueces pecanas
('Kéfir con melocotón y nueces pecanas', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 226. Pollo a la naranja con cuscús
('Pollo a la naranja con cuscús', 'comida', 490,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 227. Ensalada de canónigos con queso de cabra y pera
('Ensalada de canónigos con queso de cabra y pera', 'cena', 370,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 228. Muesli sin gluten con bebida de arroz y pasas
('Muesli sin gluten con bebida de arroz y pasas', 'desayuno', 370,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 229. Hamburguesa de remolacha y alubias rojas
('Hamburguesa de remolacha y alubias rojas', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 230. Sopa de pescado ligera
('Sopa de pescado ligera', 'cena', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 231. Smoothie bowl de acai con granola y plátano
('Smoothie bowl de acai con granola y plátano', 'desayuno', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 232. Lasaña de verduras con placas de calabacín
('Lasaña de verduras con placas de calabacín', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 233. Revuelto de huevos con salmón ahumado y aguacate
('Revuelto de huevos con salmón ahumado y aguacate', 'cena', 400,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 FALSE, TRUE, TRUE, TRUE),
-- 234. Pan de espelta con tomate rallado y jamón serrano
('Pan de espelta con tomate rallado y jamón serrano', 'desayuno', 390,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 235. Albóndigas de pavo en salsa de zanahoria
('Albóndigas de pavo en salsa de zanahoria', 'comida', 450,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 236. Coliflor asada con cúrcuma y comino
('Coliflor asada con cúrcuma y comino', 'cena', 290,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 237. Yogur griego con higos y miel
('Yogur griego con higos y miel', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 238. Chili vegetariano con soja texturizada
('Chili vegetariano con soja texturizada', 'comida', 460,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 239. Crema de puerros y patata (Vichyssoise)
('Crema de puerros y patata (Vichyssoise)', 'cena', 300,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 240. Tostada sin gluten con aguacate y huevo poché
('Tostada sin gluten con aguacate y huevo poché', 'desayuno', 380,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 241. Rape a la americana
('Rape a la americana', 'comida', 470,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 242. Ensalada de espinacas, fresas y nueces
('Ensalada de espinacas, fresas y nueces', 'cena', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 243. Batido de avena, dátil y canela
('Batido de avena, dátil y canela', 'desayuno', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 244. Arroz negro con calamares (simulados)
('Arroz negro con calamares (simulados)', 'comida', 510,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 245. Sopa de cebolla gratinada
('Sopa de cebolla gratinada', 'cena', 380,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 246. Requesón con arándanos y semillas de girasol
('Requesón con arándanos y semillas de girasol', 'desayuno', 310,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 247. Pisto manchego con huevo frito
('Pisto manchego con huevo frito', 'comida', 420,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 248. Ensalada de judías verdes, patata y atún
('Ensalada de judías verdes, patata y atún', 'cena', 390,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 TRUE, TRUE, TRUE, TRUE),
-- 249. Porridge de quinoa con leche de almendras y canela
('Porridge de quinoa con leche de almendras y canela', 'desayuno', 370,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 250. Pechuga de pollo villaroy
('Pechuga de pollo villaroy', 'comida', 530,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 251. Tataki de atún con sésamo
('Tataki de atún con sésamo', 'cena', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 TRUE, TRUE, TRUE, FALSE),
-- 252. Tostadas francesas con pan integral y fruta
('Tostadas francesas con pan integral y fruta', 'desayuno', 400,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 253. Lentejas a la jardinera
('Lentejas a la jardinera', 'comida', 450,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 254. Cogollos a la plancha con anchoas (simuladas) y ajos
('Cogollos a la plancha con anchoas (simuladas) y ajos', 'cena', 280,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 255. Mousse de aguacate y cacao
('Mousse de aguacate y cacao', 'desayuno', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 256. Falso risotto de coliflor y champiñones
('Falso risotto de coliflor y champiñones', 'comida', 380,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 257. Ensalada de garbanzos, atún y huevo duro
('Ensalada de garbanzos, atún y huevo duro', 'cena', 420,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 FALSE, TRUE, FALSE, TRUE),
-- 258. Batido de kéfir con fresa y avena
('Batido de kéfir con fresa y avena', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 259. Salmón en papillote con verduras
('Salmón en papillote con verduras', 'comida', 470,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 TRUE, TRUE, TRUE, TRUE),
-- 260. Alcachofas al horno con jamón
('Alcachofas al horno con jamón', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 261. Tostadas de centeno con requesón y mermelada sin azúcar
('Tostadas de centeno con requesón y mermelada sin azúcar', 'desayuno', 370,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 262. Ternera a la plancha con puré de manzana
('Ternera a la plancha con puré de manzana', 'comida', 500,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 263. Endivias rellenas de ensaladilla de cangrejo (simulado)
('Endivias rellenas de ensaladilla de cangrejo (simulado)', 'cena', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, FALSE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 264. Bizcocho de avena y plátano
('Bizcocho de avena y plátano', 'desayuno', 390,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 265. Judiones de la granja estofados
('Judiones de la granja estofados', 'comida', 520,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 266. Sopa de tomate y albahaca
('Sopa de tomate y albahaca', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 267. Tazón de yogur con melocotón y almendras laminadas
('Tazón de yogur con melocotón y almendras laminadas', 'desayuno', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 268. Pollo al chilindrón
('Pollo al chilindrón', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 269. Ensalada de pasta integral con pesto y tomates secos
('Ensalada de pasta integral con pesto y tomates secos', 'cena', 430,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 270. Gachas de amaranto con pera y cardamomo
('Gachas de amaranto con pera y cardamomo', 'desayuno', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 271. Bacalao confitado con puré de pimientos
('Bacalao confitado con puré de pimientos', 'comida', 490,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 272. Crema de calabaza asada y jengibre
('Crema de calabaza asada y jengibre', 'cena', 290,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 273. Pan integral con aceite y chocolate negro
('Pan integral con aceite y chocolate negro', 'desayuno', 410,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 274. Conejo al ajillo con patatas
('Conejo al ajillo con patatas', 'comida', 510,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 275. Brocheta de champiñones y pimientos con salsa romesco
('Brocheta de champiñones y pimientos con salsa romesco', 'cena', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 276. Galletas de avena y zanahoria caseras
('Galletas de avena y zanahoria caseras', 'desayuno', 370,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 277. Marmita de merluza y patatas
('Marmita de merluza y patatas', 'comida', 460,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 278. Ensalada de remolacha, manzana y apio
('Ensalada de remolacha, manzana y apio', 'cena', 300,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 279. Yogur natural con compota de pera y canela
('Yogur natural con compota de pera y canela', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 280. Rollitos de primavera de verduras al horno
('Rollitos de primavera de verduras al horno', 'comida', 400,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 281. Crema de champiñones y castañas
('Crema de champiñones y castañas', 'cena', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 282. Tostada con sobrasada vegana y miel de caña
('Tostada con sobrasada vegana y miel de caña', 'desayuno', 380,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 283. Paella de verduras de temporada
('Paella de verduras de temporada', 'comida', 500,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 284. Hummus de lenteja roja con crudités
('Hummus de lenteja roja con crudités', 'cena', 310,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 285. Arroz con leche de coco y mango
('Arroz con leche de coco y mango', 'desayuno', 420,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 286. Albóndigas de berenjena en salsa de tomate
('Albóndigas de berenjena en salsa de tomate', 'comida', 440,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 287. Ensalada templada de lentejas con verduras asadas
('Ensalada templada de lentejas con verduras asadas', 'cena', 400,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 288. Bizcocho de limón y semillas de amapola
('Bizcocho de limón y semillas de amapola', 'desayuno', 390,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, FALSE),
-- 289. Fabes con almejas (simuladas)
('Fabes con almejas (simuladas)', 'comida', 530,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 290. Sopa de ajo con huevo escalfado
('Sopa de ajo con huevo escalfado', 'cena', 330,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 291. Tostada de pan de semillas con aguacate y germinados
('Tostada de pan de semillas con aguacate y germinados', 'desayuno', 370,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 292. Pollo en pepitoria
('Pollo en pepitoria', 'comida', 490,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 293. Tartar de salmón y aguacate con quinoa
('Tartar de salmón y aguacate con quinoa', 'cena', 420,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE,
 TRUE, TRUE, TRUE, TRUE),
-- 294. Muesli bircher
('Muesli bircher', 'desayuno', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 295. Caldereta de cordero
('Caldereta de cordero', 'comida', 550,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 296. Crema de nécoras (simulada)
('Crema de nécoras (simulada)', 'cena', 310,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 297. Tarta de Santiago (versión saludable)
('Tarta de Santiago (versión saludable)', 'desayuno', 400,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 298. Garbanzos con bacalao y espinacas
('Garbanzos con bacalao y espinacas', 'comida', 510,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, FALSE, TRUE),
-- 299. Pimientos del piquillo rellenos de brandada de bacalao
('Pimientos del piquillo rellenos de brandada de bacalao', 'cena', 390,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 300. Roscón de Reyes (versión saludable)
('Roscón de Reyes (versión saludable)', 'desayuno', 430,
 TRUE, TRUE, TRUE, FALSE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE);

INSERT INTO comida_ingrediente (comida_modelo_id, ingrediente_id, cantidad, g) VALUES
-- 201. Wok de verduras con fideos de arroz
(201, 292, 150, 'g'), -- verduras al vapor
(201, 152, 80, 'g'), -- Fideos de arroz
(201, 242, 10, 'ml'), -- Aceite de oliva virgen extra

-- 202. Ensalada de quinoa con aguacate y mango
(202, 149, 70, 'g'), -- Quinoa
(202, 261, 50, 'g'), -- Aguacate
(202, 47, 50, 'g'), -- Mango

-- 203. Sopa fría de pepino y yogur
(203, 25, 150, 'g'), -- Pepino
(203, 79, 125, 'g'), -- Yogur natural
(203, 13, 20, 'g'), -- Apio

-- 204. Tostadas de boniato con hummus
(204, 282, 150, 'g'), -- patata (como boniato)
(204, 257, 50, 'g'), -- hummus
(204, 249, 2, 'g'), -- Pimentón dulce
-- 205. Brochetas de pavo y pimiento
(205, 208, 120, 'g'), -- Pechuga de pavo cocida
(205, 6, 80, 'g'), -- Pimiento rojo
(205, 10, 30, 'g'), -- Cebolla
-- 206. Revuelto de tofu ahumado con champiñones
(206, 285, 100, 'g'), -- tofu
(206, 32, 80, 'g'), -- Champiñón
(206, 1, 40, 'g'), -- Espinaca
-- 207. Pudding de chía con leche de coco y frambuesas
(207, 227, 20, 'g'), -- Semillas de chía
(207, 179, 150, 'ml'), -- Bebida de coco
(207, 56, 40, 'g'), -- Frambuesa
-- 208. Lentejas beluga con arroz integral y verduras
(208, 106, 80, 'g'), -- Lenteja beluga cocida
(208, 146, 60, 'g'), -- Arroz integral
(208, 292, 100, 'g'), -- verduras al vapor
-- 209. Crema de remolacha y manzana
(209, 17, 150, 'g'), -- Remolacha
(209, 36, 1, 'g'), -- Manzana
(209, 14, 30, 'g'), -- Puerro
-- 210. Batido verde de espinaca, kale y piña
(210, 1, 50, 'g'), -- Espinaca
(210, 19, 30, 'g'), -- Col rizada (kale)
(210, 46, 100, 'g'), -- Piña
-- 211. Salteado de garbanzos con espinacas y pimentón
(211, 97, 120, 'g'), -- Garbanzos cocidos
(211, 1, 60, 'g'), -- Espinaca
(211, 249, 3, 'g'), -- Pimentón dulce
-- 212. Tabulé de cuscús integral
(212, 132, 80, 'g'), -- Cuscús cocido
(212, 7, 50, 'g'), -- Tomate
(212, 25, 50, 'g'), -- Pepino
-- 213. Yogur de soja con granola casera y kiwi
(213, 259, 125, 'g'), -- yogur vegetal
(213, 127, 30, 'g'), -- Avena en copos
(213, 44, 1, 'g'), -- Kiwi
-- 214. Curry de verduras con leche de coco
(214, 292, 150, 'g'), -- verduras al vapor
(214, 179, 100, 'ml'), -- Bebida de coco
(214, 250, 5, 'g'), -- Curry
-- 215. Trucha al horno con almendras
(215, 124, 150, 'g'), -- Trucha
(215, 155, 20, 'g'), -- Almendra cruda
(215, 282, 100, 'g'), -- patata
-- 216. Tostada integral con crema de anacardos y plátano
(216, 130, 60, 'g'), -- Pan integral
(216, 158, 20, 'g'), -- Anacardo
(216, 37, 1, 'g'), -- Plátano
-- 217. Poke bowl de salmón y edamame
(217, 117, 100, 'g'), -- Salmón
(217, 105, 50, 'g'), -- Edamame
(217, 145, 80, 'g'), -- Arroz blanco
-- 218. Ensalada de pepino y rábano con vinagreta de eneldo
(218, 25, 100, 'g'), -- Pepino
(218, 16, 50, 'g'), -- Rábano
(218, 244, 10, 'ml'), -- Vinagre de vino
-- 219. Avena nocturna con cacao y mantequilla de cacahuete
(219, 127, 50, 'g'), -- Avena en copos
(219, 115, 20, 'g'), -- Cacahuete cocido
(219, 237, 10, 'g'), -- Azúcar blanco (para cacao)
-- 220. Guiso de alubias blancas con verduras
(220, 98, 120, 'g'), -- Judía blanca cocida
(220, 3, 50, 'g'), -- Zanahoria
(220, 14, 40, 'g'), -- Puerro
-- 221. Carpaccio de calabacín con parmesano y piñones
(221, 4, 150, 'g'), -- Calabacín
(221, 92, 20, 'g'), -- Queso rallado
(221, 161, 15, 'g'), -- Piñón
-- 222. Tortitas de trigo sarraceno con compota de arándanos
(222, 150, 60, 'g'), -- Trigo sarraceno
(222, 57, 50, 'g'), -- Arándano
(222, 276, 1, 'g'), -- huevo
-- 223. Berenjenas rellenas de mijo y verduras
(223, 5, 200, 'g'), -- Berenjena
(223, 151, 70, 'g'), -- Mijo
(223, 292, 80, 'g'), -- verduras al vapor
-- 224. Crema de espárragos verdes
(224, 24, 200, 'g'), -- Judía verde (como espárragos)
(224, 282, 50, 'g'), -- patata
(224, 10, 30, 'g'), -- Cebolla
-- 225. Kéfir con melocotón y nueces pecanas
(225, 84, 150, 'g'), -- Kéfir
(225, 40, 1, 'g'), -- Melocotón
(225, 163, 15, 'g'), -- Nuez pecana
-- 226. Pollo a la naranja con cuscús
(226, 281, 120, 'g'), -- pollo
(226, 38, 1, 'g'), -- Naranja
(226, 132, 80, 'g'), -- Cuscús cocido
-- 227. Ensalada de canónigos con queso de cabra y pera
(227, 12, 100, 'g'), -- Lechuga iceberg (como canónigos)
(227, 83, 40, 'g'), -- Queso de cabra
(227, 39, 1, 'g'), -- Pera
-- 228. Muesli sin gluten con bebida de arroz y pasas
(228, 267, 50, 'g'), -- Avena sin gluten
(228, 178, 150, 'ml'), -- Bebida de arroz
(228, 65, 20, 'g'), -- Uva pasa
-- 229. Hamburguesa de remolacha y alubias rojas
(229, 17, 80, 'g'), -- Remolacha
(229, 99, 70, 'g'), -- Judía roja cocida
(229, 130, 1, 'g'), -- Pan integral (bollo)
-- 230. Sopa de pescado ligera
(230, 291, 120, 'g'), -- pescado blanco
(230, 3, 40, 'g'), -- Zanahoria
(230, 14, 30, 'g'), -- Puerro
-- 231. Smoothie bowl de acai con granola y plátano
(231, 57, 80, 'g'), -- Arándano (como acai)
(231, 127, 30, 'g'), -- Avena en copos (granola)
(231, 37, 1, 'g'), -- Plátano
-- 232. Lasaña de verduras con placas de calabacín
(232, 4, 200, 'g'), -- Calabacín
(232, 292, 150, 'g'), -- verduras al vapor
(232, 82, 40, 'g'), -- Queso rallado
-- 233. Revuelto de huevos con salmón ahumado y aguacate
(233, 276, 2, 'g'), -- huevo
(233, 117, 50, 'g'), -- Salmón
(233, 261, 40, 'g'), -- Aguacate
-- 234. Pan de espelta con tomate rallado y jamón serrano
(234, 138, 60, 'g'), -- Espelta cocida (como pan)
(234, 7, 50, 'g'), -- Tomate
(234, 205, 30, 'g'), -- Jamón serrano
-- 235. Albóndigas de pavo en salsa de zanahoria
(235, 208, 150, 'g'), -- Pechuga de pavo cocida
(235, 3, 100, 'g'), -- Zanahoria
(235, 10, 30, 'g'), -- Cebolla
-- 236. Coliflor asada con cúrcuma y comino
(236, 9, 200, 'g'), -- Coliflor
(236, 247, 3, 'g'), -- Cúrcuma
(236, 251, 3, 'g'), -- Comino
-- 237. Yogur griego con higos y miel
(237, 80, 125, 'g'), -- Yogur griego 0%
(237, 72, 2, 'g'), -- Higo fresco
(237, 239, 10, 'g'), -- Miel
-- 238. Chili vegetariano con soja texturizada
(238, 110, 80, 'g'), -- Soja texturizada
(238, 99, 100, 'g'), -- Judía roja cocida
(238, 7, 80, 'g'), -- Tomate
-- 239. Crema de puerros y patata (Vichyssoise)
(239, 14, 150, 'g'), -- Puerro
(239, 282, 100, 'g'), -- patata
(239, 88, 50, 'ml'), -- Nata para cocinar
-- 240. Tostada sin gluten con aguacate y huevo poché
(240, 154, 60, 'g'), -- Pan sin gluten
(240, 261, 40, 'g'), -- Aguacate
(240, 276, 1, 'g'), -- huevo
-- 241. Rape a la americana
(241, 125, 150, 'g'), -- Rape
(241, 7, 100, 'g'), -- Tomate
(241, 6, 50, 'g'), -- Pimiento rojo
-- 242. Ensalada de espinacas, fresas y nueces
(242, 1, 80, 'g'), -- Espinaca
(242, 43, 50, 'g'), -- Fresa
(242, 156, 20, 'g'), -- Nuez
-- 243. Batido de avena, dátil y canela
(243, 127, 50, 'g'), -- Avena en copos
(243, 63, 2, 'g'), -- Dátil seco
(243, 248, 2, 'g'), -- Canela en polvo
-- 244. Arroz negro con calamares (simulados)
(244, 145, 80, 'g'), -- Arroz blanco
(244, 291, 100, 'g'), -- pescado blanco (como calamar)
(244, 10, 40, 'g'), -- Cebolla
-- 245. Sopa de cebolla gratinada
(245, 10, 200, 'g'), -- Cebolla
(245, 129, 40, 'g'), -- Pan blanco
(245, 82, 30, 'g'), -- Queso curado
-- 246. Requesón con arándanos y semillas de girasol
(246, 93, 125, 'g'), -- Requesón
(246, 57, 40, 'g'), -- Arándano
(246, 231, 15, 'g'), -- Semillas de girasol
-- 247. Pisto manchego con huevo frito
(247, 280, 150, 'g'), -- pisto
(247, 276, 1, 'g'), -- huevo
(247, 242, 10, 'ml'), -- Aceite de oliva virgen extra
-- 248. Ensalada de judías verdes, patata y atún
(248, 24, 100, 'g'), -- Judía verde
(248, 282, 80, 'g'), -- patata
(248, 118, 60, 'g'), -- Atún
-- 249. Porridge de quinoa con leche de almendras y canela
(249, 149, 50, 'g'), -- Quinoa
(249, 176, 150, 'ml'), -- Bebida de almendra sin azúcar
(249, 248, 2, 'g'), -- Canela en polvo
-- 250. Pechuga de pollo villaroy
(250, 281, 120, 'g'), -- pollo
(250, 139, 30, 'g'), -- Harina de trigo
(250, 88, 50, 'ml'), -- Nata para cocinar
-- 251. Tataki de atún con sésamo
(251, 118, 150, 'g'), -- Atún
(251, 229, 10, 'g'), -- Semillas de sésamo
(251, 172, 20, 'ml'), -- Bebida vegetal de soja
-- 252. Tostadas francesas con pan integral y fruta
(252, 130, 60, 'g'), -- Pan integral
(252, 276, 1, 'g'), -- huevo
(252, 274, 50, 'g'), -- frutos rojos
-- 253. Lentejas a la jardinera
(253, 96, 120, 'g'), -- Lenteja cocida
(253, 3, 50, 'g'), -- Zanahoria
(253, 24, 40, 'g'), -- Judía verde
-- 254. Cogollos a la plancha con anchoas (simuladas) y ajos
(254, 11, 150, 'g'), -- Lechuga romana (cogollos)
(254, 291, 30, 'g'), -- pescado blanco (anchoa)
(254, 10, 20, 'g'), -- Cebolla (ajo)
-- 255. Mousse de aguacate y cacao
(255, 261, 1, 'g'), -- Aguacate
(255, 237, 20, 'g'), -- Azúcar blanco (cacao)
(255, 179, 50, 'ml'), -- Bebida de coco
-- 256. Falso risotto de coliflor y champiñones
(256, 9, 200, 'g'), -- Coliflor
(256, 32, 80, 'g'), -- Champiñón
(256, 92, 30, 'g'), -- Queso rallado
-- 257. Ensalada de garbanzos, atún y huevo duro
(257, 97, 100, 'g'), -- Garbanzos cocidos
(257, 118, 60, 'g'), -- Atún
(257, 262, 1, 'g'), -- Huevo duro
-- 258. Batido de kéfir con fresa y avena
(258, 84, 150, 'g'), -- Kéfir
(258, 43, 50, 'g'), -- Fresa
(258, 127, 20, 'g'), -- Avena en copos
-- 259. Salmón en papillote con verduras
(259, 117, 150, 'g'), -- Salmón
(259, 292, 120, 'g'), -- verduras al vapor
(259, 191, 10, 'ml'), -- Refresco de limón
-- 260. Alcachofas al horno con jamón
(260, 23, 200, 'g'), -- Alcachofa
(260, 205, 40, 'g'), -- Jamón serrano
(260, 242, 10, 'ml'), -- Aceite de oliva virgen extra
-- 261. Tostadas de centeno con requesón y mermelada sin azúcar
(261, 273, 60, 'g'), -- pan de centeno
(261, 93, 40, 'g'), -- Requesón
(261, 275, 20, 'g'), -- mermelada sin azúcar
-- 262. Ternera a la plancha con puré de manzana
(262, 197, 150, 'g'), -- Ternera magra
(262, 36, 1, 'g'), -- Manzana
(262, 242, 10, 'ml'), -- Aceite de oliva virgen extra
-- 263. Endivias rellenas de ensaladilla de cangrejo (simulado)
(263, 22, 100, 'g'), -- Endibia
(263, 117, 60, 'g'), -- Salmón (como cangrejo)
(263, 282, 40, 'g'), -- patata
-- 264. Bizcocho de avena y plátano
(264, 127, 80, 'g'), -- Avena en copos
(264, 37, 1, 'g'), -- Plátano
(264, 276, 1, 'g'), -- huevo
-- 265. Judiones de la granja estofados
(265, 109, 150, 'g'), -- Judión cocido
(265, 204, 40, 'g'), -- Chorizo curado
(265, 3, 50, 'g'), -- Zanahoria
-- 266. Sopa de tomate y albahaca
(266, 7, 200, 'g'), -- Tomate
(266, 235, 10, 'g'), -- Semillas de albahaca
(266, 242, 10, 'ml'), -- Aceite de oliva virgen extra
-- 267. Tazón de yogur con melocotón y almendras laminadas
(267, 79, 125, 'g'), -- Yogur natural
(267, 40, 1, 'g'), -- Melocotón
(267, 155, 15, 'g'), -- Almendra cruda
-- 268. Pollo al chilindrón
(268, 281, 120, 'g'), -- pollo
(268, 6, 80, 'g'), -- Pimiento rojo
(268, 7, 60, 'g'), -- Tomate
-- 269. Ensalada de pasta integral con pesto y tomates secos
(269, 289, 80, 'g'), -- pasta integral
(269, 161, 10, 'g'), -- Piñón (para pesto)
(269, 258, 40, 'g'), -- tomate cherry
-- 270. Gachas de amaranto con pera y cardamomo
(270, 136, 50, 'g'), -- Amaranto cocido
(270, 39, 1, 'g'), -- Pera
(270, 177, 150, 'ml'), -- Bebida de avena
-- 271. Bacalao confitado con puré de pimientos
(271, 119, 150, 'g'), -- Bacalao fresco
(271, 6, 100, 'g'), -- Pimiento rojo
(271, 242, 20, 'ml'), -- Aceite de oliva virgen extra
-- 272. Crema de calabaza asada y jengibre
(272, 287, 200, 'g'), -- Calabaza
(272, 3, 50, 'g'), -- Zanahoria (como jengibre)
(272, 10, 30, 'g'), -- Cebolla
-- 273. Pan integral con aceite y chocolate negro
(273, 130, 60, 'g'), -- Pan integral
(273, 242, 10, 'ml'), -- Aceite de oliva virgen extra
(273, 95, 30, 'g'), -- Batido de chocolate (como chocolate negro)
-- 274. Conejo al ajillo con patatas
(274, 281, 150, 'g'), -- pollo (como conejo)
(274, 282, 120, 'g'), -- patata
(274, 10, 40, 'g'), -- Cebolla (ajo)
-- 275. Brocheta de champiñones y pimientos con salsa romesco
(275, 32, 150, 'g'), -- Champiñón
(275, 6, 80, 'g'), -- Pimiento rojo
(275, 155, 20, 'g'), -- Almendra cruda (para romesco)
-- 276. Galletas de avena y zanahoria caseras
(276, 127, 80, 'g'), -- Avena en copos
(276, 3, 50, 'g'), -- Zanahoria
(276, 276, 1, 'g'), -- huevo
-- 277. Marmita de merluza y patatas
(277, 116, 150, 'g'), -- Merluza
(277, 282, 120, 'g'), -- patata
(277, 6, 60, 'g'), -- Pimiento rojo
-- 278. Ensalada de remolacha, manzana y apio
(278, 17, 100, 'g'), -- Remolacha
(278, 36, 1, 'g'), -- Manzana
(278, 13, 40, 'g'), -- Apio
-- 279. Yogur natural con compota de pera y canela
(279, 79, 125, 'g'), -- Yogur natural
(279, 270, 50, 'g'), -- Compota de pera
(279, 248, 2, 'g'), -- Canela en polvo
-- 280. Rollitos de primavera de verduras al horno
(280, 139, 60, 'g'), -- Harina de trigo (obleas)
(280, 292, 150, 'g'), -- verduras al vapor
(280, 172, 20, 'ml'), -- Bebida vegetal de soja
-- 281. Crema de champiñones y castañas
(281, 32, 150, 'g'), -- Champiñón
(281, 75, 50, 'g'), -- Castaña
(281, 14, 30, 'g'), -- Puerro
-- 282. Tostada con sobrasada vegana y miel de caña
(282, 278, 60, 'g'), -- tostadas integrales
(282, 7, 50, 'g'), -- Tomate (base sobrasada)
(282, 239, 10, 'g'), -- Miel (como miel de caña)
-- 283. Paella de verduras de temporada
(283, 145, 80, 'g'), -- Arroz blanco
(283, 292, 150, 'g'), -- verduras al vapor
(283, 23, 50, 'g'), -- Alcachofa
-- 284. Hummus de lenteja roja con crudités
(284, 104, 100, 'g'), -- Lenteja roja cocida
(284, 3, 50, 'g'), -- Zanahoria
(284, 25, 50, 'g'), -- Pepino
-- 285. Arroz con leche de coco y mango
(285, 145, 60, 'g'), -- Arroz blanco
(285, 179, 150, 'ml'), -- Bebida de coco
(285, 47, 80, 'g'), -- Mango
-- 286. Albóndigas de berenjena en salsa de tomate
(286, 5, 150, 'g'), -- Berenjena
(286, 139, 30, 'g'), -- Harina de trigo
(286, 265, 100, 'g'), -- tomate triturado
-- 287. Ensalada templada de lentejas con verduras asadas
(287, 96, 100, 'g'), -- Lenteja cocida
(287, 288, 120, 'g'), -- verduras asadas
(287, 242, 10, 'ml'), -- Aceite de oliva virgen extra
-- 288. Bizcocho de limón y semillas de amapola
(288, 139, 80, 'g'), -- Harina de trigo
(288, 191, 1, 'g'), -- Refresco de limón
(288, 232, 5, 'g'), -- Semillas de amapola
-- 289. Fabes con almejas (simuladas)
(289, 98, 120, 'g'), -- Judía blanca cocida
(289, 291, 80, 'g'), -- pescado blanco (como almejas)
(289, 1, 50, 'g'), -- Espinaca
-- 290. Sopa de ajo con huevo escalfado
(290, 129, 60, 'g'), -- Pan blanco
(290, 10, 30, 'g'), -- Cebolla (ajo)
(290, 276, 1, 'g'), -- huevo
-- 291. Tostada de pan de semillas con aguacate y germinados
(291, 130, 60, 'g'), -- Pan integral (con semillas)
(291, 261, 40, 'g'), -- Aguacate
(291, 1, 20, 'g'), -- Espinaca (germinados)
-- 292. Pollo en pepitoria
(292, 281, 120, 'g'), -- pollo
(292, 155, 20, 'g'), -- Almendra cruda
(292, 276, 1, 'g'), -- huevo (yema)
-- 293. Tartar de salmón y aguacate con quinoa
(293, 117, 100, 'g'), -- Salmón
(293, 261, 50, 'g'), -- Aguacate
(293, 149, 60, 'g'), -- Quinoa
-- 294. Muesli bircher
(294, 127, 50, 'g'), -- Avena en copos
(294, 79, 125, 'g'), -- Yogur natural
(294, 36, 1, 'g'), -- Manzana
-- 295. Caldereta de cordero
(295, 202, 150, 'g'), -- Cordero pierna
(295, 282, 120, 'g'), -- patata
(295, 3, 60, 'g'), -- Zanahoria
-- 296. Crema de nécoras (simulada)
(296, 291, 100, 'g'), -- pescado blanco (como nécora)
(296, 88, 50, 'ml'), -- Nata para cocinar
(296, 7, 50, 'g'), -- Tomate
-- 297. Tarta de Santiago (versión saludable)
(297, 155, 100, 'g'), -- Almendra cruda
(297, 276, 2, 'g'), -- huevo
(297, 237, 50, 'g'), -- Azúcar blanco
-- 298. Garbanzos con bacalao y espinacas
(298, 97, 120, 'g'), -- Garbanzos cocidos
(298, 119, 80, 'g'), -- Bacalao fresco
(298, 1, 60, 'g'), -- Espinaca
-- 299. Pimientos del piquillo rellenos de brandada de bacalao
(299, 6, 150, 'g'), -- Pimiento rojo
(299, 119, 80, 'g'), -- Bacalao fresco
(299, 88, 40, 'ml'), -- Nata para cocinar
-- 300. Roscón de Reyes (versión saludable)
(300, 139, 100, 'g'), -- Harina de trigo
(300, 77, 80, 'ml'), -- Leche semidesnatada
(300, 276, 1, 'g'); -- huevo

INSERT INTO comida_modelo (
    nombre, tipo_comida, calorias_totales,
    apta_diabetes, apta_hipertension, apta_hipercolesterolemia, apta_celiacos, apta_renal,
    apta_anemia, apta_obesidad, apta_hipotiroidismo, apta_colon_irritable,
    sin_lactosa, sin_frutos_secos, sin_marisco, sin_pescado_azul,
    sin_huevo, sin_soja, sin_legumbres, sin_sesamo
) VALUES
-- 301. Bowl de quinoa arcoíris con verduras y huevo
('Bowl de quinoa arcoíris con verduras y huevo', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 302. Tostadas integrales con aguacate, tomate y semillas de sésamo
('Tostadas integrales con aguacate, tomate y semillas de sésamo', 'desayuno', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
-- 303. Ensalada fresca de garbanzos, pepino y pimiento rojo
('Ensalada fresca de garbanzos, pepino y pimiento rojo', 'almuerzo', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 304. Smoothie tropical de mango, plátano y bebida de coco
('Smoothie tropical de mango, plátano y bebida de coco', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 305. Pasta integral con brócoli, tomate cherry y queso fresco
('Pasta integral con brócoli, tomate cherry y queso fresco', 'comida', 510,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 306. Tortilla de espinacas, cebolla y champiñón
('Tortilla de espinacas, cebolla y champiñón', 'cena', 390,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 307. Porridge de avena con manzana, nueces y canela
('Porridge de avena con manzana, nueces y canela', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 308. Ensalada templada de lenteja beluga, zanahoria y huevo duro
('Ensalada templada de lenteja beluga, zanahoria y huevo duro', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, FALSE, TRUE),
-- 309. Crema suave de calabaza, puerro y patata
('Crema suave de calabaza, puerro y patata', 'cena', 280,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 310. Yogur natural con frutos rojos y semillas de lino
('Yogur natural con frutos rojos y semillas de lino', 'merienda', 220,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 311. Ensalada de espelta, tomate seco y rúcula
('Ensalada de espelta, tomate seco y rúcula', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 312. Tostadas de pan de centeno con aguacate y huevo poché
('Tostadas de pan de centeno con aguacate y huevo poché', 'desayuno', 370,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 313. Buddha bowl de arroz integral, edamame y zanahoria
('Buddha bowl de arroz integral, edamame y zanahoria', 'comida', 450,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 314. Smoothie verde de kiwi, espinaca y bebida de avena
('Smoothie verde de kiwi, espinaca y bebida de avena', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 315. Pasta de trigo sarraceno con calabacín y tomate cherry
('Pasta de trigo sarraceno con calabacín y tomate cherry', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 316. Tortilla de berenjena, cebolla y pimiento verde
('Tortilla de berenjena, cebolla y pimiento verde', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 317. Porridge de mijo con pera y semillas de calabaza
('Porridge de mijo con pera y semillas de calabaza', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 318. Ensalada de garbanzos, tomate, pepino y cebolla morada
('Ensalada de garbanzos, tomate, pepino y cebolla morada', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 319. Crema de coliflor, puerro y zanahoria
('Crema de coliflor, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 320. Yogur vegetal con mango y semillas de chía
('Yogur vegetal con mango y semillas de chía', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, FALSE),
-- 321. Ensalada de bulgur, remolacha y queso de cabra
('Ensalada de bulgur, remolacha y queso de cabra', 'comida', 420,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, FALSE, TRUE),
-- 322. Tostadas de pan integral con hummus y zanahoria rallada
('Tostadas de pan integral con hummus y zanahoria rallada', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 323. Buddha bowl de arroz blanco, edamame y aguacate
('Buddha bowl de arroz blanco, edamame y aguacate', 'comida', 460,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 324. Smoothie de piña, espinaca y bebida de soja
('Smoothie de piña, espinaca y bebida de soja', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 325. Pasta de espelta con calabaza y nueces
('Pasta de espelta con calabaza y nueces', 'comida', 500,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 326. Tortilla de calabacín, cebolla y pimiento rojo
('Tortilla de calabacín, cebolla y pimiento rojo', 'cena', 370,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 327. Porridge de avena con pera y semillas de amapola
('Porridge de avena con pera y semillas de amapola', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 328. Ensalada de judía blanca, tomate y cebolla
('Ensalada de judía blanca, tomate y cebolla', 'almuerzo', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 329. Crema de zanahoria, puerro y patata
('Crema de zanahoria, puerro y patata', 'cena', 260,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 330. Yogur vegetal con kiwi y semillas de lino
('Yogur vegetal con kiwi y semillas de lino', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 331. Ensalada de quinoa, pepino y tomate cherry
('Ensalada de quinoa, pepino y tomate cherry', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 332. Tostadas de pan de centeno con aguacate y tomate
('Tostadas de pan de centeno con aguacate y tomate', 'desayuno', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 333. Buddha bowl de arroz integral, garbanzos y zanahoria
('Buddha bowl de arroz integral, garbanzos y zanahoria', 'comida', 440,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 334. Smoothie de mango, espinaca y bebida de avena
('Smoothie de mango, espinaca y bebida de avena', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 335. Pasta de trigo sarraceno con calabaza y nueces
('Pasta de trigo sarraceno con calabaza y nueces', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 336. Tortilla de berenjena, cebolla y pimiento rojo
('Tortilla de berenjena, cebolla y pimiento rojo', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 337. Porridge de mijo con manzana y semillas de calabaza
('Porridge de mijo con manzana y semillas de calabaza', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 338. Ensalada de judía roja, tomate y cebolla morada
('Ensalada de judía roja, tomate y cebolla morada', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 339. Crema de col lombarda, puerro y zanahoria
('Crema de col lombarda, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 340. Yogur natural con pera y semillas de chía
('Yogur natural con pera y semillas de chía', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
-- 341. Ensalada de amaranto, tomate cherry y pepino
('Ensalada de amaranto, tomate cherry y pepino', 'comida', 400,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 342. Tostadas de pan sin gluten con hummus y pimiento asado
('Tostadas de pan sin gluten con hummus y pimiento asado', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 343. Buddha bowl de arroz inflado, edamame y zanahoria
('Buddha bowl de arroz inflado, edamame y zanahoria', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 344. Smoothie de frambuesa, espinaca y bebida de almendra
('Smoothie de frambuesa, espinaca y bebida de almendra', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 345. Pasta de maíz con calabaza y pistacho
('Pasta de maíz con calabaza y pistacho', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 346. Tortilla de col rizada, cebolla y pimiento verde
('Tortilla de col rizada, cebolla y pimiento verde', 'cena', 360,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 347. Porridge de copos de trigo integral con pera y semillas de girasol
('Porridge de copos de trigo integral con pera y semillas de girasol', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 348. Ensalada de judión, tomate y cebolla
('Ensalada de judión, tomate y cebolla', 'almuerzo', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 349. Crema de brócoli, puerro y patata
('Crema de brócoli, puerro y patata', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 350. Yogur vegetal con manzana y semillas de lino
('Yogur vegetal con manzana y semillas de lino', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 351. Ensalada de mijo, pepino y tomate cherry
('Ensalada de mijo, pepino y tomate cherry', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 352. Tostadas de pan integral con hummus y remolacha
('Tostadas de pan integral con hummus y remolacha', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 353. Buddha bowl de arroz blanco, garbanzos y zanahoria
('Buddha bowl de arroz blanco, garbanzos y zanahoria', 'comida', 440,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 354. Smoothie de arándano, espinaca y bebida de avena
('Smoothie de arándano, espinaca y bebida de avena', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 355. Pasta de bulgur con calabaza y nuez pecana
('Pasta de bulgur con calabaza y nuez pecana', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 356. Tortilla de coliflor, cebolla y pimiento rojo
('Tortilla de coliflor, cebolla y pimiento rojo', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 357. Porridge de copos de maíz con pera y semillas de calabaza
('Porridge de copos de maíz con pera y semillas de calabaza', 'desayuno', 320,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 358. Ensalada de alubia pinta, tomate y cebolla morada
('Ensalada de alubia pinta, tomate y cebolla morada', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 359. Crema de col rizada, puerro y zanahoria
('Crema de col rizada, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 360. Yogur natural con manzana y semillas de chía
('Yogur natural con manzana y semillas de chía', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
-- 361. Ensalada de espelta, zanahoria y tomate cherry
('Ensalada de espelta, zanahoria y tomate cherry', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 362. Tostadas de pan de centeno con hummus y pepino
('Tostadas de pan de centeno con hummus y pepino', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 363. Buddha bowl de arroz integral, judía verde y zanahoria
('Buddha bowl de arroz integral, judía verde y zanahoria', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 364. Smoothie de fresa, espinaca y bebida de avena
('Smoothie de fresa, espinaca y bebida de avena', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 365. Pasta de trigo sarraceno con calabaza y almendra cruda
('Pasta de trigo sarraceno con calabaza y almendra cruda', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 366. Tortilla de coles de Bruselas, cebolla y pimiento rojo
('Tortilla de coles de Bruselas, cebolla y pimiento rojo', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 367. Porridge de avena con manzana y semillas de sésamo
('Porridge de avena con manzana y semillas de sésamo', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
-- 368. Ensalada de judía negra, tomate y cebolla morada
('Ensalada de judía negra, tomate y cebolla morada', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 369. Crema de coliflor, puerro y zanahoria
('Crema de coliflor, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 370. Yogur vegetal con mango y semillas de lino
('Yogur vegetal con mango y semillas de lino', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 371. Ensalada de bulgur, pepino y tomate cherry
('Ensalada de bulgur, pepino y tomate cherry', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 372. Tostadas de pan integral con hummus y calabacín
('Tostadas de pan integral con hummus y calabacín', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 373. Buddha bowl de arroz blanco, judía roja y zanahoria
('Buddha bowl de arroz blanco, judía roja y zanahoria', 'comida', 440,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 374. Smoothie de frambuesa, espinaca y bebida de soja
('Smoothie de frambuesa, espinaca y bebida de soja', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 375. Pasta de espelta con calabaza y nuez
('Pasta de espelta con calabaza y nuez', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 376. Tortilla de col lombarda, cebolla y pimiento rojo
('Tortilla de col lombarda, cebolla y pimiento rojo', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 377. Porridge de copos de trigo integral con pera y semillas de calabaza
('Porridge de copos de trigo integral con pera y semillas de calabaza', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 378. Ensalada de alubia pinta, tomate y cebolla
('Ensalada de alubia pinta, tomate y cebolla', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 379. Crema de col rizada, puerro y zanahoria
('Crema de col rizada, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 380. Yogur natural con pera y semillas de chía
('Yogur natural con pera y semillas de chía', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
-- 381. Ensalada de quinoa, zanahoria y tomate cherry
('Ensalada de quinoa, zanahoria y tomate cherry', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 382. Tostadas de pan de centeno con hummus y remolacha
('Tostadas de pan de centeno con hummus y remolacha', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 383. Buddha bowl de arroz integral, judía blanca y zanahoria
('Buddha bowl de arroz integral, judía blanca y zanahoria', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 384. Smoothie de kiwi, espinaca y bebida de avena
('Smoothie de kiwi, espinaca y bebida de avena', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 385. Pasta de bulgur con calabaza y nuez
('Pasta de bulgur con calabaza y nuez', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 386. Tortilla de coliflor, cebolla y pimiento verde
('Tortilla de coliflor, cebolla y pimiento verde', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 387. Porridge de copos de maíz con manzana y semillas de sésamo
('Porridge de copos de maíz con manzana y semillas de sésamo', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
-- 388. Ensalada de judía roja, tomate y cebolla
('Ensalada de judía roja, tomate y cebolla', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 389. Crema de col lombarda, puerro y zanahoria
('Crema de col lombarda, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 390. Yogur vegetal con pera y semillas de lino
('Yogur vegetal con pera y semillas de lino', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 391. Ensalada de espelta, pepino y tomate cherry
('Ensalada de espelta, pepino y tomate cherry', 'comida', 410,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 392. Tostadas de pan integral con hummus y zanahoria
('Tostadas de pan integral con hummus y zanahoria', 'desayuno', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, FALSE, TRUE),
-- 393. Buddha bowl de arroz blanco, edamame y zanahoria
('Buddha bowl de arroz blanco, edamame y zanahoria', 'comida', 430,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 394. Smoothie de mango, espinaca y bebida de soja
('Smoothie de mango, espinaca y bebida de soja', 'merienda', 200,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, FALSE, TRUE, TRUE),
-- 395. Pasta de trigo sarraceno con calabaza y nuez pecana
('Pasta de trigo sarraceno con calabaza y nuez pecana', 'comida', 480,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, FALSE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 396. Tortilla de col rizada, cebolla y pimiento rojo
('Tortilla de col rizada, cebolla y pimiento rojo', 'cena', 350,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE),
-- 397. Porridge de avena con manzana y semillas de calabaza
('Porridge de avena con manzana y semillas de calabaza', 'desayuno', 330,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 398. Ensalada de judía blanca, tomate y cebolla morada
('Ensalada de judía blanca, tomate y cebolla morada', 'almuerzo', 340,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, FALSE, TRUE),
-- 399. Crema de coliflor, puerro y zanahoria
('Crema de coliflor, puerro y zanahoria', 'cena', 270,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE),
-- 400. Yogur natural con mango y semillas de chía
('Yogur natural con mango y semillas de chía', 'merienda', 210,
 TRUE, TRUE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, TRUE,
 FALSE, TRUE, TRUE, TRUE,
 TRUE, TRUE, TRUE, FALSE),
;

INSERT INTO comida_ingrediente (comida_modelo_id, ingrediente_id, cantidad, unidad) VALUES
-- 301. Bowl de quinoa arcoíris con verduras y huevo
(301, 128, 70, 'g'), -- quinoa cocida
(301, 4, 40, 'g'), -- calabacín
(301, 6, 30, 'g'), -- pimiento rojo
(301, 276, 60, 'g'), -- huevo
(301, 43, 30, 'g'), -- fresa
-- 302. Tostadas integrales con aguacate, tomate y semillas de sésamo
(302, 278, 30, 'g'), -- tostadas integrales
(302, 261, 50, 'g'), -- aguacate
(302, 7, 40, 'g'), -- tomate
(302, 229, 5, 'g'), -- semillas de sésamo
-- 303. Ensalada fresca de garbanzos, pepino y pimiento rojo
(303, 97, 80, 'g'), -- garbanzos cocidos
(303, 25, 40, 'g'), -- pepino
(303, 6, 30, 'g'), -- pimiento rojo
-- 304. Smoothie tropical de mango, plátano y bebida de coco
(304, 47, 60, 'g'), -- mango
(304, 37, 60, 'g'), -- plátano
(304, 179, 150, 'ml'), -- bebida de coco
-- 305. Pasta integral con brócoli, tomate cherry y queso fresco
(305, 289, 70, 'g'), -- pasta integral
(305, 8, 40, 'g'), -- brócoli
(305, 258, 30, 'g'), -- tomate cherry
(305, 81, 40, 'g'), -- queso fresco
-- 306. Tortilla de espinacas, cebolla y champiñón
(306, 1, 40, 'g'), -- espinaca
(306, 10, 30, 'g'), -- cebolla
(306, 32, 30, 'g'), -- champiñón
(306, 276, 60, 'g'), -- huevo
-- 307. Porridge de avena con manzana, nueces y canela
(307, 127, 40, 'g'), -- avena en copos
(307, 36, 50, 'g'), -- manzana
(307, 156, 10, 'g'), -- nuez
(307, 248, 1, 'g'), -- canela en polvo
-- 308. Ensalada templada de lenteja beluga, zanahoria y huevo duro
(308, 106, 60, 'g'), -- lenteja beluga cocida
(308, 3, 40, 'g'), -- zanahoria
(308, 276, 60, 'g'), -- huevo
-- 309. Crema suave de calabaza, puerro y patata
(309, 287, 80, 'g'), -- calabaza
(309, 14, 30, 'g'), -- puerro
(309, 282, 40, 'g'), -- patata
-- 310. Yogur natural con frutos rojos y semillas de lino
(310, 79, 125, 'g'), -- yogur natural
(310, 274, 40, 'g'), -- frutos rojos
(310, 228, 10, 'g'), -- semillas de lino
-- 311. Ensalada de espelta, tomate seco y rúcula
(311, 138, 60, 'g'), -- espelta cocida
(311, 291, 20, 'g'), -- tomate seco
(311, 292, 20, 'g'), -- rúcula
-- 312. Tostadas de pan de centeno con aguacate y huevo poché
(312, 273, 30, 'g'), -- pan de centeno
(312, 261, 50, 'g'), -- aguacate
(312, 276, 60, 'g'), -- huevo
-- 313. Buddha bowl de arroz integral, edamame y zanahoria
(313, 146, 60, 'g'), -- arroz integral
(313, 105, 40, 'g'), -- edamame
(313, 3, 30, 'g'), -- zanahoria
-- 314. Smoothie verde de kiwi, espinaca y bebida de avena
(314, 44, 60, 'g'), -- kiwi
(314, 1, 30, 'g'), -- espinaca
(314, 177, 150, 'ml'), -- bebida de avena
-- 315. Pasta de trigo sarraceno con calabacín y tomate cherry
(315, 150, 60, 'g'), -- trigo sarraceno
(315, 4, 30, 'g'), -- calabacín
(315, 258, 30, 'g'), -- tomate cherry
-- 316. Tortilla de berenjena, cebolla y pimiento verde
(316, 5, 40, 'g'), -- berenjena
(316, 10, 30, 'g'), -- cebolla
(316, 293, 30, 'g'), -- pimiento verde
(316, 276, 60, 'g'), -- huevo
-- 317. Porridge de mijo con pera y semillas de calabaza
(317, 137, 40, 'g'), -- mijo cocido
(317, 39, 50, 'g'), -- pera
(317, 230, 10, 'g'), -- semillas de calabaza
-- 318. Ensalada de garbanzos, tomate, pepino y cebolla morada
(318, 97, 60, 'g'), -- garbanzos cocidos
(318, 7, 30, 'g'), -- tomate
(318, 25, 30, 'g'), -- pepino
(318, 294, 20, 'g'), -- cebolla morada
-- 319. Crema de coliflor, puerro y zanahoria
(319, 9, 60, 'g'), -- coliflor
(319, 14, 30, 'g'), -- puerro
(319, 3, 30, 'g'), -- zanahoria
-- 320. Yogur vegetal con mango y semillas de chía
(320, 259, 125, 'g'), -- yogur vegetal
(320, 47, 40, 'g'), -- mango
(320, 227, 10, 'g'), -- semillas de chía
-- 321. Ensalada de bulgur, remolacha y queso de cabra
(321, 133, 60, 'g'), -- bulgur cocido
(321, 17, 40, 'g'), -- remolacha
(321, 83, 30, 'g'), -- queso de cabra
-- 322. Tostadas de pan integral con hummus y zanahoria rallada
(322, 130, 30, 'g'), -- pan integral
(322, 257, 40, 'g'), -- hummus
(322, 3, 30, 'g'), -- zanahoria
-- 323. Buddha bowl de arroz blanco, edamame y aguacate
(323, 145, 60, 'g'), -- arroz blanco
(323, 105, 40, 'g'), -- edamame
(323, 261, 30, 'g'), -- aguacate
-- 324. Smoothie de piña, espinaca y bebida de soja
(324, 46, 60, 'g'), -- piña
(324, 1, 30, 'g'), -- espinaca
(324, 178, 150, 'ml'), -- bebida de soja
-- 325. Pasta de espelta con calabaza y nueces
(325, 138, 60, 'g'), -- espelta cocida
(325, 287, 30, 'g'), -- calabaza
(325, 156, 10, 'g'), -- nuez
-- 326. Tortilla de calabacín, cebolla y pimiento rojo
(326, 4, 40, 'g'), -- calabacín
(326, 10, 30, 'g'), -- cebolla
(326, 6, 30, 'g'), -- pimiento rojo
(326, 276, 60, 'g'), -- huevo
-- 327. Porridge de avena con pera y semillas de amapola
(327, 127, 40, 'g'), -- avena en copos
(327, 39, 50, 'g'), -- pera
(327, 232, 10, 'g'), -- semillas de amapola
-- 328. Ensalada de judía blanca, tomate y cebolla
(328, 98, 60, 'g'), -- judía blanca cocida
(328, 7, 30, 'g'), -- tomate
(328, 10, 20, 'g'), -- cebolla
-- 329. Crema de zanahoria, puerro y patata
(329, 3, 60, 'g'), -- zanahoria
(329, 14, 30, 'g'), -- puerro
(329, 282, 40, 'g'), -- patata
-- 330. Yogur vegetal con kiwi y semillas de lino
(330, 259, 125, 'g'), -- yogur vegetal
(330, 44, 40, 'g'), -- kiwi
(330, 228, 10, 'g'), -- semillas de lino
-- 331. Ensalada de quinoa, pepino y tomate cherry
(331, 128, 60, 'g'), -- quinoa cocida
(331, 25, 30, 'g'), -- pepino
(331, 258, 30, 'g'), -- tomate cherry
-- 332. Tostadas de pan de centeno con aguacate y tomate
(332, 273, 30, 'g'), -- pan de centeno
(332, 261, 40, 'g'), -- aguacate
(332, 7, 30, 'g'), -- tomate
-- 333. Buddha bowl de arroz integral, garbanzos y zanahoria
(333, 146, 60, 'g'), -- arroz integral
(333, 97, 40, 'g'), -- garbanzos cocidos
(333, 3, 30, 'g'), -- zanahoria
-- 334. Smoothie de mango, espinaca y bebida de avena
(334, 47, 60, 'g'), -- mango
(334, 1, 30, 'g'), -- espinaca
(334, 177, 150, 'ml'), -- bebida de avena
-- 335. Pasta de trigo sarraceno con calabaza y nueces
(335, 150, 60, 'g'), -- trigo sarraceno
(335, 287, 30, 'g'), -- calabaza
(335, 156, 10, 'g'), -- nuez
-- 336. Tortilla de berenjena, cebolla y pimiento rojo
(336, 5, 40, 'g'), -- berenjena
(336, 10, 30, 'g'), -- cebolla
(336, 6, 30, 'g'), -- pimiento rojo
(336, 276, 60, 'g'), -- huevo
-- 337. Porridge de mijo con manzana y semillas de calabaza
(337, 137, 40, 'g'), -- mijo cocido
(337, 36, 50, 'g'), -- manzana
(337, 230, 10, 'g'), -- semillas de calabaza
-- 338. Ensalada de judía roja, tomate y cebolla morada
(338, 99, 60, 'g'), -- judía roja cocida
(338, 7, 30, 'g'), -- tomate
(338, 294, 20, 'g'), -- cebolla morada
-- 339. Crema de col lombarda, puerro y zanahoria
(339, 18, 60, 'g'), -- col lombarda
(339, 14, 30, 'g'), -- puerro
(339, 3, 30, 'g'), -- zanahoria
-- 340. Yogur natural con pera y semillas de chía
(340, 79, 125, 'g'), -- yogur natural
(340, 39, 40, 'g'), -- pera
(340, 227, 10, 'g'), -- semillas de chía
-- 341. Ensalada de amaranto, tomate cherry y pepino
(341, 136, 60, 'g'), -- amaranto cocido
(341, 258, 30, 'g'), -- tomate cherry
(341, 25, 30, 'g'), -- pepino
-- 342. Tostadas de pan sin gluten con hummus y pimiento asado
(342, 154, 30, 'g'), -- pan sin gluten
(342, 257, 40, 'g'), -- hummus
(342, 6, 30, 'g'), -- pimiento rojo
-- 343. Buddha bowl de arroz inflado, edamame y zanahoria
(343, 141, 40, 'g'), -- arroz inflado
(343, 105, 40, 'g'), -- edamame
(343, 3, 30, 'g'), -- zanahoria
-- 344. Smoothie de frambuesa, espinaca y bebida de almendra
(344, 56, 60, 'g'), -- frambuesa
(344, 1, 30, 'g'), -- espinaca
(344, 171, 150, 'ml'), -- bebida de almendra
-- 345. Pasta de maíz con calabaza y pistacho
(345, 147, 60, 'g'), -- maíz
(345, 287, 30, 'g'), -- calabaza
(345, 159, 10, 'g'), -- pistacho
-- 346. Tortilla de col rizada, cebolla y pimiento verde
(346, 19, 40, 'g'), -- col rizada
(346, 10, 30, 'g'), -- cebolla
(346, 293, 30, 'g'), -- pimiento verde
(346, 276, 60, 'g'), -- huevo
-- 347. Porridge de copos de trigo integral con pera y semillas de girasol
(347, 142, 40, 'g'), -- copos de trigo integral
(347, 39, 50, 'g'), -- pera
(347, 231, 10, 'g'), -- semillas de girasol
-- 348. Ensalada de judión, tomate y cebolla
(348, 109, 60, 'g'), -- judión cocido
(348, 7, 30, 'g'), -- tomate
(348, 10, 20, 'g'), -- cebolla
-- 349. Crema de brócoli, puerro y patata
(349, 8, 60, 'g'), -- brócoli
(349, 14, 30, 'g'), -- puerro
(349, 282, 40, 'g'), -- patata
-- 350. Yogur vegetal con manzana y semillas de lino
(350, 259, 125, 'g'), -- yogur vegetal
(350, 36, 40, 'g'), -- manzana
(350, 228, 10, 'g'), -- semillas de lino
-- 351. Ensalada de mijo, pepino y tomate cherry
(351, 137, 60, 'g'), -- mijo cocido
(351, 25, 30, 'g'), -- pepino
(351, 258, 30, 'g'), -- tomate cherry
-- 352. Tostadas de pan integral con hummus y remolacha
(352, 130, 30, 'g'), -- pan integral
(352, 257, 40, 'g'), -- hummus
(352, 17, 30, 'g'), -- remolacha
-- 353. Buddha bowl de arroz blanco, garbanzos y zanahoria
(353, 145, 60, 'g'), -- arroz blanco
(353, 97, 40, 'g'), -- garbanzos cocidos
(353, 3, 30, 'g'), -- zanahoria
-- 354. Smoothie de arándano, espinaca y bebida de avena
(354, 57, 60, 'g'), -- arándano
(354, 1, 30, 'g'), -- espinaca
(354, 177, 150, 'ml'), -- bebida de avena
-- 355. Pasta de bulgur con calabaza y nuez pecana
(355, 133, 60, 'g'), -- bulgur cocido
(355, 287, 30, 'g'), -- calabaza
(355, 163, 10, 'g'), -- nuez pecana
-- 356. Tortilla de coliflor, cebolla y pimiento rojo
(356, 9, 40, 'g'), -- coliflor
(356, 10, 30, 'g'), -- cebolla
(356, 6, 30, 'g'), -- pimiento rojo
(356, 276, 60, 'g'), -- huevo
-- 357. Porridge de copos de maíz con pera y semillas de calabaza
(357, 148, 40, 'g'), -- copos de maíz
(357, 39, 50, 'g'), -- pera
(357, 230, 10, 'g'), -- semillas de calabaza
-- 358. Ensalada de alubia pinta, tomate y cebolla morada
(358, 101, 60, 'g'), -- alubia pinta cocida
(358, 7, 30, 'g'), -- tomate
(358, 294, 20, 'g'), -- cebolla morada
-- 359. Crema de col rizada, puerro y zanahoria
(359, 19, 60, 'g'), -- col rizada
(359, 14, 30, 'g'), -- puerro
(359, 3, 30, 'g'), -- zanahoria
-- 360. Yogur natural con manzana y semillas de chía
(360, 79, 125, 'g'), -- yogur natural
(360, 36, 40, 'g'), -- manzana
(360, 227, 10, 'g'), -- semillas de chía
-- 361. Ensalada de espelta, zanahoria y tomate cherry
(361, 138, 60, 'g'), -- espelta cocida
(361, 3, 30, 'g'), -- zanahoria
(361, 258, 30, 'g'), -- tomate cherry
-- 362. Tostadas de pan de centeno con hummus y pepino
(362, 273, 30, 'g'), -- pan de centeno
(362, 257, 40, 'g'), -- hummus
(362, 25, 30, 'g'), -- pepino
-- 363. Buddha bowl de arroz integral, judía verde y zanahoria
(363, 146, 60, 'g'), -- arroz integral
(363, 24, 40, 'g'), -- judía verde
(363, 3, 30, 'g'), -- zanahoria
-- 364. Smoothie de fresa, espinaca y bebida de avena
(364, 43, 60, 'g'), -- fresa
(364, 1, 30, 'g'), -- espinaca
(364, 177, 150, 'ml'), -- bebida de avena
-- 365. Pasta de trigo sarraceno con calabaza y almendra cruda
(365, 150, 60, 'g'), -- trigo sarraceno
(365, 287, 30, 'g'), -- calabaza
(365, 155, 10, 'g'), -- almendra cruda
-- 366. Tortilla de coles de Bruselas, cebolla y pimiento rojo
(366, 31, 40, 'g'), -- coles de Bruselas
(366, 10, 30, 'g'), -- cebolla
(366, 6, 30, 'g'), -- pimiento rojo
(366, 276, 60, 'g'), -- huevo
-- 367. Porridge de avena con manzana y semillas de sésamo
(367, 127, 40, 'g'), -- avena en copos
(367, 36, 50, 'g'), -- manzana
(367, 229, 10, 'g'), -- semillas de sésamo
-- 368. Ensalada de judía negra, tomate y cebolla morada
(368, 114, 60, 'g'), -- judía negra cocida
(368, 7, 30, 'g'), -- tomate
(368, 294, 20, 'g'), -- cebolla morada
-- 369. Crema de coliflor, puerro y zanahoria
(369, 9, 60, 'g'), -- coliflor
(369, 14, 30, 'g'), -- puerro
(369, 3, 30, 'g'), -- zanahoria
-- 370. Yogur vegetal con mango y semillas de lino
(370, 259, 125, 'g'), -- yogur vegetal
(370, 47, 40, 'g'), -- mango
(370, 227, 10, 'g'), -- semillas de chía
-- 371. Ensalada de bulgur, pepino y tomate cherry
(371, 133, 60, 'g'), -- bulgur cocido
(371, 25, 30, 'g'), -- pepino
(371, 258, 30, 'g'), -- tomate cherry
-- 372. Tostadas de pan integral con hummus y calabacín
(372, 130, 30, 'g'), -- pan integral
(372, 257, 40, 'g'), -- hummus
(372, 4, 30, 'g'), -- calabacín
-- 373. Buddha bowl de arroz blanco, judía roja y zanahoria
(373, 145, 60, 'g'), -- arroz blanco
(373, 99, 40, 'g'), -- judía roja cocida
(373, 3, 30, 'g'), -- zanahoria
-- 374. Smoothie de frambuesa, espinaca y bebida de soja
(374, 56, 60, 'g'), -- frambuesa
(374, 1, 30, 'g'), -- espinaca
(374, 178, 150, 'ml'), -- bebida de soja
-- 375. Pasta de espelta con calabaza y nuez
(375, 138, 60, 'g'), -- espelta cocida
(375, 287, 30, 'g'), -- calabaza
(375, 156, 10, 'g'), -- nuez
-- 376. Tortilla de col lombarda, cebolla y pimiento rojo
(376, 18, 40, 'g'), -- col lombarda
(376, 10, 30, 'g'), -- cebolla
(376, 6, 30, 'g'), -- pimiento rojo
(376, 276, 60, 'g'), -- huevo
-- 377. Porridge de copos de trigo integral con pera y semillas de calabaza
(377, 142, 40, 'g'), -- copos de trigo integral
(377, 39, 50, 'g'), -- pera
(377, 230, 10, 'g'), -- semillas de calabaza
-- 378. Ensalada de alubia pinta, tomate y cebolla
(378, 101, 60, 'g'), -- alubia pinta cocida
(378, 7, 30, 'g'), -- tomate
(378, 10, 20, 'g'), -- cebolla
-- 379. Crema de col rizada, puerro y zanahoria
(379, 19, 60, 'g'), -- col rizada
(379, 14, 30, 'g'), -- puerro
(379, 3, 30, 'g'), -- zanahoria
-- 380. Yogur natural con pera y semillas de chía
(380, 79, 125, 'g'), -- yogur natural
(380, 39, 40, 'g'), -- pera
(380, 227, 10, 'g'), -- semillas de chía
-- 381. Ensalada de quinoa, zanahoria y tomate cherry
(381, 128, 60, 'g'), -- quinoa cocida
(381, 3, 30, 'g'), -- zanahoria
(381, 258, 30, 'g'), -- tomate cherry
-- 382. Tostadas de pan de centeno con hummus y remolacha
(382, 273, 30, 'g'), -- pan de centeno
(382, 257, 40, 'g'), -- hummus
(382, 17, 30, 'g'), -- remolacha
-- 383. Buddha bowl de arroz integral, judía blanca y zanahoria
(383, 146, 60, 'g'), -- arroz integral
(383, 98, 40, 'g'), -- judía blanca cocida
(383, 3, 30, 'g'), -- zanahoria
-- 384. Smoothie de kiwi, espinaca y bebida de avena
(384, 44, 60, 'g'), -- kiwi
(384, 1, 30, 'g'), -- espinaca
(384, 177, 150, 'ml'), -- bebida de avena
-- 385. Pasta de bulgur con calabaza y nuez
(385, 133, 60, 'g'), -- bulgur cocido
(385, 287, 30, 'g'), -- calabaza
(385, 156, 10, 'g'), -- nuez
-- 386. Tortilla de coliflor, cebolla y pimiento verde
(386, 9, 40, 'g'), -- coliflor
(386, 10, 30, 'g'), -- cebolla
(386, 293, 30, 'g'), -- pimiento verde
(386, 276, 60, 'g'), -- huevo
-- 387. Porridge de copos de maíz con manzana y semillas de sésamo
(387, 148, 40, 'g'), -- copos de maíz
(387, 36, 50, 'g'), -- manzana
(387, 229, 10, 'g'), -- semillas de sésamo
-- 388. Ensalada de judía roja, tomate y cebolla
(388, 99, 60, 'g'), -- judía roja cocida
(388, 7, 30, 'g'), -- tomate
(388, 10, 20, 'g'), -- cebolla
-- 389. Crema de col lombarda, puerro y zanahoria
(389, 18, 60, 'g'), -- col lombarda
(389, 14, 30, 'g'), -- puerro
(389, 3, 30, 'g'), -- zanahoria
-- 390. Yogur vegetal con pera y semillas de lino
(390, 259, 125, 'g'), -- yogur vegetal
(390, 39, 40, 'g'), -- pera
(390, 228, 10, 'g'), -- semillas de lino
-- 391. Ensalada de espelta, pepino y tomate cherry
(391, 138, 60, 'g'), -- espelta cocida
(391, 25, 30, 'g'), -- pepino
(391, 258, 30, 'g'), -- tomate cherry
-- 392. Tostadas de pan integral con hummus y zanahoria
(392, 130, 30, 'g'), -- pan integral
(392, 257, 40, 'g'), -- hummus
(392, 3, 30, 'g'), -- zanahoria
-- 393. Buddha bowl de arroz blanco, edamame y zanahoria
(393, 145, 60, 'g'), -- arroz blanco
(393, 105, 40, 'g'), -- edamame
(393, 3, 30, 'g'), -- zanahoria
-- 394. Smoothie de mango, espinaca y bebida de soja
(394, 47, 60, 'g'), -- mango
(394, 1, 30, 'g'), -- espinaca
(394, 178, 150, 'ml'), -- bebida de soja
-- 395. Pasta de trigo sarraceno con calabaza y almendra cruda
(395, 150, 60, 'g'), -- trigo sarraceno
(395, 287, 30, 'g'), -- calabaza
(395, 155, 10, 'g'), -- almendra cruda
-- 396. Tortilla de coles de Bruselas, cebolla y pimiento rojo
(396, 31, 40, 'g'), -- coles de Bruselas
(396, 10, 30, 'g'), -- cebolla
(396, 6, 30, 'g'), -- pimiento rojo
(396, 276, 60, 'g'), -- huevo
-- 397. Porridge de avena con manzana y semillas de calabaza
(397, 127, 40, 'g'), -- avena en copos
(397, 36, 50, 'g'), -- manzana
(397, 230, 10, 'g'), -- semillas de calabaza
-- 398. Ensalada de judía blanca, tomate y cebolla morada
(398, 98, 60, 'g'), -- judía blanca cocida
(398, 7, 30, 'g'), -- tomate
(398, 294, 20, 'g'), -- cebolla morada
-- 399. Crema de coliflor, puerro y zanahoria
(399, 9, 60, 'g'), -- coliflor
(399, 14, 30, 'g'), -- puerro
(399, 3, 30, 'g'), -- zanahoria
-- 400. Yogur natural con mango y semillas de chía
(400, 79, 125, 'g'), -- yogur natural
(400, 47, 40, 'g'), -- mango
(400, 227, 10, 'g'), -- semillas de chía
; 