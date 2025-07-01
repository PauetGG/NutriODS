-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema de zanahoria y lentejas rojas',
    'Una crema suave, nutritiva y reconfortante, perfecta como primer plato.',
    '1. Pela y trocea la zanahoria y la cebolla.\n2. En una olla con aceite de oliva, sofríe la cebolla.\n3. Añade la zanahoria y sofríe un par de minutos.\n4. Agrega las lentejas cocidas y el agua.\n5. Cocina 15 minutos.\n6. Tritura todo hasta obtener una crema fina.\n7. Añade sal al gusto.',
    25,
    'fácil',
    4,
    'https://www.missblasco.com/wp-content/uploads/2020/12/cremadelentejas_vertical.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 3, 300.00),     -- Zanahoria (g)
(@receta_id, 104, 200.00),   -- Lenteja roja cocida (g)
(@receta_id, 10, 100.00),    -- Cebolla (g)
(@receta_id, 242, 10.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00),     -- Sal (g)
(@receta_id, 165, 500.00);   -- Agua mineral (ml)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Revuelto de tofu con verduras',
    'Un plato vegano y saludable, lleno de verduras frescas y tofu, perfecto para un desayuno o cena ligera.',
    '1. Corta el tofu en cubos pequeños y desmenúzalo con un tenedor.\n2. Lava y trocea la zanahoria, el pimiento rojo, el calabacín y la cebolla.\n3. En una sartén con aceite de oliva, sofríe la cebolla hasta que esté transparente.\n4. Añade la zanahoria, el pimiento rojo y el calabacín, cocina 5-7 minutos.\n5. Incorpora el tofu y saltea todo junto 5 minutos más.\n6. Añade sal y pimienta al gusto.\n7. Sirve caliente y disfruta.',
    30,
    'fácil',
    3,
    'https://contexturasysabores.es/wp-content/uploads/2023/03/3uol-CHHQww.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 285, 200.00),   -- Tofu (g)
(@receta_id, 3, 100.00),     -- Zanahoria (g)
(@receta_id, 6, 100.00),     -- Pimiento rojo (g)
(@receta_id, 4, 100.00),     -- Calabacín (g)
(@receta_id, 10, 50.00),     -- Cebolla (g)
(@receta_id, 242, 15.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00),     -- Sal (g)
(@receta_id, 246, 1.00);     -- Pimienta negra (g)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pan integral con tomate y aceite de oliva',
    'Una receta sencilla y deliciosa típica mediterránea, ideal para desayunos o meriendas.',
    '1. Tuesta las rebanadas de pan integral.\n2. Frota el tomate maduro por la superficie del pan tostado hasta que quede impregnado.\n3. Añade un chorrito de aceite de oliva virgen extra por encima.\n4. Agrega sal al gusto.\n5. Sirve inmediatamente para disfrutar del contraste de sabores.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/pan-integral-tomate-aceite.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 130, 100.00),   -- Pan integral (g)
(@receta_id, 265, 80.00),    -- Tomate triturado (g) (usado para untar)
(@receta_id, 242, 15.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 1.50);     -- Sal (g)
-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Curry de garbanzos y arroz',
    'Un plato especiado, nutritivo y reconfortante, ideal para comidas completas vegetarianas.',
    '1. En una olla, sofríe la cebolla picada con aceite de oliva hasta que esté transparente.\n2. Añade el curry y las especias al gusto y remueve durante un minuto.\n3. Incorpora los garbanzos cocidos y mezcla bien.\n4. Añade el tomate triturado y cocina 10 minutos a fuego medio.\n5. Mientras tanto, cocina el arroz integral según las instrucciones del paquete.\n6. Sirve el curry sobre una cama de arroz caliente.',
    40,
    'media',
    4,
    'https://ejemplo.com/curry-garbanzos-arroz.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 10, 100.00),    -- Cebolla (g)
(@receta_id, 250, 10.00),    -- Curry (g)
(@receta_id, 97, 300.00),    -- Garbanzos cocidos (g)
(@receta_id, 265, 150.00),   -- Tomate triturado (g)
(@receta_id, 242, 20.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 126, 200.00);   -- Arroz integral cocido (g)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Sopa de verduras con huevo duro',
    'Una sopa reconfortante y nutritiva hecha con una variedad de verduras y un toque de proteína gracias al huevo duro.',
    '1. Lava y trocea la zanahoria, el calabacín, el puerro y la col.\n2. En una olla con aceite de oliva, sofríe el puerro picado.\n3. Añade el resto de las verduras y rehoga 5 minutos.\n4. Incorpora el agua mineral y cocina a fuego medio durante 20 minutos.\n5. Añade sal al gusto.\n6. Mientras tanto, cuece los huevos, pélalos y córtalos por la mitad.\n7. Sirve la sopa caliente con medio huevo duro por ración.',
    35,
    'fácil',
    4,
    'https://ejemplo.com/sopa-verduras-huevo.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 3, 100.00),     -- Zanahoria (g)
(@receta_id, 4, 100.00),     -- Calabacín (g)
(@receta_id, 14, 80.00),     -- Puerro (g)
(@receta_id, 20, 100.00),    -- Repollo (g)
(@receta_id, 165, 600.00),   -- Agua mineral (ml)
(@receta_id, 242, 10.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00),     -- Sal (g)
(@receta_id, 262, 4.00);     -- Huevo duro (unidad, 1 por ración)


-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Hamburguesa de lentejas y ensalada verde',
    'Una hamburguesa vegetal saludable hecha a base de lentejas cocidas y acompañada de una fresca ensalada verde.',
    '1. Tritura las lentejas cocidas con cebolla, ajo y especias hasta formar una masa moldeable.\n2. Forma hamburguesas y cocínalas en una sartén con un poco de aceite hasta que estén doradas por ambos lados.\n3. Lava y corta la lechuga y el tomate.\n4. Sirve la hamburguesa sobre una cama de ensalada verde.\n5. Añade un chorrito de aceite de oliva y sal al gusto.',
    30,
    'media',
    2,
    'https://ejemplo.com/hamburguesa-lentejas-ensalada.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 96, 250.00),    -- Lenteja cocida (g)
(@receta_id, 10, 50.00),     -- Cebolla (g)
(@receta_id, 6, 40.00),      -- Pimiento rojo (g)
(@receta_id, 284, 100.00),   -- Ensalada verde (g)
(@receta_id, 7, 50.00),      -- Tomate (g)
(@receta_id, 242, 10.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00);     -- Sal (g)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tarta de queso',
    'Una tarta suave y cremosa elaborada con queso fresco, yogur y una base crujiente. Ideal como postre.',
    '1. Tritura las galletas sin gluten y mézclalas con la mantequilla derretida. Coloca en la base de un molde y presiona bien.\n2. En un bol, bate el queso fresco, el yogur y la leche condensada hasta obtener una mezcla homogénea.\n3. Añade los huevos uno a uno y mezcla.\n4. Vierte la mezcla sobre la base de galleta y hornea a 170°C durante 45 minutos.\n5. Deja enfriar y refrigera al menos 4 horas antes de servir.',
    60,
    'media',
    6,
    'https://ejemplo.com/tarta-de-queso.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 263, 150.00),   -- Galletas sin gluten (g)
(@receta_id, 85, 70.00),     -- Mantequilla (g)
(@receta_id, 81, 250.00),    -- Queso fresco (g)
(@receta_id, 79, 125.00),    -- Yogur natural (g)
(@receta_id, 87, 200.00),    -- Leche condensada (g)
(@receta_id, 276, 2.00);     -- Huevo (unidad)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Brochetas de pavo y pimiento',
    'Una opción ligera y sabrosa para almuerzos o cenas. El pavo a la plancha con pimiento rojo es una combinación perfecta.',
    '1. Corta la pechuga de pavo en dados grandes.\n2. Lava y corta el pimiento rojo en trozos del mismo tamaño.\n3. Inserta alternadamente el pavo y el pimiento en brochetas.\n4. Rocía con aceite de oliva y añade sal al gusto.\n5. Cocina a la plancha o grill 5-6 minutos por cada lado hasta que el pavo esté dorado y cocido.\n6. Sirve caliente acompañado de una guarnición si se desea.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/brochetas-pavo-pimiento.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 208, 200.00),   -- Pechuga de pavo cocida (g)
(@receta_id, 6, 100.00),     -- Pimiento rojo (g)
(@receta_id, 242, 10.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00);     -- Sal (g)


