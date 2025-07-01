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
    'Bizcocho de avena y plátano',
    'Un bizcocho saludable y esponjoso, ideal para desayuno o merienda.',
    '1. Precalienta el horno a 180 °C.\n2. Machaca 2 plátanos maduros.\n3. Mezcla los plátanos con 150 g de copos de avena, 2 huevos, 50 ml de aceite de oliva y 1 cucharadita de levadura.\n4. Vierte en molde y hornea 40 min.\n5. Deja enfriar y sirve.',
    50,
    'fácil',
    8,
    'https://www.allrecipes.com/thmb/uzUaNYlyhcNAY_rsDQ03SlL_s44%3D/1500x0/filters%3Ano_upscale%28%29%3Amax_bytes%28150000%29%3Astrip_icc%28%29/1917955-60479733a9db4ac4abd41df5ee191b09.jpg',
    TRUE
);
-- 2. Obtener ID de la receta
SET @receta_id = LAST_INSERT_ID();
-- 3. Insertar ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 37, 200.00),  -- plátano
(@receta_id, 127, 150.00), -- avena en copos
(@receta_id, 276,   2.00),   -- huevos *
(@receta_id, 242, 50.00),  -- aceite de oliva virgen extra
(@receta_id, 295,   5.00);   -- levadura química *

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
    'Tarta de avena y manzana',
    'Tarta saludable con avena y trozos de manzana, perfecta para merendar.',
    '1. Precalienta el horno a 180 °C.\n2. Ralla 2 manzanas y mézclalas con 150 g de copos de avena, 2 huevos, 50 ml de leche vegetal, 1 cdita de levadura y canela al gusto.\n3. Vierte en molde, espolvorea avena encima y hornea 45 min.\n4. Deja enfriar antes de cortar.',
    60,
    'fácil',
    6,
    'https://i0.wp.com/www.drbreitfeld.com/wp-content/uploads/2019/07/WhatsApp-Image-2019-07-08-at-15.52.32.jpeg?fit=1024%2C559&ssl=1',
    TRUE
);
-- 2. Obtener ID
SET @receta_id = LAST_INSERT_ID();
-- 3. Insertar ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 127, 150.00), -- avena en copos
(@receta_id, 36, 200.00),  -- manzana
(@receta_id, 276,   2.00),   -- huevos *
(@receta_id, 296,  50.00),   -- leche vegetal *
(@receta_id, 295,   5.00);   -- levadura química *

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
    'Pastel de plátano, avena y arándanos',
    'Un bizcocho esponjoso con plátano, avena y arándanos frescos o congelados.',
    '1. Precalienta el horno a 180 °C.\n2. Machaca 3 plátanos maduros.\n3. Mezcla con 150 g de avena en copos, 2 huevos, 50 ml de aceite de oliva, 1 cdita de levadura y 100 g de arándanos.\n4. Hornea 45 min y deja enfriar antes de servir.',
    55,
    'fácil',
    8,
    'https://i.ytimg.com/vi/hSG8OjDkemU/hq720.jpg?rs=AOn4CLDzHBbNJ5z5gl5rFVKM1gQrNPCLUQ&sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD',
    TRUE
);
-- 2. Obtener ID
SET @receta_id = LAST_INSERT_ID();
-- 3. Insertar ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 37, 300.00),  -- plátano
(@receta_id, 127, 150.00), -- avena en copos
(@receta_id, 276,   2.00),   -- huevos *
(@receta_id, 242, 50.00),  -- aceite de oliva virgen extra
(@receta_id, 295,   5.00),   -- levadura química *
(@receta_id, 57, 100.00);   -- arándanos *

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
    'Pastel de plátano y coco',
    'Un pastel húmedo y tropical, ideal para merienda o desayuno divertido.',
    '1. Precalienta el horno a 180 °C.\n2. Machaca 3 plátanos maduros.\n3. Mezcla con 150 g de avena en copos, 2 huevos, 100 ml de leche de coco, 1 cucharadita de levadura, 50 ml de aceite de oliva.\n4. Vierte en molde y hornea 45 min.\n5. Espolvorea coco rallado por encima y sirve una vez templado.',
    60,
    'fácil',
    8,
    'https://img.taste.com.au/NhNjGa9D/taste/2018/09/healthier-banana-coconut-cake-141549-1.jpg',
    TRUE
);
-- 2. Obtener ID
SET @receta_id = LAST_INSERT_ID();
-- 3. Insertar ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 37, 300.00),  -- plátano
(@receta_id, 127, 150.00), -- avena en copos
(@receta_id, 276,   2.00),   -- huevos *
(@receta_id, 297, 100.00),   -- leche de coco *
(@receta_id, 295,   5.00),   -- levadura química *
(@receta_id, 242, 50.00),  -- aceite de oliva virgen extra
(@receta_id, 298, 30.00);    -- coco rallado *

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
    'Torta de avena y zanahoria',
    'Deliciosa torta sin gluten con avena y zanahoria, ideal para todo el día.',
    '1. Precalienta el horno a 180 °C.\n2. Ralla 3 zanahorias medianas.\n3. Mezcla 150 g de avena en copos, 2 huevos, 50 ml de leche vegetal, 1 cucharadita de levadura y canela al gusto con las zanahorias.\n4. Vierte en molde y hornea 40 min.\n5. Deja enfriar y sirve.',
    55,
    'fácil',
    8,
    'https://receta.memeswing.com/wp-content/uploads/2025/02/476006285_122124436862604366_774904879759402582_n-819x1024.jpg',
    TRUE
);
-- 2. Obtener ID
SET @receta_id = LAST_INSERT_ID();
-- 3. Insertar ingredientes
INSERT INTO receta_ingrediente (receta_id, ingrediente_id, cantidad) VALUES
(@receta_id, 127, 150.00), -- avena en copos
(@receta_id, 276,   2.00),   -- huevos *
(@receta_id, 296,  50.00),   -- leche vegetal *
(@receta_id, 295,   5.00),   -- levadura química *
(@receta_id, 3, 200.00);   -- zanahoria *

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
    'Banana flapjack con avena y linaza',
    'Galletas-cake saludables con plátano, avena y semillas de linaza.',
    '1. Precalienta a 180 °C.\n2. Machaca 3 plátanos.\n3. Mezcla con 200 g de avena en copos, 2 huevos, 2 cucharadas de semillas de linaza troceadas, 1 cdita de levadura y 50 ml de aceite.\n4. Extiende en bandeja formando galletas gruesas.\n5. Hornea 20‑25 min y enfría.',
    40,
    'fácil',
    12,
    'https://www.melskitchencafe.com/wp-content/uploads/2023/01/banana-snack-cake7-640x960.jpg',
    TRUE
);
-- 2. Obtener ID
SET @receta_id = LAST_INSERT_ID();
-- 3. Insertar ingredientes
INSERT INTO receta_ingrediente VALUES
(@receta_id, 37, 300.00),  -- plátano
(@receta_id, 127, 200.00), -- avena en copos
(@receta_id, 276, 2.00),      -- huevos *
(@receta_id, 295, 5.00),      -- levadura química *
(@receta_id, 299, 30.00),     -- linaza *
(@receta_id, 242, 50.00);   -- aceite de oliva

