DROP DATABASE IF EXISTS vpc_dev;
CREATE DATABASE IF NOT EXISTS vpc_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE vpc_dev; 

CREATE TABLE equipos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, -- Nombre completo del equipo
    descripcion TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE jugadores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    equipo_id BIGINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    posicion VARCHAR(50),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR(50),
    foto VARCHAR(255),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (equipo_id) REFERENCES equipos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE club_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seccion VARCHAR(50) NOT NULL, -- 'historia', 'junta', 'estadi', 'palmares'
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT,
    imagen_principal VARCHAR(255),
    orden INT DEFAULT 0,
    idioma VARCHAR(10) DEFAULT 'ca', -- 'ca', 'es', 'fr', 'en', etc. (opcional)
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE socios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    telefono VARCHAR(50),
    direccion VARCHAR(255),
    fecha_alta DATE,
    tipo_socio VARCHAR(50),
    estado VARCHAR(50) DEFAULT 'Activo', -- Activo, Baja, Moroso, etc.
    iban VARCHAR(34), -- IBAN máximo 34 caracteres (estándar internacional)
    titular_cuenta VARCHAR(150),
    aceptacion_rgpd DATE, -- fecha en que aceptó la política de privacidad
    observaciones TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE noticias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT,
    imagen_principal VARCHAR(255),
    fecha_publicacion DATETIME,
    autor VARCHAR(100),
    fuente VARCHAR(100) DEFAULT 'club', -- 'club', 'andorradifusio', 'otro'
    link_fuente VARCHAR(255), -- si la noticia es externa
    visible BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE patrocinadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    logo VARCHAR(255),
    url_web VARCHAR(255),
    descripcion TEXT,
    orden INT DEFAULT 0,
    visible BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE productos_tienda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255),
    precio DECIMAL(10,2),
    categoria VARCHAR(100),
    link_externo VARCHAR(255),
    orden INT DEFAULT 0,
    visible BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO equipos (nombre, descripcion) VALUES
('PRIMER EQUIP', 'Primer equip del club.'),
('SEGON EQUIP', 'Segon equip del club.'),
('EQUIP FEMENÍ', 'Equip femení del club.'),
('SUB18', 'Equip juvenil Sub18 del club.'),
('SUB16', 'Equip juvenil Sub16 del club.'),
('SUB14', 'Equip infantil Sub14 del club.');