-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Trucha al horno con almendras',
    'Una receta saludable y con un toque crujiente. La trucha se hornea con láminas de almendra para un resultado jugoso y sabroso.',
    '1. Precalienta el horno a 180°C.\n2. Limpia la trucha y colócala en una bandeja para horno.\n3. Rocía con aceite de oliva, añade sal y pimienta al gusto.\n4. Cubre la superficie con almendras crudas laminadas.\n5. Hornea durante 20-25 minutos hasta que esté cocida y las almendras doradas.\n6. Sirve caliente con una guarnición de verduras o ensalada.',
    30,
    'fácil',
    2,
    'https://ejemplo.com/trucha-almendras-horno.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 124, 300.00),   -- Trucha (g)
(@receta_id, 155, 40.00),    -- Almendra cruda (g)
(@receta_id, 242, 10.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00),     -- Sal (g)
(@receta_id, 246, 1.00);     -- Pimienta negra (g)


-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Sopa de pescado ligera',
    'Una sopa baja en grasas y muy sabrosa, perfecta como primer plato o cena ligera. Elaborada con pescado blanco y verduras frescas.',
    '1. Lava y trocea la zanahoria y el puerro.\n2. En una olla, sofríe el puerro con un poco de aceite de oliva.\n3. Añade la zanahoria y rehoga 2-3 minutos.\n4. Incorpora el pescado blanco troceado, agua mineral, sal y pimienta.\n5. Cocina a fuego medio durante 20 minutos.\n6. Sirve caliente y disfruta de una sopa saludable y reconfortante.',
    30,
    'fácil',
    3,
    'https://ejemplo.com/sopa-pescado-ligera.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 291, 120.00),   -- Pescado blanco (g)
(@receta_id, 3, 40.00),      -- Zanahoria (g)
(@receta_id, 14, 30.00),     -- Puerro (g)
(@receta_id, 165, 500.00),   -- Agua mineral (ml)
(@receta_id, 242, 10.00),    -- Aceite de oliva virgen extra (ml)
(@receta_id, 245, 2.00),     -- Sal (g)
(@receta_id, 246, 1.00);     -- Pimienta negra (g)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur griego con higos y miel',
    'Un postre rápido, natural y delicioso, que combina la cremosidad del yogur con la dulzura de los higos y la miel.',
    '1. Coloca el yogur griego en un bol o vaso.\n2. Lava y corta los higos frescos en cuartos.\n3. Añade los higos por encima del yogur.\n4. Rocía con miel al gusto.\n5. Sirve frío.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-higos-miel.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 80, 125.00),   -- Yogur griego 0% (g)
(@receta_id, 72, 2.00),     -- Higo fresco (unidad, pero indicado en gramos)
(@receta_id, 239, 10.00);   -- Miel (g)


-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Batido de avena, dátil y canela',
    'Un batido energético y natural, ideal para el desayuno o como merienda saludable.',
    '1. Coloca la avena en copos, los dátiles sin hueso y la canela en un vaso batidor.\n2. Añade 200 ml de bebida vegetal o agua (opcional).\n3. Tritura todo hasta obtener un batido cremoso.\n4. Sirve frío o con hielo al gusto.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/batido-avena-datil-canela.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 127, 50.00),   -- Avena en copos (g)
(@receta_id, 63, 2.00),     -- Dátil seco (unidad o g, según registro)
(@receta_id, 248, 2.00);    -- Canela en polvo (g)

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Sopa de cebolla gratinada',
    'Una receta tradicional francesa reconfortante, con cebolla caramelizada, pan tostado y queso gratinado por encima.',
    '1. Corta las cebollas en juliana fina.\n2. En una olla con aceite de oliva, cocina las cebollas a fuego lento hasta que estén doradas y caramelizadas (unos 20 minutos).\n3. Añade agua mineral y sal, y cocina 10 minutos más.\n4. Tuesta el pan blanco y colócalo sobre la sopa en cuencos individuales.\n5. Cubre con queso curado rallado.\n6. Gratina en horno o grill hasta que el queso esté dorado y burbujeante.\n7. Sirve bien caliente.',
    40,
    'media',
    2,
    'https://ejemplo.com/sopa-cebolla-gratinada.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 10, 200.00),   -- Cebolla (g)
(@receta_id, 129, 40.00),   -- Pan blanco (g)
(@receta_id, 82, 30.00),    -- Queso curado (g)
(@receta_id, 165, 500.00),  -- Agua mineral (ml)
(@receta_id, 245, 2.00);    -- Sal (g)


-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pechuga de pollo villaroy',
    'Pechuga de pollo empanada y gratinada con nata para cocinar, un plato cremoso y delicioso.',
    '1. Corta las pechugas de pollo en filetes.\n2. Pasa los filetes por harina de trigo, sacudiendo el exceso.\n3. Fríelos en una sartén con aceite hasta que estén dorados por ambos lados.\n4. Coloca los filetes en una fuente para horno.\n5. Cubre con nata para cocinar.\n6. Hornea a 180°C durante 15-20 minutos hasta que esté gratinado.\n7. Sirve caliente acompañado de verduras o ensalada.',
    40,
    'media',
    3,
    'https://ejemplo.com/pechuga-pollo-villaroy.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 281, 120.00),   -- Pollo (g)
(@receta_id, 139, 30.00),    -- Harina de trigo (g)
(@receta_id, 88, 50.00);     -- Nata para cocinar (ml)

-- 1. Insertar la receta 252
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas francesas con pan integral y fruta',
    'Tostadas francesas dulces con pan integral y una guarnición de frutos rojos frescos.',
    '1. Bate el huevo en un bol.\n2. Remoja las rebanadas de pan integral en el huevo.\n3. Fríe las rebanadas en una sartén con un poco de mantequilla hasta que estén doradas.\n4. Sirve con frutos rojos por encima o al lado.\n5. Disfruta caliente.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/tostadas-francesas-pan-integral-fruta.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 252
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 252
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 130, 60.00),    -- Pan integral (g)
(@receta_id, 276, 1.00),     -- Huevo (unidad)
(@receta_id, 274, 50.00);    -- Frutos rojos (g)

-- 1. Insertar la receta 253
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Lentejas a la jardinera',
    'Un plato tradicional de lentejas con verduras frescas y sabor casero.',
    '1. Lava y trocea la zanahoria y las judías verdes.\n2. En una olla con aceite de oliva, sofríe la cebolla.\n3. Añade las verduras y rehoga unos minutos.\n4. Incorpora las lentejas cocidas y agua.\n5. Cocina a fuego medio 20 minutos.\n6. Ajusta de sal y sirve caliente.',
    40,
    'media',
    4,
    'https://ejemplo.com/lentejas-jardinera.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 253
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 253
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 96, 120.00),    -- Lenteja cocida (g)
(@receta_id, 3, 50.00),      -- Zanahoria (g)
(@receta_id, 24, 40.00);     -- Judía verde (g)

-- 1. Insertar la receta 254
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Cogollos a la plancha con anchoas y ajos',
    'Una receta ligera y sabrosa que combina cogollos a la plancha con anchoas y un toque de ajo.',
    '1. Lava y corta los cogollos (lechuga romana).\n2. Pela y lamina el ajo.\n3. En una sartén con aceite de oliva, sofríe el ajo.\n4. Añade los cogollos y las anchoas, cocina 5 minutos a fuego medio.\n5. Salpimienta al gusto y sirve caliente.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/cogollos-anchoas-ajos.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 254
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 254
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 11, 150.00),    -- Lechuga romana (g)
(@receta_id, 291, 30.00),    -- Pescado blanco (anchoa) (g)
(@receta_id, 10, 20.00);     -- Cebolla (ajo) (g)


-- 1. Insertar la receta 259
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Salmón en papillote con verduras',
    'Una receta ligera y sabrosa donde el salmón se cocina al papillote acompañado de verduras al vapor y un toque cítrico de refresco de limón.',
    '1. Precalienta el horno a 180°C.\n2. Coloca el salmón y las verduras al vapor en papel de aluminio.\n3. Añade un chorrito de refresco de limón.\n4. Cierra el papillote y hornea durante 20-25 minutos.\n5. Sirve caliente y disfruta de una comida saludable y rápida.',
    35,
    'fácil',
    2,
    'https://ejemplo.com/salmon-papillote-verduras.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 259
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 259
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 117, 150.00),   -- Salmón (g)
(@receta_id, 292, 120.00),   -- Verduras al vapor (g)
(@receta_id, 191, 10.00);    -- Refresco de limón (ml)