-- 1. Insertar receta
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
    'Pastel de avena con dátiles y pasas',
    'Bizcocho sin gluten con balón natural de dátiles y pasas.',
    '1. Precalienta a 180 °C.\n2. Pica 100 g de dátiles y 50 g de pasas.\n3. Mezcla 150 g de avena, 2 huevos, 50 ml de leche vegetal, 1 cdita de levadura, dátiles y pasas.\n4. Hornea 45 min, enfría.',
    60,
    'fácil',
    8,
    'https://www.carveyourcraving.com/wp-content/uploads/2021/09/healthy-oatmeal-almond-cake.jpg',
    TRUE
);
-- 2. ID receta
SET @receta_id = LAST_INSERT_ID();
-- 3. Ingredientes
INSERT INTO receta_ingrediente VALUES
(@receta_id, 127, 150.00), -- avena
(@receta_id, 276, 2.00),      -- huevos *
(@receta_id, 295, 50.00),     -- leche vegetal *
(@receta_id, 304, 5.00),      -- levadura *
(@receta_id, 300, 100.00),    -- dátiles *
(@receta_id, 301, 50.00);     -- pasas *

-- 1. Insertar receta
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
    'Banana oat snack cake con chips',
    'Pequeño pastel esponjoso con plátano, avena y chocolate.',
    '1. Precalienta a 180 °C.\n2. Machaca 2 plátanos.\n3. Mezcla con 120 g avena, 2 huevos, 50 g azúcar, 50 ml aceite, 1 cdita de levadura y 80 g de chips de chocolate.\n4. Hornea 30‑35 min y deja enfriar.',
    50,
    'fácil',
    6,
    'https://fromscratchfast.com/wp-content/uploads/2018/10/Banana-Breakfast-Cookies-Oatcakes_SQUARE.jpg',
    TRUE
);
-- 2. ID receta
SET @receta_id = LAST_INSERT_ID();
-- 3. Ingredientes
INSERT INTO receta_ingrediente VALUES
(@receta_id, 37, 200.00),  -- plátano
(@receta_id, 127, 120.00), -- avena
(@receta_id, 276, 2.00),      -- huevos *
(@receta_id, 303, 50.00),     -- azúcar (añadir si no está)
(@receta_id, 242, 50.00),   -- aceite
(@receta_id, 304, 5.00),      -- levadura *
(@receta_id, 302, 80.00);     -- chips de chocolate *