INSERT INTO productos_tienda (nombre, descripcion, imagen, precio, categoria, link_externo, orden, visible) VALUES
('Pack BASIC VPC ANDORRA RUGBY', 'Pack BASIC per a l\'escola que inclou Samarreta d\'entrenament, Jaqueta de xandall, Pantalons de xandall, Pol SATURN. Comandes abans del 15 de juliol per a recepció al setembre.', '/botiga/pack_basic.png', 145.00, 'Packs', 'https://claplx.shop/ca/products/pack-basic-vpc-andorra-rugby', 1, TRUE),
('Pack PREMIUM VPC ANDORRA RUGBY', 'Pack PREMIUM per a l\'escola que inclou Samarreta d\'entrenament, Jaqueta de xandall, Pantalons de xandall, Pol SATURN, ANORAK ANTÀRTIDA, Pantalons de joc sublimat, Mitjons de joc LLIS, Motxilla CARRY.', '/botiga/pack_premium.png', 185.00, 'Packs', 'https://claplx.shop/ca/products/pack-premium-vpc-andorra-rugby', 2, TRUE),
('Samarreta de cotó PLUTÓ CLAP', 'Samarreta de cotó de coll rodó del VPC Andorra. Material 100% Cotó, punt llis, 190 g/m². Certificat UV801. Lliurament a 15 dies.', '/botiga/samarreta_pluto.png', 12.00, 'Samarretes', 'https://claplx.shop/ca/products/camiseta-tecnica-clap-atomic', 3, TRUE),
('Samarreta de cotó WOM CLAP VALQUIR', 'Samarreta de màniga curta entallada. Coll rodó de canalé 1x1, costures laterals. Material 100% cotó, punt llis, 170 g/m². Lliurament a 15 dies.', '/botiga/samarreta_valquir.png', 12.00, 'Samarretes', 'https://claplx.shop/ca/products/camiseta-tecnica-clap-atomic-copy', 4, TRUE),
('Polo CLAP SATURN VPC AND. RUGBY XV', 'Polo d\'home i nen de màniga curta. Costures laterals, tapeta amb tres botons. Material 100% cotó, punt piqué, 200 g/m².', '/botiga/polo_saturn.png', 17.00, 'Polos', 'https://claplx.shop/ca/products/polo-clap-saturno', 5, TRUE),
('Jaqueta de Xandall CLAP YEMEN', 'Jaqueta de xandall 100% polièster. Tall recte. Mànigues raglan. Canalé al coll, punys i baix. Dues butxaques laterals amb cremallera. Escut amb woven i lletres en transfer.', '/botiga/jaqueta_yemen.png', 28.00, 'Jaquetes', 'https://claplx.shop/ca/products/camiseta-tecnica-clap-atomic-copy-1', 6, TRUE),
('Pantalons de xandall CONCACAF VPC ANDORRA RUGBY', 'Pantalons de xandall 96% polièster reciclat / 4% elastà. Tall recte. 2 butxaques laterals amb cremallera. Cintura elàstica amb cordó. Logos a Woven.', '/botiga/pantalons_concacaf.png', 25.00, 'Pantalons', 'https://claplx.shop/ca/products/pantalon-de-chandal-america-vpc-andorra-rugby', 7, TRUE),
('Anorak ANTÀRTIDA VPC ANDORRA RUGBY', 'Parka encoixinada impermeable. Coll alt amb caputxa plegada i extraïble. Butxaques exteriors i interiors. Punys ajustables. Logo a Woven.', '/botiga/anorak_antartida.png', 30.00, 'Jaquetes', 'https://claplx.shop/ca/products/anorak-antartida-vpc-andorra-rugby', 8, TRUE),
('Impermeable CLAP VPC ANDORRA RUGBY', 'Chubasquer impermeable. Coll alt i caputxa extraïble. Dues butxaques laterals. Punys elàstics. Baix ajustable. Es pot plegar dins la seva pròpia butxaca.', '/botiga/impermeable_clap.png', 24.00, 'Jaquetes', 'https://claplx.shop/ca/products/impermeable-clap-vpc-andorra-rugby', 9, TRUE),
('Pantalons de rugbi de JOC sublimat VPC ANDORRA RUGBY', 'Pantalons de rugbi sublimat 100% polièster i elastà. Tela de 220gm. Peces d\'elastà per a màxim confort. Producte sublimat disponible a partir de novembre.', '/botiga/pantalons_joc_sublimat.png', 32.00, 'Pantalons', 'https://claplx.shop/ca/products/pantalon-de-rugby-sublimado-vpc-andorra-rugby', 10, TRUE),
('Pantalons de rugbi d\'entrenament CLAP Elite VPC Andorra rugby', 'Pantalons de rugbi 100% sarja de polièster. Cintura elàstica amb cordó i silicona antilliscant. Panell stretch. Costures reforçades.', '/botiga/pantalons_entrenament_elite.png', 20.00, 'Pantalons', 'https://claplx.shop/ca/products/pantalon-de-rugby-clap-elite-vpc-andorra-rugby', 11, TRUE),
('Mitjons de joc LLIS VPC ANDORRA RUGBY', 'Mitjons CLAP 95% polièster. Part superior elàstica. Tira antilliscant. Teixit de ris a la planta del peu.', '/botiga/mitjons_llis.png', 8.00, 'Mitjons', 'https://claplx.shop/ca/products/calcetines-de-juego-liso-vpc-andorra-rugby', 12, TRUE),
('Samarreta RIGEL RC SENGLARS', 'Samarreta esportiva Rigel en teixit Evertex (100% Polièster). Còmoda i resistent, ideal per a partits i entrenaments. Logo imprès en transfer serigràfic.', '/botiga/samarreta_rigel_senglars_1.png', 20.00, 'Samarretes', 'https://claplx.shop/ca/products/camiseta-rigel-rc-senglars-copia', 13, TRUE),
('Samarreta RIGEL RC SENGLARS', 'Samarreta esportiva Rigel en teixit Evertex (100% Polièster). Còmoda i resistent, ideal per a partits i entrenaments. Logo imprès en transfer serigràfic.', '/botiga/samarreta_rigel_senglars_2.png', 20.00, 'Samarretes', 'https://claplx.shop/ca/products/camiseta-rigel-vpc-andorra-rugby-violeta', 14, TRUE),
('Samarreta RIGEL RC SENGLARS', 'Samarreta esportiva Rigel en teixit Evertex (100% Polièster). Còmoda i resistent, ideal per a partits i entrenaments. Logo imprès en transfer serigràfic.', '/botiga/samarreta_rigel_senglars_3.png', 20.00, 'Samarretes', 'https://claplx.shop/ca/products/camiseta-rigel-vpc-andorra-rugby-verde-fluo', 15, TRUE),
('Samarreta RIGEL RC SENGLARS', 'Samarreta esportiva Rigel en teixit Evertex (100% Polièster). Còmoda i resistent, ideal per a partits i entrenaments. Logo imprès en transfer serigràfic.', '/botiga/samarreta_rigel_senglars_4.png', 20.00, 'Samarretes', 'https://claplx.shop/ca/products/camiseta-rigel-vpc-andorra-rugby-azul-cielo', 16, TRUE),
('Dessuadora SALZACH AHG', 'Dessuadora de coll rodó en teixit Poly Dry. Lleugera i confortable. Puny amb riba de lycra. Rivets sobre les espatlles. Lliurament aproximadament 10 dies hàbils.', '/botiga/dessuadora_salzach.png', 25.00, 'Dessuadores', 'https://claplx.shop/ca/products/sudadera-salzach-ahg-copia', 17, TRUE),
('Samarreta tèrmica CLAP VPC ANDORRA RUGBY', 'Samarreta tèrmica elàstica. Material: 92% poliamida / 8% elastà, 200 g/m². Lliurament en 10 dies hàbils.', '/botiga/samarreta_termica_clap.png', 15.50, 'Samarretes tècniques', 'https://claplx.shop/ca/products/camiseta-termica-clap-vpc-andorra-rugby', 18, TRUE),
('Motxilla CARRY VPC ANDORRA RUGBY', 'Motxilla esportiva en polièster 600D. Base rígida extraïble. Dues butxaques laterals i un targeter. 42L. Logo imprès en transfer serigràfic.', '/botiga/motxilla_carry.png', 30.00, 'Complements', 'https://claplx.shop/ca/products/mochila-carry-vpc-andorra-rugby', 19, TRUE),
('Trolley CLAP VPC ANDORRA RUGBY', 'Bossa/ Trolley esport gran amb rodes en polièster 600D. Àmplia obertura superior. Compartiment lateral per a sabates. Corretges reforçades. Reforços per a més fermesa.', '/botiga/trolley_clap.png', 40.00, 'Bosses i Trolleys', 'https://claplx.shop/ca/products/trolley-clap-vpc-andorra-rugby', 20, TRUE),
('Trolley MACRON COMPASS 72L VPC ANDORRA RUGBY', 'Trolley esportiu de 72L. El lliurament es farà a 15 dies de la data de compra.', '/botiga/trolley_macron_compass.png', 50.00, 'Bosses i Trolleys', 'https://claplx.shop/ca/products/trolley-macron-vpc-andorra-rugby-copia', 21, TRUE),
('Bossa esportiva CLAP BIG VPC Andorra Rugby', 'Bossa esportiva en polièster 600D. Dues butxaques laterals, compartiment per sabates, corretja d\'espatlla encoixinada i extraïble. Model gran: 85L.', '/botiga/bossa_big_clap.png', 28.00, 'Bosses i Trolleys', 'https://claplx.shop/ca/products/bolsa-de-deporte-clap-big-vpc-andorra-rugby', 22, TRUE),
('Porta botes CLAP BOOTS VPC ANDORRA RUGBY', 'Bossa porta sabates de polièster 600D. Nansa teixida. Tancament amb cremallera.', '/botiga/porta_botes.png', 8.00, 'Complements', 'https://claplx.shop/ca/products/porta-botas-clap-boots-vpc-andorra-rugby', 23, TRUE),
('Buff ANVIK MACRON VPC ANDORRA RUGBY', 'Buff Polar Macron. El termini de lliurament serà aproximadament de 10 dies hàbils.', '/botiga/buff_anvik.png', 8.00, 'Complements', 'https://claplx.shop/ca/products/buff-anvik-macron-vpc-andorra-rugby', 24, TRUE),
('Barret llana SNOW CP SANTA PAU', 'Barret suau i còmode. Amb pompó to sobre to, canalé i logotip Macron Hero brodat a la part davantera.', '/botiga/barret_snow.png', 15.00, 'Complements', 'https://claplx.shop/ca/products/gorro-lana-snow-vpc-andorra-rugby', 25, TRUE);