-- 1. Insertar la receta 260
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Alcachofas al horno con jamón',
    'Un plato sabroso y tradicional que combina alcachofas horneadas con jamón serrano y un toque de aceite de oliva.',
    '1. Precalienta el horno a 180°C.\n2. Limpia y corta las alcachofas.\n3. Coloca las alcachofas en una fuente para horno.\n4. Añade el jamón serrano picado por encima.\n5. Rocía con aceite de oliva.\n6. Hornea durante 20-25 minutos hasta que estén tiernas y doradas.\n7. Sirve caliente.',
    40,
    'fácil',
    3,
    'https://ejemplo.com/alcachofas-horno-jamon.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 260
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 260
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 23, 200.00),    -- Alcachofa (g)
(@receta_id, 205, 40.00),    -- Jamón serrano (g)
(@receta_id, 242, 10.00);    -- Aceite de oliva virgen extra (ml)

-- 1. Insertar la receta 88
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de quinoa y garbanzos',
    'Ensalada fresca y nutritiva que combina quinoa, garbanzos y espinaca para un plato completo y saludable.',
    '1. Cocina la quinoa según instrucciones del paquete y deja enfriar.\n2. En un bol grande, mezcla la quinoa cocida, garbanzos cocidos y espinaca fresca.\n3. Aliña al gusto con aceite de oliva, sal y pimienta.\n4. Sirve fría o a temperatura ambiente.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-quinoa-garbanzos.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 88
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 88
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 149, 60.00),  -- Quinoa (g)
(@receta_id, 97, 100.00),  -- Garbanzos cocidos (g)
(@receta_id, 1, 30.00);    -- Espinaca (g)

-- 1. Insertar la receta 89
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema de calabaza con pan de centeno',
    'Deliciosa crema de calabaza suave acompañada de pan de centeno tostado para mojar.',
    '1. Pela y corta la calabaza y el puerro.\n2. En una olla con aceite de oliva, sofríe el puerro.\n3. Añade la calabaza y rehoga 5 minutos.\n4. Incorpora agua mineral y cocina 20 minutos.\n5. Tritura hasta obtener una crema homogénea.\n6. Sirve con pan de centeno tostado y ajusta la sal al gusto.',
    30,
    'fácil',
    4,
    'https://ejemplo.com/crema-calabaza-pan-centeno.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 89
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 89
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 287, 150.00), -- Calabaza (g)
(@receta_id, 273, 50.00),  -- Pan de centeno (g)
(@receta_id, 14, 20.00);   -- Puerro (g)

-- 1. Insertar la receta 90
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Desayuno de yogur vegetal con frutas rojas',
    'Desayuno fresco y saludable con yogur vegetal y una mezcla de frutos rojos y manzana.',
    '1. Coloca el yogur vegetal en un bol.\n2. Añade los frutos rojos y la manzana cortada en trozos.\n3. Mezcla ligeramente y sirve frío.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-vegetal-frutas-rojas.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 90
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 90
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00), -- Yogur vegetal (g)
(@receta_id, 274, 40.00),  -- Frutos rojos (g)
(@receta_id, 36, 1.00);    -- Manzana (unidad, aquí en g)

-- 1. Insertar la receta 91
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Hamburguesa vegetal con ensalada verde',
    'Hamburguesa vegetal acompañada de una ensalada fresca y tomate triturado.',
    '1. Cocina la hamburguesa vegetal según instrucciones.\n2. Prepara la ensalada verde lavando bien las hojas.\n3. Sirve la hamburguesa acompañada de la ensalada y tomate triturado.\n4. Aliña al gusto.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/hamburguesa-vegetal-ensalada.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 91
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 91
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 220, 100.00), -- Hamburguesa vegetal (g)
(@receta_id, 284, 60.00),  -- Ensalada verde (g)
(@receta_id, 265, 40.00);  -- Tomate triturado (g)

-- 1. Insertar la receta 92
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tofu con verduras al vapor y arroz integral',
    'Plato saludable con tofu, verduras al vapor y arroz integral cocido, perfecto para dieta equilibrada.',
    '1. Cocina el tofu y las verduras al vapor.\n2. Cocina el arroz integral.\n3. Sirve el tofu junto con las verduras y el arroz.\n4. Añade sal y aceite de oliva al gusto.',
    30,
    'fácil',
    3,
    'https://ejemplo.com/tofu-verduras-arroz-integral.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 92
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 92
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 285, 100.00), -- Tofu (g)
(@receta_id, 292, 100.00), -- Verduras al vapor (g)
(@receta_id, 146, 60.00);  -- Arroz integral (g)


-- 1. Insertar la receta 95
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Merluza al horno con puré de patata',
    'Merluza horneada acompañada de puré de patata y calabacín salteado, plato nutritivo y sabroso.',
    '1. Precalienta el horno a 180°C.\n2. Coloca la merluza en una fuente apta para horno.\n3. Hornea durante 15-20 minutos hasta que esté hecha.\n4. Cocina la patata y haz un puré.\n5. Saltea el calabacín en trozos con un poco de aceite.\n6. Sirve la merluza junto al puré y el calabacín.\n7. Añade sal y pimienta al gusto.',
    40,
    'media',
    2,
    'https://ejemplo.com/merluza-horno-pure-patata.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 95
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 95
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 116, 100.00),  -- Merluza (g)
(@receta_id, 282, 150.00),  -- Patata (g)
(@receta_id, 4, 50.00);     -- Calabacín (g)

-- 1. Insertar la receta 96
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Batido vegetal con avena y plátano',
    'Batido natural y energético con bebida vegetal de avena, avena en copos y plátano.',
    '1. En una batidora, mezcla la bebida de avena, los copos de avena y el plátano pelado.\n2. Tritura hasta obtener una mezcla homogénea.\n3. Sirve frío y disfruta.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/batido-avena-platano.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 96
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 96
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 177, 150.00),  -- Bebida de avena (ml)
(@receta_id, 127, 30.00),   -- Avena en copos (g)
(@receta_id, 37, 1.00);     -- Plátano (unidad, aquí en g)

-- 1. Insertar la receta 97
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Espaguetis integrales con verduras salteadas',
    'Espaguetis integrales acompañados de verduras salteadas y tomate triturado para un plato equilibrado.',
    '1. Cocina los espaguetis integrales según instrucciones del paquete.\n2. Saltea las verduras en una sartén con aceite.\n3. Calienta el tomate triturado.\n4. Mezcla todo y sirve caliente.',
    30,
    'fácil',
    3,
    'https://ejemplo.com/espaguetis-verduras.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 97
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 97
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 289, 80.00),  -- Pasta integral (g)
(@receta_id, 286, 100.00), -- Verduras salteadas (g)
(@receta_id, 265, 40.00);  -- Tomate triturado (g)

-- 1. Insertar la receta 98
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Bowl de arroz integral con verduras y huevo',
    'Bowl equilibrado con arroz integral, verduras salteadas y huevo para una comida completa y nutritiva.',
    '1. Cocina el arroz integral según indicaciones.\n2. Saltea las verduras.\n3. Cocina el huevo (duro o a tu gusto).\n4. Monta el bowl con arroz, verduras y huevo.\n5. Añade sal y aceite al gusto.',
    30,
    'media',
    2,
    'https://ejemplo.com/bowl-arroz-verduras-huevo.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 98
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 98
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 146, 60.00),    -- Arroz integral (g)
(@receta_id, 286, 100.00),   -- Verduras salteadas (g)
(@receta_id, 276, 1.00);     -- Huevo (unidad)

-- 1. Insertar la receta 99
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta sin gluten con hummus y tomate cherry',
    'Plato sencillo y sabroso con pasta sin gluten, hummus cremoso y tomate cherry fresco.',
    '1. Cocina la pasta sin gluten según instrucciones.\n2. Escurre y mezcla con hummus.\n3. Añade tomate cherry partido a la mitad.\n4. Sirve frío o templado.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/pasta-hummus-tomate-cherry.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 99
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 99
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 283, 80.00),    -- Pasta sin gluten (g)
(@receta_id, 257, 50.00),    -- Hummus (g)
(@receta_id, 258, 40.00);    -- Tomate cherry (g)

-- 1. Insertar la receta 100
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de maíz con aguacate y kiwi',
    'Tostadas crujientes de maíz con cremoso aguacate y fresco kiwi para un desayuno o snack saludable.',
    '1. Tuesta las tostadas de maíz.\n2. Machaca el aguacate y extiéndelo sobre las tostadas.\n3. Añade rodajas de kiwi por encima.\n4. Opcional: añade sal y pimienta.\n5. Sirve inmediatamente.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-maiz-aguacate-kiwi.jpg',
    TRUE
);