-- 1. Insertar receta
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
    'Pastel de avena y pasas con glaseado',
    'Pastel de avena con pasas y un ligero glaseado de queso crema.',
    '1. Remoja 100 g pasas en 1 taza de agua hirviendo 20 min.\n2. Mezcla 150 g avena, 100 g azúcar, 2 huevos, 1 cdita levadura, pasas + agua.\n3. Hornea 45 min. Enfría y añade glaseado de queso crema opcional.',
    75,
    'media',
    12,
    'https://amyshealthybaking.com/wp-content/uploads/2022/06/oatmeal-raisin-snack-cake-3338-1024x1536.jpg',
    TRUE
);
-- 2. ID receta
SET @receta_id = LAST_INSERT_ID();
-- 3. Ingredientes
INSERT INTO receta_ingrediente VALUES
(@receta_id, 127, 150.00), -- avena
(@receta_id, 303, 100.00),    -- azúcar *
(@receta_id, 276, 2.00),      -- huevos *
(@receta_id, 304, 5.00),      -- levadura *
(@receta_id, 301, 100.00);    -- pasas *
-- (Glaseado no se añade a ingredientes, al gusto)

-- 1. Insertar receta
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
    'Date squares (pastel de dátiles y avena)',
    'Bocados dulces con base y cobertura de avena y relleno cremoso de dátiles.',
    '1. Precalienta a 180 °C.\n2. Prepara masa con 200 g avena, 50 g azúcar, 100 g mantequilla* y 1 cdita levadura.\n3. Extiende mitad en molde.\n4. Calienta 150 g dátiles picados con un poco de agua hasta puré.\n5. Vierte encima y cubre con el resto de masa.\n6. Hornea 30‑35 min. Deja enfriar y corta.',
    70,
    'media',
    16,
    'https://i.pinimg.com/originals/da/6a/59/da6a592ef0958e399f5bef4e216de5e6.jpg',
    TRUE
);
-- 2. ID receta
SET @receta_id = LAST_INSERT_ID();
-- 3. Ingredientes
INSERT INTO receta_ingrediente VALUES
(@receta_id, 127, 200.00), -- avena
(@receta_id, 303, 50.00),     -- azúcar *
(@receta_id, 85, 100.00),    -- mantequilla *
(@receta_id, 304, 5.00),      -- levadura *
(@receta_id, 300, 150.00);    -- dátiles *

-----------------------------------------------------------------------

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
  'Ensalada mediterránea de espinaca',
  'Espinacas frescas con tomate, pepino y aderezo ligero.',
  '1. Lava 100 g espinaca, 100 g tomate, 50 g pepino.\n2. Aliña con 1 cda aceite oliva y vinagre.\n3. Mezcla y sirve.',
  15, 'fácil', 2,
  'https://kalynskitchen.com/wp-content/uploads/2013/03/650-med-spinach-salad.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 1, 100.00),