INSERT INTO patrocinadores (nombre, logo, url_web, descripcion, orden, visible) VALUES
('River', '/patrocinadors/river.png', 'https://river.ad/', 'Patrocinador oficial del club.', 1, TRUE),
('Grup Heracles', '/patrocinadors/grup_heracles.png', 'https://www.grupheracles.com/Inici', 'Patrocinador oficial del club.', 2, TRUE),
('Globalrisc', '/patrocinadors/globalrisc.png', 'https://globalrisc.ad/', 'Patrocinador oficial del club.', 3, TRUE),
('Signum', '/patrocinadors/signum.png', 'https://www.clickandbrew.com/portfolio-item/signum-andorra/', 'Patrocinador oficial del club.', 4, TRUE),
('Dona Secret', '/patrocinadors/donasecret.png', 'https://www.donasecret.com/', 'Patrocinador oficial del club.', 5, TRUE),
('Intertrans S.L.', '/patrocinadors/intertrans.png', 'https://intertrans.ad/', 'Patrocinador oficial del club.', 6, TRUE),
('Autoescola Olímpica', '/patrocinadors/autoescola.png', 'https://www.autoescolaolimpica.com/', 'Patrocinador oficial del club.', 7, TRUE),
('El Rebost del Padrí', '/patrocinadors/elrebost.png', 'https://www.rebostdelpadri.com/', 'Patrocinador oficial del club.', 8, TRUE),
('IDPA', '/patrocinadors/idpa.png', 'https://www.idpa.ad/', 'Patrocinador oficial del club.', 9, TRUE),
('Visita Andorra', '/patrocinadors/visita_andorra.png', 'https://visitandorra.com/ca/', 'Patrocinador oficial del club.', 10, TRUE),
('Idees Il·luminat', '/patrocinadors/idees.png', 'https://www.instagram.com/idees_il.luminat/', 'Patrocinador oficial del club.', 11, TRUE),
('Spit', '/patrocinadors/spit.png', 'https://www.instagram.com/spitpaslodeandorra/', 'Patrocinador oficial del club.', 12, TRUE);