-- 2. Obtener ID de la receta 100
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar ingredientes receta 100
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 268, 40.00),   -- Tostadas de maíz (g)
(@receta_id, 261, 30.00),   -- Aguacate (g)
(@receta_id, 44, 1.00);     -- Kiwi (unidad)

--

-- 1. Insertar receta 111
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Batido de avena con plátano y fresa',
    'Batido natural, energético y saludable con bebida de avena, plátano y fresas frescas.',
    '1. Mezcla la bebida de avena, el plátano pelado y las fresas.\n2. Tritura en batidora hasta obtener una textura homogénea.\n3. Sirve frío.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/batido-avena-platano-fresa.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 177, 150.00),  -- Bebida de avena (ml)
(@receta_id, 37, 1.00),     -- Plátano (unidad)
(@receta_id, 43, 50.00);    -- Fresa (g)

-- 1. Insertar receta 112
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta integral con espinacas y tomate',
    'Plato saludable de pasta integral con espinacas frescas y tomate natural.',
    '1. Cocina la pasta integral según instrucciones.\n2. Saltea las espinacas.\n3. Añade el tomate troceado.\n4. Mezcla todo y sirve caliente.',
    30,
    'fácil',
    2,
    'https://ejemplo.com/pasta-integral-espinacas-tomate.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 289, 80.00),  -- Pasta integral (g)
(@receta_id, 1, 50.00),    -- Espinaca (g)
(@receta_id, 7, 40.00);    -- Tomate (g)

-- 1. Insertar receta 113
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Guiso de lentejas verdes con zanahoria',
    'Guiso tradicional con lentejas verdes, zanahoria y puerro, ideal para días fríos.',
    '1. Sofríe el puerro.\n2. Añade la zanahoria y rehoga.\n3. Incorpora las lentejas y agua.\n4. Cocina hasta que estén tiernas.\n5. Salpimienta al gusto.',
    45,
    'media',
    4,
    'https://ejemplo.com/guiso-lentejas-verdes.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 107, 80.00),  -- Lenteja verde cocida (g)
(@receta_id, 3, 60.00),    -- Zanahoria (g)
(@receta_id, 14, 30.00);   -- Puerro (g)

-- 1. Insertar receta 114
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Bocadillo de pan sin gluten con hummus y espinaca',
    'Bocadillo ligero y nutritivo con pan sin gluten, hummus cremoso y espinaca fresca.',
    '1. Unta el hummus en el pan sin gluten.\n2. Añade las hojas de espinaca.\n3. Cierra el bocadillo y sirve.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/bocadillo-hummus-espinaca.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 154, 50.00),  -- Pan sin gluten (g)
(@receta_id, 257, 40.00),  -- Hummus (g)
(@receta_id, 1, 30.00);    -- Espinaca (g)

-- 1. Insertar receta 115
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur vegetal con granada y nuez',
    'Postre o snack saludable con yogur vegetal, granada fresca y nueces crujientes.',
    '1. Sirve el yogur vegetal en un bol.\n2. Añade los granos de granada.\n3. Espolvorea nueces picadas por encima.\n4. Disfruta.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-granada-nuez.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00), -- Yogur vegetal (g)
(@receta_id, 68, 40.00),   -- Granada (g)
(@receta_id, 156, 10.00);  -- Nuez (g)

-- 1. Insertar receta 116
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Trucha al horno con calabacín y arroz',
    'Trucha horneada acompañada de calabacín salteado y arroz blanco cocido.',
    '1. Hornea la trucha a 180°C durante 20 minutos.\n2. Saltea el calabacín.\n3. Cocina el arroz blanco.\n4. Sirve junto y añade sal y pimienta al gusto.',
    45,
    'media',
    2,
    'https://ejemplo.com/trucha-horno-calabacin-arroz.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 124, 100.00), -- Trucha (g)
(@receta_id, 4, 60.00),    -- Calabacín (g)
(@receta_id, 145, 60.00);  -- Arroz blanco (g)

-- 1. Insertar receta 117
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema de espinacas con pan integral',
    'Suave crema de espinacas acompañada de pan integral tostado para un plato reconfortante.',
    '1. Cocina las espinacas y el puerro.\n2. Tritura hasta obtener una crema.\n3. Sirve con pan integral tostado.\n4. Ajusta sal y pimienta.',
    30,
    'fácil',
    3,
    'https://ejemplo.com/crema-espinacas-pan-integral.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 1, 100.00),   -- Espinaca (g)
(@receta_id, 14, 30.00),   -- Puerro (g)
(@receta_id, 130, 40.00);  -- Pan integral (g)

-- 1. Insertar receta 118
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de garbanzos con tomate y cebolla',
    'Ensalada fresca y nutritiva con garbanzos cocidos, tomate y cebolla.',
    '1. Mezcla los garbanzos cocidos con tomate y cebolla picados.\n2. Aliña con aceite, sal y pimienta.\n3. Sirve fría.',
    15,
    'fácil',
    3,
    'https://ejemplo.com/ensalada-garbanzos-tomate-cebolla.jpg',
    TRUE
);

SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 97, 100.00),  -- Garbanzos cocidos (g)
(@receta_id, 7, 50.00),    -- Tomate (g)
(@receta_id, 10, 30.00);   -- Cebolla (g)

-- Receta 120: Pechuga de pavo con quinoa y calabacín
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pechuga de pavo con quinoa y calabacín',
    'Plato nutritivo con pechuga de pavo cocida, quinoa y calabacín salteado.',
    '1. Cocina la pechuga de pavo.\n2. Cocina la quinoa según indicaciones.\n3. Saltea el calabacín.\n4. Sirve todo junto.',
    30, 'fácil', 2,
    'https://ejemplo.com/pechuga-pavo-quinoa-calabacin.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 207, 100.00),   -- Pechuga de pavo cocida
(@receta_id, 149, 60.00),    -- Quinoa cocida
(@receta_id, 4, 60.00);      -- Calabacín

-- Receta 121: Bocadillo de pan integral con aguacate y huevo
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Bocadillo de pan integral con aguacate y huevo',
    'Bocadillo sencillo y saludable con pan integral, aguacate y huevo duro.',
    '1. Tuesta el pan integral.\n2. Añade aguacate machacado.\n3. Coloca huevo duro en rodajas.\n4. Sirve y disfruta.',
    10, 'fácil', 1,
    'https://ejemplo.com/bocadillo-pan-aguacate-huevo.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 130, 40.00),    -- Pan integral
(@receta_id, 261, 30.00),    -- Aguacate
(@receta_id, 276, 1.00);     -- Huevo

-- Receta 122: Yogur vegetal con frambuesas y sirope de agave
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur vegetal con frambuesas y sirope de agave',
    'Postre saludable con yogur vegetal, frambuesas frescas y sirope de agave.',
    '1. Sirve el yogur en un bol.\n2. Añade frambuesas.\n3. Riega con sirope de agave.\n4. Disfruta.',
    5, 'fácil', 1,
    'https://ejemplo.com/yogur-frambuesas-sirope.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00),   -- Yogur vegetal
(@receta_id, 53, 40.00),     -- Frambuesa
(@receta_id, 244, 5.00);    -- Sirope de agave

-- Receta 123: Lentejas con arroz y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Lentejas con arroz y zanahoria',
    'Plato tradicional con lentejas cocidas, arroz blanco y zanahoria.',
    '1. Cocina lentejas y arroz por separado.\n2. Añade zanahoria rallada o en cubos.\n3. Mezcla y sirve caliente.',
    40, 'media', 4,
    'https://ejemplo.com/lentejas-arroz-zanahoria.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 96, 80.00),     -- Lenteja cocida
(@receta_id, 145, 60.00),    -- Arroz blanco
(@receta_id, 3, 50.00);      -- Zanahoria

-- Receta 124: Sopa de fideos de arroz con espinacas
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Sopa de fideos de arroz con espinacas',
    'Sopa ligera y nutritiva con fideos de arroz y espinacas frescas.',
    '1. Cocina los fideos de arroz.\n2. Añade espinacas frescas.\n3. Calienta todo y sirve.',
    20, 'fácil', 3,
    'https://ejemplo.com/sopa-fideos-arroz-espinacas.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 142, 60.00),    -- Fideos de arroz
(@receta_id, 1, 40.00),      -- Espinaca
(@receta_id, 14, 20.00);     -- Puerro