(@receta_id, 7, 100.00),
(@receta_id, 25, 50.00),
(@receta_id, 242, 10.00),
(@receta_id, 244, 5.00);

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
  'Crema ligera de calabacín y puerro',
  'Suave crema saludable, ideal entrada.',
  '1. Sofríe 50 g puerro y 150 g calabacín en 1 cda aceite.\n2. Añade 300 ml agua o caldo y cocina 15 min.\n3. Tritura y sirve.',
  25, 'media', 4,
  'https://res.cloudinary.com/unaderecetas/image/upload/crema-calabacin-y-puerro/crema_calabacin_puerro_base_1.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 4, 150.00),
(@receta_id, 14, 50.00),
(@receta_id, 242, 10.00);

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
  'Salteado de brócoli, zanahoria y champiñón',
  'Verduras salteadas en aceite de oliva.',
  '1. Trocea 100 g brócoli, 100 g zanahoria y 50 g champiñón.\n2. Sofríe todo en 1 cda aceite.\n3. Salpimenta y sirve.',
  20, 'fácil', 3,
  'https://tse3.mm.bing.net/th/id/OIP.BtpgIxVSgw0pju_pdzp-RQHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 8, 100.00),
(@receta_id, 3, 100.00),
(@receta_id, 32, 50.00),
(@receta_id, 242, 10.00),
(@receta_id, 246, 1.00);

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
  'Berenjena asada con pimiento y cebolla',
  'Vegetales asados al horno.',
  '1. Corta 150 g berenjena, 100 g pimiento rojo y 1 cebolla.\n2. Aliña con aceite y hierbas.\n3. Hornea 25 min a 200 °C.',
  40, 'media', 4,
  'https://tse2.mm.bing.net/th/id/OIP.-cyDt94sKUoiZ-tHhbWBzgHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 5, 150.00),
(@receta_id, 6, 100.00),
(@receta_id, 10, 100.00),
(@receta_id, 242, 15.00);

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
  'Bowl de quinoa con judías verdes y tomate',
  'Combinación completa de proteínas y vegetales.',
  '1. Cocina 150 g quinoa y 100 g judía verde.\n2. Trocea 100 g tomate.\n3. Mezcla y aliña con aceite de oliva.',
  30, 'media', 3,
  'https://images.squarespace-cdn.com/content/5313b7c3e4b08cb68817cf91/1466780516667-ZWRSUV0BTMSJ8859FGX0/?content-type=image%2Fjpeg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 149, 150.00),
(@receta_id, 24, 100.00),
(@receta_id, 7, 100.00),
(@receta_id, 242, 10.00);

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
  'Ensalada de kale, manzana y nueces',
  'Hoja verde con fruta y grasa saludable.',
  '1. Pica 100 g kale y 1 manzana.\n2. Añade 30 g nueces y adereza.',
  15, 'fácil', 2,
  'https://th.bing.com/th/id/R.aff72ef343d3101df30f2f6208ba70d3?rik=QiSlgnyAQ6DU8g&riu=http%3a%2f%2fschonefrau.com%2ffiles%2f2015%2f03%2fensalada-kale-manzana-aderezo-nuez-02.jpg&ehk=%2bISU0rM%2fQcodChDLBVl2E%2b1IVq%2bN1%2b6SpfG1MP40ieo%3d&risl=&pid=ImgRaw&r=0',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 19, 100.00),
(@receta_id, 36, 150.00),
(@receta_id, 156, 30.00),
(@receta_id, 242, 10.00);

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
  'Pasta integral con tomate y atún',
  'Plato equilibrado con proteína y cereales integrales.',
  '1. Cocina 150 g pasta integral.\n2. Mezcla con 100 g tomate triturado y 100 g atún.\n3. Aliña con aceite.',
  25, 'media', 4,
  'https://www.eljardindelasrecetas.com/wp-content/uploads/2024/06/pasta-integral-con-atun-y-tomate-750x938.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 289, 150.00),
(@receta_id, 265, 100.00),
(@receta_id, 118, 100.00),
(@receta_id, 242, 10.00);

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
  'Sopa de coliflor y puerro',
  'Sopa cremosa y ligera.',
  '1. Sofríe 50 g puerro, añade 200 g coliflor y 300 ml agua.\n2. Cocina 20 min y tritura.',
  30, 'media', 4,
  'https://i.pinimg.com/originals/b9/a8/97/b9a8973d123b8ac4de1aa0e48b2684c2.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 9, 200.00),