INSERT INTO club_info (seccion, titulo, contenido, imagen_principal, idioma, orden, creado_en, actualizado_en) VALUES
('junta', 'Junta Directiva', 
'
<ul>
    <li><strong>Felip Gallardo</strong> - President <br> Contacte</li>
    <li><strong>Albert Granyena</strong> - Vicepresident <br> Contacte</li>
    <li><strong>Carles Acosta</strong> - Secretari General <br> Contacte</li>
    <li><strong>Bea Morales</strong> - Tresorera i Marquèting <br> Contacte</li>
    <li><strong>Ernesto Perez</strong> - VP Esportiu <br> Contacte</li>
    <li><strong>Schalk Cronje</strong> - VP Comunitat <br> Contacte</li>
    <li><strong>Gemma Pujal</strong> - Vocal</li>
    <li><strong>Daniel Raya</strong> - Mànager Esportiu <br> Contacte</li>
    <li><strong>Gerard Menardia</strong> - Delegat de Camp FER</li>
</ul>
', 
'/club_info/junta.jpg', 'ca', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO club_info (seccion, titulo, contenido, imagen_principal, idioma, orden, creado_en, actualizado_en) VALUES
('estadi', 'Estadi Prada de Moles', 
'
<p><strong>Estadi actual:</strong> Prada de Moles</p>
<p><strong>Adreça:</strong> Av. de Joan Martí, Encamp AD200 Andorra</p>
<p>L\'Estadi Prada de Moles és l\'actual seu dels partits del VPC Andorra Rugby Club. Situat a la parròquia d\'Encamp, ofereix unes instal·lacions modernes per a la pràctica i competició del rugbi.</p>
', 
'/club_info/estadi.jpg', 'ca', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO club_info (seccion, titulo, contenido, imagen_principal, idioma, orden, creado_en, actualizado_en) VALUES
('historia', 'La Història del VPC Andorra Rugby XV', 
'
<p>El rugbi és un dels esports amb més tradició a Andorra. El VPC Andorra Rugby XV va néixer l\'any 1963, després de la creació de la Secció de Rugbi del Futbol Club Andorra el 1961. Les sigles VPC (Voluntaris de Protecció Civil) reflecteixen l’esperit de servei a la comunitat que acompanya el club des dels seus inicis.</p>

<p>Inicialment afiliat a la Federació Catalana de Rugbi, el club va aconseguir ràpidament destacar dins del panorama català i estatal, tot i les limitacions imposades a la seva progressió per motius reglamentaris.</p>

<p>Per cercar nous reptes, el VPC Andorra va optar per competir a França a partir de la temporada 1986-87. Aquesta nova etapa va permetre al club créixer esportivament i consolidar-se dins les competicions del Comitè Migdia-Pirineus, assolint diversos èxits.</p>

<p>El 2022, després de més de 35 anys competint a França, el club va decidir tornar a participar en els Campionats de la Federació Catalana de Rugbi. Aquest retorn ha estat marcat per grans èxits, destacant les victòries a la Divisió d\'Honor Catalana les temporades 2022-23 i 2023-24.</p>

<p>Actualment, el VPC Andorra Rugby XV representa Andorra a nivell internacional. L\'equip Sènior A Masculí competeix a la Divisió d\'Honor B Espanyola, amb l\'ambició d\'assolir la màxima categoria. El club continua creixent gràcies a l\'impuls de l\'escola de rugbi, els equips de base i l\'equip femení.</p>
', 
'/club_info/historia.jpeg', 'ca', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO club_info (seccion, titulo, contenido, imagen_principal, idioma, orden, creado_en, actualizado_en) VALUES
('palmares', 'Palmarès', 
'
<ul>
  <li><strong>Campió de la Divisió d\'Honor Catalana </strong>: <em>Temporades 2022-23 i 2023-24</em></li>
  <li><strong>Finalista del Campionat Migdia-Pirineus </strong> (França): <em>2 finals consecutives</em></li>
  <li><strong>Campió de la Copa Catalana </strong>(diverses edicions)</li>
  <li><strong>Victòries destacades davant equips de Divisió d\'Honor Espanyola </strong> (U.E. Santboiana, F.C. Barcelona, R.C. Cornellà)</li>
</ul>
', 
'/club_info/palmares.jpg', 'ca', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO jugadores (equipo_id, nombre, posicion, fecha_nacimiento, nacionalidad, foto, creado_en, actualizado_en) VALUES
(1, 'JD Sinvatu Kanth', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Bruno Comas Escoda', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Lluc Cunill Rodríguez', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Xavier Vicente Cebadero', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Ramiro Andrés Yannetii', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Jean Maurice Calvet Galdríc', 'Flanker esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Cristian Emanuel Abarca', 'Flanker dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Ignacio Traversa', 'Número 8', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Josep Arasanz Avila', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Sacha Nathan Franken', 'Mig d\'obertura', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Juan Pablo Minuzzi', 'Ala esquerra', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Samuel Sacha Franken', 'Centre interior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Ian Granyena Pujal', 'Centre exterior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Adrià Calvo Bellocq', 'Ala dreta', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Ramiro Pedro Gandini', 'Darrer home / Fullback', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Miquel Ortega Barreiro', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Adrià Casals Molné', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Iuvo Bazi', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Albert Pons Ibáñez', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Nicolás Ruiz Gracia', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Héctor Pascual Navarro', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Jan Pujol Martínez', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Gustavo Thomas Zamora', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO jugadores (equipo_id, nombre, posicion, fecha_nacimiento, nacionalidad, foto, creado_en, actualizado_en) VALUES
(2, 'Arnau Granyena Pujal', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Miquel Ortega Barreiro', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Lucas Esteban Castillo', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Adrián Castillo López', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Gorka De Oliveira Rivas', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Kevin Courrieu Cecilia', 'Flanker esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Jan Pujol Martínez', 'Flanker dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Adrià Pintat Marrugat', 'Número 8', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Guillem Badia Avenia', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Jake Michael John Gover', 'Mig d\'obertura', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Tomás Pendito Aznar', 'Ala esquerra', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Louis Bourrelly', 'Centre interior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Victor Casajuana Mukendi', 'Centre exterior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Marc Pujol Martínez', 'Ala dreta', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Sacha Nathan Franken', 'Darrer home / Fullback', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Josep Ortega Barreiro', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Adrià Pintat Marrugat', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Abel Barrera Matias', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Nil Correia Calizares', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Tiago Macedo Ribeiro', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Eric Garcia Brihi', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Pol Roig Pintat', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Mauro Ricardo Seguel', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO jugadores (equipo_id, nombre, posicion, fecha_nacimiento, nacionalidad, foto, creado_en, actualizado_en) VALUES
(3, 'Yaiza Valero Paños', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Chiara Cerqueda Frau', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Roser Puigbo Pons', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Andreia Teixeira Pinto', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Carmen Ocariz Llopis', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Lea Mora', 'Flanker esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Frida Jimenez Espin', 'Flanker dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Erika Maldonado Prat', 'Número 8', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Emma Latorre', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Lucie Melgar', 'Mig d\'obertura', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Miren Barciala Garcia', 'Ala esquerra', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Carla Micas Sillé', 'Centre interior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Maria Areny Monzonis', 'Centre exterior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Naima Perisse Pons', 'Ala dreta', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Cristina Modesto De Sousa', 'Darrera dona / Fullback', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Elia Taulats Mcdonald', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Laly Moreau Serrano', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Daniela Ferreira Machado', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Lea Bonell Navarro', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Sofia Ledesma Almiron', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO jugadores (equipo_id, nombre, posicion, fecha_nacimiento, nacionalidad, foto, creado_en, actualizado_en) VALUES
(4, 'King Iñigo Andaya', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Tomas Moreno Ojeda', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Patrick Martisella Sió', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Macéo Boher', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Marc Gouarre Riba', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Ethan Compan Palmijavila', 'Flanker esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Miquel Alberca Rico', 'Flanker dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Joan Pujadas Casas', 'Número 8', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Oriol Ricart Garcia', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Lucie Almeyda Valle', 'Mig d\'obertura', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Eric Dos Santos Bessa', 'Ala esquerra', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Miren Almeyda Valle', 'Centre interior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Unai Xarpell Bonet', 'Centre exterior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Adrià Lechantre Prats', 'Ala dreta', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Daniel Armengol Taboas', 'Darrer home / Fullback', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Daniel Jimenez Marín', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Dylan Pires Soldevila', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Adam Issac Taghouti Toumi', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Lluc Granyena Pujal', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Ian Pires Soldevila', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Valentí Rameau Tor', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Juan Cruz Carmona Roco', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO jugadores (equipo_id, nombre, posicion, fecha_nacimiento, nacionalidad, foto, creado_en, actualizado_en) VALUES
(5, 'Cristian Gil Rodrigues', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Dario Rekordi', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Nihad Ruchdi El Mohmoun', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Guido Naranjo Casabella', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Valentí Farrés Lafuente', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Noa Díaz Fernandez', 'Flanker esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Roc Alsina Mujal', 'Flanker dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Salma Akaou Zarich', 'Número 8', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Raphael Ducreux Poueymirou', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Conrad Armengol Daban', 'Mig d\'obertura', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Gerard Alguacil Torné', 'Ala esquerra', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Maximo Gustavo Castillo', 'Centre interior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Tomas Hoxha', 'Centre exterior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Lua Garcia Gascon', 'Ala dreta', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Marc Cases Estel', 'Darrer home / Fullback', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Gala Jimenez Espín', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Mario Alcolea Solé', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Betserai Martinez Portugal', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Abel Ayed Brun', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Anna Georget Bort', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Eric Berenguer Navarro', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO jugadores (equipo_id, nombre, posicion, fecha_nacimiento, nacionalidad, foto, creado_en, actualizado_en) VALUES
(6, 'Jan Simon Garrofe', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Teo Georget', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Adria Garcia Lopez', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Antonio Tchelidze', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Ton Samarra Almeyda', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Tatiana Marques Amorim', 'Flanker esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Elyes Ben Moussa Garcia', 'Flanker dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Alvaro Cruz Perez', 'Número 8', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Apolllin Pinchon', 'Mig de melé', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Gil Fité Junyer', 'Mig d\'obertura', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Sam Vallès Van Der Wekken', 'Ala esquerra', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Aina Gaset Candela', 'Centre interior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Brais Rubinos Pollán', 'Centre exterior', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Arnau Casas Montejo', 'Ala dreta', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Roy Vilalta Marin', 'Darrer home / Fullback', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Francesc Dos Santos Fantova', 'Pilier Esquerre', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Teodoro Fernando Vega Constantin', 'Taloner', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Mathieu Penin-Peyta Diaz Crespo', 'Pilier Dret', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Arti Adrià Lechantre Prats', 'Segona línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Aitor Corbalan', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Carla Cuito Rosas', 'Tercera línia', NULL, '', '/images/jugadores/default.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO noticias (
    titulo,
    contenido,
    imagen_principal,
    fecha_publicacion,
    autor,
    fuente,
    link_fuente,
    visible
) VALUES (
    'Assemblea del VPC – Nova Junta Directiva per als propers 4 anys',
    'Ahir, 24 d’abril, es va celebrar l’assemblea anual del VPC, una cita clau per al futur del nostre club. En un ambient de participació i compromís, es va procedir a la votació de la nova Junta Directiva, que encapçalarà el projecte del VPC durant els propers quatre anys.\n\nVolem expressar el nostre més sincer agraïment a la junta sortint per la seva dedicació, la feina incansable i la passió amb què han treballat per fer créixer el club. Gràcies per aquests anys de servei i per deixar un llegat del qual estem profundament orgullosos.\n\nAl mateix temps, donem la benvinguda a la nova Junta Directiva i els desitgem molta sort i encerts en aquesta nova etapa. Compten amb tot el nostre suport per continuar fent del VPC un club fort, unit i amb mirada de futur.\n\nEndavant VPC!',
    '/noticia/assamblea',
    '2025-04-25 00:00:00',
    'Junta',
    'club',
    NULL,
    TRUE
);