-- Receta 125: Tostadas integrales con tomate y jamón cocido
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas integrales con tomate y jamón cocido',
    'Tostadas integrales con tomate fresco y jamón cocido, ideales para un desayuno o merienda.',
    '1. Tuesta las tostadas integrales.\n2. Añade tomate triturado.\n3. Coloca el jamón cocido encima.\n4. Sirve y disfruta.',
    10, 'fácil', 2,
    'https://ejemplo.com/tostadas-tomate-jamon.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 278, 30.00),    -- Tostadas integrales
(@receta_id, 7, 40.00),      -- Tomate
(@receta_id, 199, 60.00);    -- Jamón cocido (York)

-- Receta 126: Hamburguesa vegetal con arroz y verduras
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Hamburguesa vegetal con arroz y verduras',
    'Hamburguesa vegetal acompañada de arroz integral y verduras al vapor, ideal para dieta equilibrada.',
    '1. Cocina la hamburguesa vegetal.\n2. Cocina el arroz integral.\n3. Cocina las verduras al vapor.\n4. Sirve todo junto.',
    25, 'fácil', 1,
    'https://ejemplo.com/hamburguesa-vegetal-arroz-verduras.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 220, 1.00),     -- Hamburguesa vegetal (no vegana)
(@receta_id, 146, 60.00),    -- Arroz integral
(@receta_id, 292, 80.00);    -- Verduras al vapor

-- Receta 127: Pisto de verduras con huevo y pan integral
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pisto de verduras con huevo y pan integral',
    'Pisto tradicional de verduras acompañado de huevo y pan integral tostado.',
    '1. Cocina el pisto.\n2. Añade el huevo duro o frito.\n3. Sirve con pan integral tostado.\n4. Ajusta sal al gusto.',
    40, 'media', 3,
    'https://ejemplo.com/pisto-verduras-huevo-pan.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();

INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 280, 100.00),   -- Pisto
(@receta_id, 276, 1.00),     -- Huevo
(@receta_id, 130, 30.00);    -- Pan integral

-- 305. Pasta integral con brócoli, tomate cherry y queso fresco
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta integral con brócoli, tomate cherry y queso fresco',
    'Una deliciosa y saludable pasta con vegetales frescos y queso.',
    '1. Cocina la pasta integral. 2. Saltea el brócoli y los tomates cherry. 3. Mezcla todo con queso fresco.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/pasta-brocoli-tomate.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 289, 70.00), -- pasta integral
(@receta_id, 8, 40.00), -- brócoli
(@receta_id, 258, 30.00), -- tomate cherry
(@receta_id, 81, 40.00); -- queso fresco

-- 306. Tortilla de espinacas, cebolla y champiñón
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de espinacas, cebolla y champiñón',
    'Una tortilla rica en nutrientes y muy fácil de preparar.',
    '1. Saltea la cebolla, los champiñones y las espinacas. 2. Bate los huevos y mézclalos con las verduras. 3. Cocina la tortilla.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-espinacas-champinon.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 1, 40.00), -- espinaca
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 32, 30.00), -- champiñón
(@receta_id, 276, 60.00); -- huevo

-- 307. Porridge de avena con manzana, nueces y canela
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de avena con manzana, nueces y canela',
    'Un desayuno caliente, saciante y lleno de sabor.',
    '1. Cocina la avena con leche o agua. 2. Añade manzana troceada, nueces y canela.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/porridge-manzana-nueces.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 127, 40.00), -- avena en copos
(@receta_id, 36, 50.00), -- manzana
(@receta_id, 156, 10.00), -- nuez
(@receta_id, 248, 1.00); -- canela en polvo

-- 308. Ensalada templada de lenteja beluga, zanahoria y huevo duro
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada templada de lenteja beluga, zanahoria y huevo duro',
    'Una ensalada completa y nutritiva, perfecta para cualquier estación.',
    '1. Cuece las lentejas beluga. 2. Ralla la zanahoria y cuece el huevo. 3. Mezcla todo y aliña.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-lenteja-beluga.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 106, 60.00), -- lenteja beluga cocida
(@receta_id, 3, 40.00), -- zanahoria
(@receta_id, 276, 60.00); -- huevo

-- 309. Crema suave de calabaza, puerro y patata
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema suave de calabaza, puerro y patata',
    'Una crema reconfortante y muy suave, ideal para cenas ligeras.',
    '1. Rehoga el puerro. 2. Añade la calabaza y la patata troceadas y cubre con agua. 3. Cocina y tritura.',
    30,
    'fácil',
    4,
    'https://ejemplo.com/crema-calabaza-puerro.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 287, 80.00), -- calabaza
(@receta_id, 14, 30.00), -- puerro
(@receta_id, 282, 40.00); -- patata

-- 310. Yogur natural con frutos rojos y semillas de lino
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur natural con frutos rojos y semillas de lino',
    'Un postre o desayuno rápido, sano y delicioso.',
    '1. Sirve el yogur en un bol. 2. Añade los frutos rojos y espolvorea las semillas de lino.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-frutos-rojos-lino.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 79, 125.00), -- yogur natural
(@receta_id, 274, 40.00), -- frutos rojos
(@receta_id, 228, 10.00); -- semillas de lino

-- 311. Ensalada de espelta, tomate seco y rúcula
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de espelta, tomate seco y rúcula',
    'Una ensalada con un toque gourmet, nutritiva y llena de sabor.',
    '1. Cuece la espelta. 2. Hidrata los tomates secos. 3. Mezcla con la rúcula y aliña.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-espelta-tomate-seco.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 138, 60.00), -- espelta cocida
(@receta_id, 291, 20.00), -- tomate seco
(@receta_id, 292, 20.00); -- rúcula

-- 312. Tostadas de pan de centeno con aguacate y huevo poché
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan de centeno con aguacate y huevo poché',
    'Un desayuno o brunch delicioso y muy fotogénico.',
    '1. Tuesta el pan. 2. Unta el aguacate. 3. Prepara el huevo poché y colócalo encima.',
    15,
    'media',
    1,
    'https://ejemplo.com/tostadas-aguacate-huevo-poche.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 273, 30.00), -- pan de centeno
(@receta_id, 261, 50.00), -- aguacate
(@receta_id, 276, 60.00); -- huevo

-- 313. Buddha bowl de arroz integral, edamame y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz integral, edamame y zanahoria',
    'Un bol completo, colorido y muy saludable.',
    '1. Cuece el arroz integral. 2. Cuece los edamames. 3. Ralla la zanahoria. 4. Monta el bol.',
    30,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-edamame.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 146, 60.00), -- arroz integral
(@receta_id, 105, 40.00), -- edamame
(@receta_id, 3, 30.00); -- zanahoria

-- 314. Smoothie verde de kiwi, espinaca y bebida de avena
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Smoothie verde de kiwi, espinaca y bebida de avena',
    'Un batido detox y lleno de vitaminas para empezar el día con energía.',
    '1. Pela el kiwi. 2. Pon todos los ingredientes en la batidora y tritura.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/smoothie-verde-kiwi.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 44, 60.00), -- kiwi
(@receta_id, 1, 30.00), -- espinaca
(@receta_id, 177, 150.00); -- bebida de avena

-- 315. Pasta de trigo sarraceno con calabacín y tomate cherry
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta de trigo sarraceno con calabacín y tomate cherry',
    'Una pasta sin gluten deliciosa y muy fácil de preparar.',
    '1. Cuece la pasta. 2. Saltea el calabacín y los tomates cherry. 3. Mezcla todo.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/pasta-sarraceno-calabacin.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 150, 60.00), -- trigo sarraceno
(@receta_id, 4, 30.00), -- calabacín
(@receta_id, 258, 30.00); -- tomate cherry

-- 316. Tortilla de berenjena, cebolla y pimiento verde
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de berenjena, cebolla y pimiento verde',
    'Una tortilla jugosa y llena de sabor a huerta.',
    '1. Sofríe las verduras. 2. Bate los huevos y mézclalos con las verduras. 3. Cocina la tortilla.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-berenjena.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 5, 40.00), -- berenjena
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 293, 30.00), -- pimiento verde
(@receta_id, 276, 60.00); -- huevo

-- 317. Porridge de mijo con pera y semillas de calabaza
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de mijo con pera y semillas de calabaza',
    'Un desayuno alternativo a la avena, sin gluten y delicioso.',
    '1. Cuece el mijo. 2. Añade la pera troceada y las semillas de calabaza.',
    15,
    'fácil',
    1,
    'https://ejemplo.com/porridge-mijo-pera.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 137, 40.00), -- mijo cocido