(@receta_id, 14, 50.00),
(@receta_id, 242, 10.00);

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
  'Salteado de berenjena y garbanzos',
  'Rico en fibra y proteína vegetal.',
  '1. Corta 150 g berenjena y 200 g garbanzos cocidos.\n2. Sofríe todo con ajo y aceite.',
  25, 'media', 4,
  'https://mejorconsalud.as.com/wp-content/uploads/2019/04/ensalada-garbanzos-berenjena-768x513.jpg?auto=webp&quality=45&width=1920&crop=16:9,smart,safe',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 5, 150.00),
(@receta_id, 97, 200.00),
(@receta_id, 242, 10.00);

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
  'Ensalada de lentejas, zanahoria y hinojo',
  'Equilibrada y fresca, ideal para almuerzo.',
  '1. Cocina 150 g lenteja cocida.\n2. Ralla 100 g zanahoria y pica 50 g hinojo.\n3. Mezcla con aceite.',
  20, 'fácil', 3,
  'https://www.confiesoquecocino.com/wp-content/uploads/2013/02/Ensalada-de-Hinojo-+-Zanahoria-02.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 107, 150.00),
(@receta_id, 3, 100.00),
(@receta_id, 21, 50.00),
(@receta_id, 242, 10.00);

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
  'Tabulé de quinoa y pepino',
  'Fresco y lleno de fibra, ideal en verano.',
  '1. Cocina 150 g quinoa y deja enfriar.\n2. Pica 100 g pepino, 50 g tomate, 20 g cebolla morada.\n3. Mezcla con quinoa y aliña con aceite, limón y hierbas.',
  25, 'media', 4,
  'https://cocina-casera.com/wp-content/uploads/2018/09/tabule-quinoa-pepino.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 149, 150.00),
(@receta_id, 25, 100.00),
(@receta_id, 7, 50.00),
(@receta_id, 294, 20.00),
(@receta_id, 242, 10.00);

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
  'Crema de zanahoria, jengibre y naranja',
  'Suave y con un toque cítrico y picante.',
  '1. Sofríe 150 g zanahoria con 1 cdita jengibre.\n2. Añade 300 ml caldo y cocina 15 min.\n3. Incorpora 100 ml zumo de naranja, tritura y sirve.',
  30, 'media', 4,
  'https://3.bp.blogspot.com/-fpUbB-SxzLs/UOmtAQOW7JI/AAAAAAAAFxM/1D2M1InDlPo/s1600/triturar.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 3, 150.00),
(@receta_id, 38, 100.00),
(@receta_id, 242, 10.00);

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
  'Ensalada tibia de coliflor y garbanzos',
  'Crujiente por fuera y sabrosa.',
  '1. Asar 200 g coliflor y 150 g garbanzos cocidos con especias 20 min.\n2. Servir tibio con hojas verdes y limón.',
  35, 'media', 3,
  'https://adelgazarencasa.co/wp-content/uploads/2021/10/ensalada-de-garbanzos-y-coliflor.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 9, 200.00),
(@receta_id, 97, 150.00),
(@receta_id, 11, 50.00),
(@receta_id, 242, 10.00);

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
  'Salteado oriental de pimiento, brócoli y setas',
  'Ligero y lleno de sabor asiático.',
  '1. Trocea 100 g pimiento, 100 g brócoli y 50 g setas ostra.\n2. Saltea 5 min con salsa soja ligera.',
  20, 'fácil', 3,
  'https://lh3.googleusercontent.com/-PGY7aPIUgBU/UxzF7FeqX4I/AAAAAAAAGU8/S4dN_s1ltFQ/s800/Brocoli-salteado-con-setas-y-pimiento.JPG',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 6, 100.00),
(@receta_id, 8, 100.00),
(@receta_id, 33, 50.00),
(@receta_id, 242, 10.00);

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
  'Budín salado de espinaca y queso fresco',
  'Textura esponjosa y saludable.',
  '1. Bate 3 huevos, mezcla 150 g espinaca cocida y 100 g queso fresco.\n2. Vierte en molde y hornea 30 min a 180 °C.',
  45, 'media', 4,
  'https://www.bing.com/images/search?view=detailV2&ccid=%2bzLheRhh&id=0B4E280080B83C854D7C883C67BA49124C98818B&thid=OIP.-zLheRhhfCboXkVDzdTUDwHaFS&mediaurl=https%3a%2f%2fstatic.americadigital.com%2fwp-content%2fuploads%2f2020%2f10%2famerica_digital_budin_sin_harina_saludables_2020-2-750x536.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.fb32e17918617c26e85e4543cdd4d40f%3frik%3di4GYTBJJumc8iA%26pid%3dImgRaw%26r%3d0&exph=536&expw=750&q=budin+salado+de+espinaca+y+queso+fresco&simid=608017505973723908&FORM=IRPRST&ck=31CBD928D363F9EC4A944FF54EA55D7B&selectedIndex=0&itb=0&ajaxhist=0&ajaxserp=0',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 1, 150.00),