(@receta_id, 39, 50.00), -- pera
(@receta_id, 230, 10.00); -- semillas de calabaza

-- 318. Ensalada de garbanzos, tomate, pepino y cebolla morada
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de garbanzos, tomate, pepino y cebolla morada',
    'Una ensalada fresca y crujiente, ideal para el verano.',
    '1. Pica todas las verduras. 2. Mezcla con los garbanzos cocidos. 3. Aliña al gusto.',
    15,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-garbanzos-pepino.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 97, 60.00), -- garbanzos cocidos
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 25, 30.00), -- pepino
(@receta_id, 294, 20.00); -- cebolla morada

-- 319. Crema de coliflor, puerro y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema de coliflor, puerro y zanahoria',
    'Una crema suave y saludable, llena de vitaminas.',
    '1. Rehoga las verduras. 2. Cubre con agua y cocina. 3. Tritura hasta obtener una crema fina.',
    30,
    'fácil',
    4,
    'https://ejemplo.com/crema-coliflor.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 9, 60.00), -- coliflor
(@receta_id, 14, 30.00), -- puerro
(@receta_id, 3, 30.00); -- zanahoria

-- 320. Yogur vegetal con mango y semillas de chía
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur vegetal con mango y semillas de chía',
    'Un postre exótico y saludable, muy fácil de preparar.',
    '1. Sirve el yogur. 2. Añade el mango troceado. 3. Espolvorea las semillas de chía.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-mango-chia.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00), -- yogur vegetal
(@receta_id, 47, 40.00), -- mango
(@receta_id, 227, 10.00); -- semillas de chía

-- 321. Ensalada de bulgur, remolacha y queso de cabra
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de bulgur, remolacha y queso de cabra',
    'Una combinación de sabores sorprendente y deliciosa.',
    '1. Cuece el bulgur. 2. Corta la remolacha. 3. Mezcla con el queso de cabra y aliña.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-bulgur-remolacha.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 133, 60.00), -- bulgur cocido
(@receta_id, 17, 40.00), -- remolacha
(@receta_id, 83, 30.00); -- queso de cabra

-- 322. Tostadas de pan integral con hummus y zanahoria rallada
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan integral con hummus y zanahoria rallada',
    'Un aperitivo o merienda saludable y muy sabroso.',
    '1. Tuesta el pan. 2. Unta el hummus. 3. Añade la zanahoria rallada.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-hummus-zanahoria.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 130, 30.00), -- pan integral
(@receta_id, 257, 40.00), -- hummus
(@receta_id, 3, 30.00); -- zanahoria

-- 323. Buddha bowl de arroz blanco, edamame y aguacate
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz blanco, edamame y aguacate',
    'Un bol nutritivo y delicioso con inspiración asiática.',
    '1. Cuece el arroz y los edamames. 2. Corta el aguacate. 3. Monta el bol y aliña.',
    25,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-aguacate.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 145, 60.00), -- arroz blanco
(@receta_id, 105, 40.00), -- edamame
(@receta_id, 261, 30.00); -- aguacate

-- 324. Smoothie de piña, espinaca y bebida de soja
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Smoothie de piña, espinaca y bebida de soja',
    'Un batido tropical y verde, lleno de nutrientes.',
    '1. Pon todos los ingredientes en la batidora y tritura.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/smoothie-pina-espinaca.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 46, 60.00), -- piña
(@receta_id, 1, 30.00), -- espinaca
(@receta_id, 178, 150.00); -- bebida de soja

-- 325. Pasta de espelta con calabaza y nueces
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta de espelta con calabaza y nueces',
    'Un plato de pasta otoñal, reconfortante y muy sabroso.',
    '1. Cuece la pasta. 2. Asa la calabaza. 3. Mezcla con las nueces.',
    35,
    'media',
    2,
    'https://ejemplo.com/pasta-espelta-calabaza.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 138, 60.00), -- espelta cocida
(@receta_id, 287, 30.00), -- calabaza
(@receta_id, 156, 10.00); -- nuez

-- 326. Tortilla de calabacín, cebolla y pimiento rojo
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de calabacín, cebolla y pimiento rojo',
    'Una tortilla clásica y jugosa, perfecta para cualquier comida.',
    '1. Sofríe las verduras. 2. Bate los huevos y mézclalos con las verduras. 3. Cocina la tortilla.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-calabacin.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 4, 40.00), -- calabacín
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 6, 30.00), -- pimiento rojo
(@receta_id, 276, 60.00); -- huevo

-- 327. Porridge de avena con pera y semillas de amapola
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de avena con pera y semillas de amapola',
    'Un desayuno original y saludable con un toque crujiente.',
    '1. Cocina la avena. 2. Añade la pera troceada y las semillas de amapola.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/porridge-pera-amapola.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 127, 40.00), -- avena en copos
(@receta_id, 39, 50.00), -- pera
(@receta_id, 232, 10.00); -- semillas de amapola

-- 328. Ensalada de judía blanca, tomate y cebolla
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de judía blanca, tomate y cebolla',
    'Una ensalada de legumbres muy fácil y rápida de preparar.',
    '1. Pica el tomate y la cebolla. 2. Mezcla con las judías blancas. 3. Aliña.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-judia-blanca.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 98, 60.00), -- judía blanca cocida
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 10, 20.00); -- cebolla

-- 330. Yogur vegetal con kiwi y semillas de lino
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur vegetal con kiwi y semillas de lino',
    'Un postre o desayuno refrescante y lleno de fibra.',
    '1. Sirve el yogur. 2. Añade el kiwi troceado. 3. Espolvorea las semillas de lino.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-kiwi-lino.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00), -- yogur vegetal
(@receta_id, 44, 40.00), -- kiwi
(@receta_id, 228, 10.00); -- semillas de lino

-- 331. Ensalada de quinoa, pepino y tomate cherry
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de quinoa, pepino y tomate cherry',
    'Una ensalada ligera y refrescante, ideal como guarnición o plato único.',
    '1. Cuece la quinoa. 2. Pica el pepino y los tomates. 3. Mezcla y aliña.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-quinoa-pepino.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 128, 60.00), -- quinoa cocida
(@receta_id, 25, 30.00), -- pepino
(@receta_id, 258, 30.00); -- tomate cherry

-- 332. Tostadas de pan de centeno con aguacate y tomate
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan de centeno con aguacate y tomate',
    'Un clásico que nunca falla, sano y delicioso.',
    '1. Tuesta el pan. 2. Unta el aguacate. 3. Añade rodajas de tomate.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-centeno-aguacate.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 273, 30.00), -- pan de centeno
(@receta_id, 261, 40.00), -- aguacate
(@receta_id, 7, 30.00); -- tomate

-- 333. Buddha bowl de arroz integral, garbanzos y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz integral, garbanzos y zanahoria',
    'Un bol nutritivo y saciante, perfecto para una comida completa.',
    '1. Cuece el arroz y los garbanzos. 2. Ralla la zanahoria. 3. Monta el bol.',
    30,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-garbanzos.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 146, 60.00), -- arroz integral
(@receta_id, 97, 40.00), -- garbanzos cocidos
(@receta_id, 3, 30.00); -- zanahoria

-- 334. Smoothie de arándano, espinaca y bebida de avena
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Smoothie de arándano, espinaca y bebida de avena',
    'Un batido antioxidante y nutritivo para cualquier momento del día.',
    '1. Pon todos los ingredientes en la batidora y tritura.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/smoothie-arandano-espinaca.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 57, 60.00), -- arándano
(@receta_id, 1, 30.00), -- espinaca
(@receta_id, 177, 150.00); -- bebida de avena

-- 335. Pasta de trigo sarraceno con calabaza y nueces
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta de trigo sarraceno con calabaza y nueces',
    'Una receta otoñal sin gluten, muy sabrosa.',
    '1. Cuece la pasta. 2. Asa la calabaza. 3. Mezcla con las nueces.',
    35,
    'media',
    2,
    'https://ejemplo.com/pasta-sarraceno-calabaza.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 150, 60.00), -- trigo sarraceno
(@receta_id, 287, 30.00), -- calabaza
(@receta_id, 156, 10.00); -- nuez

-- 336. Tortilla de berenjena, cebolla y pimiento rojo
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de berenjena, cebolla y pimiento rojo',
    'Una tortilla de verduras clásica y muy sabrosa.',
    '1. Sofríe las verduras. 2. Bate los huevos y mézclalos con las verduras. 3. Cocina la tortilla.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-berenjena-pimiento.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 5, 40.00), -- berenjena
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 6, 30.00), -- pimiento rojo
(@receta_id, 276, 60.00); -- huevo