(@receta_id, 276, 3.00),
(@receta_id, 81, 100.00),
(@receta_id, 242, 10.00);

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
  'Mini pizzas sobre berenjena',
  'Versión ligera con verduras y queso.',
  '1. Corta berenjena en rodajas y hornea 10 min.\n2. Añade tomate triturado, queso curado y orégano.\n3. Gratina 5 min más.',
  25, 'media', 2,
  'https://cecotec.es/recetas/wp-content/uploads/2022/06/Cecofry_advance_5000_black_mini_pizzas_de_berenjena_RRSS-1024x1024.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 5, 200.00),
(@receta_id, 265, 100.00),
(@receta_id, 82, 50.00),
(@receta_id, 246, 1.00);

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
  'Ensalada fría de lentejas, remolacha y pepino',
  'Colores y nutrientes en un bowl.',
  '1. Mezcla 150 g lenteja cocida, 100 g remolacha cocida y 100 g pepino.\n2. Raspa limón, aceíte y mezcla.',
  20, 'fácil', 3,
  'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhYHaqdn4Pq5glGlqLdxY_X9I79ejF8jX6wEOv-YZSOgV8wpVZdml-eIf-T-nkPI4cJWNbF5OAWLvseLaW0LWb1bgXp1nI7NT6idPnkyuEVQ7mYBisCZ-VKKv_DENfn1-2hjj54_UQIbsTK/s1600/Ensalada+de+remolacha+y+pepino.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 107, 150.00),
(@receta_id, 17, 100.00),
(@receta_id, 25, 100.00),
(@receta_id, 242, 10.00);

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
  'Crema de col lombarda y manzana',
  'Sabor dulce-salado y color vibrante.',
  '1. Sofríe 50 g cebolla, añade 200 g col lombarda y 1 manzana troceada.\n2. Agrega 300 ml caldo, cocina 15 min y tritura.',
  35, 'media', 4,
  'https://2.bp.blogspot.com/-YhLI43Trqww/VLZg6LjiJ3I/AAAAAAAA94w/HHBIdO37Ev8/s1600/1%2Bcrema%2Bde%2Blombarda%2B0.JPG',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 10, 50.00),
(@receta_id, 18, 200.00),
(@receta_id, 36, 150.00),
(@receta_id, 242, 10.00);

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
  'Salteado de judía verde, zanahoria y puerro',
  'Texturas crujientes y nutritivas.',
  '1. Corta 150 g judía, 100 g zanahoria y 50 g puerro.\n2. Saltea 8 min con aceite y ajo.',
  20, 'fácil', 3,
  'https://tse3.mm.bing.net/th/id/OIP.2TKXqq39T1M13WV34-RBbQHaD4?rs=1&pid=ImgDetMain&o=7&rm=3',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 24, 150.00),
(@receta_id, 3, 100.00),
(@receta_id, 14, 50.00),
(@receta_id, 242, 10.00);

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
  'Ensalada de romana, pera y queso de cabra',
  'Delicada y con contraste dulce-salado.',
  '1. Trocea 100 g lechuga romana, 1 pera y 50 g queso de cabra.\n2. Mezcla con nueces y aliña.',
  15, 'fácil', 2,
  'https://d36fw6y2wq3bat.cloudfront.net/recipes/ensalada-de-pera-queso-de-cabra-y-granada/900/ensalada-de-pera-queso-de-cabra-y-granada_version_1652875858.jpg',
  TRUE
);
SET @receta_id = LAST_INSERT_ID();
INSERT INTO receta_ingrediente VALUES
(@receta_id, 11, 100.00),
(@receta_id, 39, 150.00),
(@receta_id, 83, 50.00),
(@receta_id, 156, 20.00),
(@receta_id, 242, 10.00);