-- 337. Porridge de mijo con manzana y semillas de calabaza
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de mijo con manzana y semillas de calabaza',
    'Un desayuno diferente, sin gluten y muy nutritivo.',
    '1. Cuece el mijo. 2. Añade la manzana troceada y las semillas.',
    15,
    'fácil',
    1,
    'https://ejemplo.com/porridge-mijo-manzana.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 137, 40.00), -- mijo cocido
(@receta_id, 36, 50.00), -- manzana
(@receta_id, 230, 10.00); -- semillas de calabaza

-- 338. Ensalada de judía roja, tomate y cebolla morada
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de judía roja, tomate y cebolla morada',
    'Una ensalada de legumbres colorida y refrescante.',
    '1. Pica el tomate y la cebolla. 2. Mezcla con las judías rojas. 3. Aliña.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-judia-roja.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 99, 60.00), -- judía roja cocida
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 294, 20.00); -- cebolla morada

-- 339. Crema de col lombarda, puerro y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema de col lombarda, puerro y zanahoria',
    'Una crema llena de color y antioxidantes.',
    '1. Rehoga las verduras. 2. Cubre con agua y cocina. 3. Tritura.',
    30,
    'fácil',
    4,
    'https://ejemplo.com/crema-lombarda.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 18, 60.00), -- col lombarda
(@receta_id, 14, 30.00), -- puerro
(@receta_id, 3, 30.00); -- zanahoria

-- 340. Yogur natural con pera y semillas de chía
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur natural con pera y semillas de chía',
    'Un postre o desayuno sencillo, saludable y delicioso.',
    '1. Sirve el yogur. 2. Añade la pera troceada y las semillas.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-pera-chia.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 79, 125.00), -- yogur natural
(@receta_id, 39, 40.00), -- pera
(@receta_id, 227, 10.00); -- semillas de chía

-- 341. Ensalada de amaranto, tomate cherry y pepino
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de amaranto, tomate cherry y pepino',
    'Una ensalada con un superalimento, muy fresca y nutritiva.',
    '1. Cuece el amaranto. 2. Pica el tomate y el pepino. 3. Mezcla y aliña.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-amaranto.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 136, 60.00), -- amaranto cocido
(@receta_id, 258, 30.00), -- tomate cherry
(@receta_id, 25, 30.00); -- pepino

-- 342. Tostadas de pan sin gluten con hummus y pimiento asado
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan sin gluten con hummus y pimiento asado',
    'Un aperitivo delicioso y apto para celíacos.',
    '1. Tuesta el pan. 2. Unta el hummus. 3. Añade tiras de pimiento asado.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-hummus-pimiento.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 154, 30.00), -- pan sin gluten
(@receta_id, 257, 40.00), -- hummus
(@receta_id, 6, 30.00); -- pimiento rojo

-- 343. Buddha bowl de arroz inflado, edamame y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz inflado, edamame y zanahoria',
    'Un bol ligero y crujiente, perfecto para una cena rápida.',
    '1. Cuece los edamames. 2. Ralla la zanahoria. 3. Monta el bol con el arroz inflado.',
    15,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-arroz-inflado.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 141, 40.00), -- arroz inflado
(@receta_id, 105, 40.00), -- edamame
(@receta_id, 3, 30.00); -- zanahoria

-- 344. Smoothie de frambuesa, espinaca y bebida de almendra
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Smoothie de frambuesa, espinaca y bebida de almendra',
    'Un batido antioxidante y lleno de sabor.',
    '1. Pon todos los ingredientes en la batidora y tritura.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/smoothie-frambuesa-espinaca.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 56, 60.00), -- frambuesa
(@receta_id, 1, 30.00), -- espinaca
(@receta_id, 171, 150.00); -- bebida de almendra

-- 345. Pasta de maíz con calabaza y pistacho
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta de maíz con calabaza y pistacho',
    'Una receta sin gluten con una combinación de sabores original.',
    '1. Cuece la pasta. 2. Asa la calabaza. 3. Mezcla con los pistachos.',
    35,
    'media',
    2,
    'https://ejemplo.com/pasta-maiz-calabaza.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 147, 60.00), -- maíz
(@receta_id, 287, 30.00), -- calabaza
(@receta_id, 159, 10.00); -- pistacho

-- 346. Tortilla de col rizada, cebolla y pimiento verde
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de col rizada, cebolla y pimiento verde',
    'Una tortilla saludable con un superalimento como la col rizada.',
    '1. Sofríe las verduras. 2. Bate los huevos y mézclalos con las verduras. 3. Cocina la tortilla.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-col-rizada.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 19, 40.00), -- col rizada
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 293, 30.00), -- pimiento verde
(@receta_id, 276, 60.00); -- huevo

-- 347. Porridge de copos de trigo integral con pera y semillas de girasol
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de copos de trigo integral con pera y semillas de girasol',
    'Un desayuno completo y lleno de fibra.',
    '1. Cocina los copos de trigo. 2. Añade la pera troceada y las semillas.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/porridge-trigo-pera.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 142, 40.00), -- copos de trigo integral
(@receta_id, 39, 50.00), -- pera
(@receta_id, 231, 10.00); -- semillas de girasol

-- 348. Ensalada de judión, tomate y cebolla
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de judión, tomate y cebolla',
    'Una ensalada de legumbres contundente y muy sabrosa.',
    '1. Pica el tomate y la cebolla. 2. Mezcla con los judiones. 3. Aliña.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-judion.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 109, 60.00), -- judión cocido
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 10, 20.00); -- cebolla

-- 349. Crema de brócoli, puerro y patata
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Crema de brócoli, puerro y patata',
    'Una crema clásica y reconfortante, ideal para toda la familia.',
    '1. Rehoga las verduras. 2. Cubre con agua y cocina. 3. Tritura.',
    30,
    'fácil',
    4,
    'https://ejemplo.com/crema-brocoli.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 8, 60.00), -- brócoli
(@receta_id, 14, 30.00), -- puerro
(@receta_id, 282, 40.00); -- patata

-- 350. Yogur vegetal con manzana y semillas de lino
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur vegetal con manzana y semillas de lino',
    'Un postre o desayuno saludable y muy fácil de preparar.',
    '1. Sirve el yogur. 2. Añade la manzana troceada y las semillas.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-manzana-lino.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00), -- yogur vegetal
(@receta_id, 36, 40.00), -- manzana
(@receta_id, 228, 10.00); -- semillas de lino

-- 351. Ensalada de mijo, pepino y tomate cherry
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de mijo, pepino y tomate cherry',
    'Una ensalada sin gluten muy refrescante y ligera.',
    '1. Cuece el mijo. 2. Pica el pepino y los tomates. 3. Mezcla y aliña.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-mijo-pepino.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 137, 60.00), -- mijo cocido
(@receta_id, 25, 30.00), -- pepino
(@receta_id, 258, 30.00); -- tomate cherry

-- 352. Tostadas de pan integral con hummus y remolacha
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan integral con hummus y remolacha',
    'Un aperitivo colorido y lleno de sabor.',
    '1. Tuesta el pan. 2. Unta el hummus. 3. Añade la remolacha en rodajas o rallada.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-hummus-remolacha.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 130, 30.00), -- pan integral
(@receta_id, 257, 40.00), -- hummus
(@receta_id, 17, 30.00); -- remolacha

-- 353. Buddha bowl de arroz blanco, garbanzos y zanahoria
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz blanco, garbanzos y zanahoria',
    'Un bol completo y equilibrado, muy fácil de preparar.',
    '1. Cuece el arroz y los garbanzos. 2. Ralla la zanahoria. 3. Monta el bol.',
    25,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-arroz-garbanzos.jpg',
    TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 145, 60.00), -- arroz blanco
(@receta_id, 97, 40.00), -- garbanzos cocidos
(@receta_id, 3, 30.00); -- zanahoria


-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de alubia pinta, tomate y cebolla',
    'Una ensalada de legumbres clásica, muy fácil de hacer y muy sabrosa.',
    '1. Pica el tomate y la cebolla.\n2. Mezcla con las alubias pintas cocidas.\n3. Aliña con aceite, vinagre y sal.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-alubia-pinta-tomate.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 101, 60.00), -- alubia pinta cocida
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 10, 20.00); -- cebolla



-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de quinoa, zanahoria y tomate cherry',
    'Una ensalada completa, ligera y llena de color.',
    '1. Cuece la quinoa y deja enfriar.\n2. Mezcla con la zanahoria rallada y los tomates cherry.\n3. Aliña al gusto.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-quinoa-zanahoria-cherry.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 128, 60.00), -- quinoa cocida
(@receta_id, 3, 30.00), -- zanahoria
(@receta_id, 258, 30.00); -- tomate cherry

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan de centeno con hummus y remolacha',
    'Un aperitivo o merienda sorprendente, lleno de color y sabor.',
    '1. Tuesta el pan de centeno.\n2. Unta una buena capa de hummus.\n3. Añade remolacha cocida en rodajas o rallada.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-centeno-hummus-remolacha.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 273, 30.00), -- pan de centeno
(@receta_id, 257, 40.00), -- hummus
(@receta_id, 17, 30.00); -- remolacha

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz integral, judía blanca y zanahoria',
    'Un bol nutritivo y equilibrado, perfecto para una comida completa.',
    '1. Cuece el arroz integral y las judías blancas.\n2. Ralla la zanahoria.\n3. Monta el bol y aliña con tu salsa favorita.',
    30,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-judia-blanca.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 146, 60.00), -- arroz integral
(@receta_id, 98, 40.00), -- judía blanca cocida
(@receta_id, 3, 30.00); -- zanahoria

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Smoothie de kiwi, espinaca y bebida de avena',
    'Un batido verde lleno de vitaminas y fibra para empezar el día.',
    '1. Pela el kiwi.\n2. Pon todos los ingredientes en la batidora.\n3. Tritura hasta obtener una mezcla homogénea.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/smoothie-kiwi-espinaca-avena.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 44, 60.00), -- kiwi
(@receta_id, 1, 30.00), -- espinaca
(@receta_id, 177, 150.00); -- bebida de avena

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Pasta de bulgur con calabaza y nuez',
    'Una receta original y sabrosa con el toque dulce de la calabaza.',
    '1. Cuece el bulgur.\n2. Asa la calabaza en el horno.\n3. Mezcla el bulgur con la calabaza y las nueces troceadas.',
    30,
    'fácil',
    2,
    'https://ejemplo.com/pasta-bulgur-calabaza-nuez.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 133, 60.00), -- bulgur cocido
(@receta_id, 287, 30.00), -- calabaza
(@receta_id, 156, 10.00); -- nuez

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de coliflor, cebolla y pimiento verde',
    'Una forma deliciosa de incluir coliflor en tu dieta.',
    '1. Sofríe la cebolla y el pimiento verde.\n2. Añade la coliflor cocida.\n3. Bate los huevos, mezcla y cuaja la tortilla.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-coliflor-pimiento-verde.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 9, 40.00), -- coliflor
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 293, 30.00), -- pimiento verde
(@receta_id, 276, 60.00); -- huevo

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de copos de maíz con manzana y semillas de sésamo',
    'Un desayuno sin gluten, crujiente y muy original.',
    '1. Calienta los copos de maíz con tu leche o bebida vegetal preferida.\n2. Añade manzana troceada y semillas de sésamo.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/porridge-maiz-manzana-sesamo.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 148, 40.00), -- copos de maíz
(@receta_id, 36, 50.00), -- manzana
(@receta_id, 229, 10.00); -- semillas de sésamo

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de judía roja, tomate y cebolla',
    'Una ensalada de legumbres muy sencilla, rápida y sabrosa.',
    '1. Mezcla las judías rojas cocidas con el tomate y la cebolla picados.\n2. Aliña al gusto.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-judia-roja-tomate.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 99, 60.00), -- judía roja cocida
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 10, 20.00); -- cebolla

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur vegetal con pera y semillas de lino',
    'Un postre o desayuno vegano, ligero y rico en fibra.',
    '1. Sirve el yogur vegetal.\n2. Añade la pera en trozos.\n3. Espolvorea con semillas de lino.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-vegetal-pera-lino.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 259, 125.00), -- yogur vegetal
(@receta_id, 39, 40.00), -- pera
(@receta_id, 228, 10.00); -- semillas de lino

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de espelta, pepino y tomate cherry',
    'Una ensalada muy fresca y saludable, con el toque rústico de la espelta.',
    '1. Cuece la espelta y enfría.\n2. Mezcla con el pepino y los tomates cherry en rodajas.\n3. Aliña.',
    20,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-espelta-pepino.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 138, 60.00), -- espelta cocida
(@receta_id, 25, 30.00), -- pepino
(@receta_id, 258, 30.00); -- tomate cherry

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tostadas de pan integral con hummus y zanahoria',
    'Un clásico de los aperitivos saludables, delicioso y crujiente.',
    '1. Tuesta el pan integral.\n2. Unta con hummus.\n3. Añade zanahoria rallada por encima.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/tostadas-integral-hummus-zanahoria.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 130, 30.00), -- pan integral
(@receta_id, 257, 40.00), -- hummus
(@receta_id, 3, 30.00); -- zanahoria

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Buddha bowl de arroz blanco, edamame y zanahoria',
    'Un bol de inspiración asiática, sencillo, saludable y delicioso.',
    '1. Cuece el arroz y los edamames.\n2. Ralla la zanahoria.\n3. Monta tu bol y aliña con salsa de soja.',
    25,
    'fácil',
    1,
    'https://ejemplo.com/buddha-bowl-arroz-edamame-zanahoria.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 145, 60.00), -- arroz blanco
(@receta_id, 105, 40.00), -- edamame
(@receta_id, 3, 30.00); -- zanahoria

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Smoothie de mango, espinaca y bebida de soja',
    'Un batido tropical, cremoso y lleno de nutrientes.',
    '1. Pela el mango.\n2. Introduce todos los ingredientes en la batidora.\n3. Tritura hasta que no queden grumos.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/smoothie-mango-espinaca-soja.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 47, 60.00), -- mango
(@receta_id, 1, 30.00), -- espinaca
(@receta_id, 178, 150.00); -- bebida de soja

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Tortilla de coles de Bruselas, cebolla y pimiento rojo',
    'Una forma sorprendente y deliciosa de comer coles de Bruselas.',
    '1. Sofríe la cebolla y el pimiento.\n2. Añade las coles cocidas y saltea.\n3. Bate los huevos, mezcla y cuaja.',
    25,
    'fácil',
    2,
    'https://ejemplo.com/tortilla-coles-pimiento.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 31, 40.00), -- coles de Bruselas
(@receta_id, 10, 30.00), -- cebolla
(@receta_id, 6, 30.00), -- pimiento rojo
(@receta_id, 276, 60.00); -- huevo

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Porridge de avena con manzana y semillas de calabaza',
    'Un desayuno clásico con un extra de nutrientes y un toque crujiente.',
    '1. Cocina la avena.\n2. Añade la manzana troceada.\n3. Decora con semillas de calabaza.',
    10,
    'fácil',
    1,
    'https://ejemplo.com/porridge-avena-manzana-calabaza.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 127, 40.00), -- avena en copos
(@receta_id, 36, 50.00), -- manzana
(@receta_id, 230, 10.00); -- semillas de calabaza

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Ensalada de judía blanca, tomate y cebolla morada',
    'Una ensalada de legumbres fresca y muy fácil de preparar.',
    '1. Pica el tomate y la cebolla.\n2. Mezcla con las judías blancas cocidas.\n3. Aliña al gusto.',
    10,
    'fácil',
    2,
    'https://ejemplo.com/ensalada-judia-blanca-cebolla-morada.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 98, 60.00), -- judía blanca cocida
(@receta_id, 7, 30.00), -- tomate
(@receta_id, 294, 20.00); -- cebolla morada

-- 1. Insertar la receta
INSERT INTO receta (
    nombre,
    descripcion,
    instrucciones,
    tiempo_preparacion,
    dificultad,
    raciones,
    imagen_url,
    visible
) VALUES (
    'Yogur natural con mango y semillas de chía',
    'Un postre o desayuno exótico, saludable y delicioso.',
    '1. Sirve el yogur en un bol.\n2. Añade el mango troceado.\n3. Espolvorea con semillas de chía.',
    5,
    'fácil',
    1,
    'https://ejemplo.com/yogur-natural-mango-chia.jpg',
    TRUE
);

-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();

-- 3. Insertar los ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 79, 125.00), -- yogur natural
(@receta_id, 47, 40.00), -- mango
(@receta_id, 227, 10.00); -- semillas de chía




