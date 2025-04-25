/*TABLAS*/
--Campañas--
CREATE TABLE Campañas(
idCampaña VARCHAR2(9) NOT NULL,
nombre VARCHAR2(50) NOT NULL,
juego VARCHAR2(6) NOT NULL,
jugadores NUMBER(1) NOT NULL,
dificultad VARCHAR2(10) NOT NULL
);

--Calaveras--
CREATE TABLE Calaveras(
idCalavera VARCHAR2(9) NOT NULL,
nombre VARCHAR2(50) NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
tipoCalavera VARCHAR2(12) NOT NULL,
idCampaña VARCHAR2(9) NOT NULL
);

--Mapas--
CREATE TABLE Mapas(
nombre VARCHAR2(100) NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
juego VARCHAR2(6) NOT NULL,
lugar VARCHAR2(10) NOT NULL,
bioma VARCHAR2(8) NOT NULL
);

--PersonajesporMapa--
CREATE TABLE PersonajesporMapas(
nombrePersonaje VARCHAR2(50) NOT NULL,
nombreMapa VARCHAR2(100) NOT NULL
);

--Personajes--
CREATE TABLE Personajes(
nombre VARCHAR2(50) NOT NULL,
grupo CHAR(1) NOT NULL,
juego VARCHAR2(6) NOT NULL, 
descripcion VARCHAR2(700) NOT NULL,
rol VARCHAR2(11) NOT NULL,
desaparecidos CHAR(1) NOT NULL,
idCampaña VARCHAR2(9) NOT NULL,
vida number(4) NOT NULL
);

--Humanos--
CREATE TABLE Humanos(
nombreHumano VARCHAR2(50) NOT NULL,
rango VARCHAR2(2) NOT NULL,
armadura NUMBER(3)
);

--Floods--
CREATE TABLE Floods(
nombreFlood VARCHAR2(50) NOT NULL,
tiposInfectados VARCHAR2(12) NOT NULL,
huesped VARCHAR2(11)
);

--Covenant--
CREATE TABLE Covenant(
nombreCovenant VARCHAR2(50) NOT NULL,
especieAlien VARCHAR2(10) NOT NULL,
jerarquia NUMBER(1) NOT NULL,
rango VARCHAR2(2) NOT NULL,
herejes CHAR(1) NOT NULL,
armadura NUMBER(3)
);

--Potenciadores--
CREATE TABLE Potenciadores(
nombrePotenciador VARCHAR2(50) NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
grupo CHAR(1) NOT NULL,
durabilidad NUMBER(2) NOT NULL
);

--Granadas--
CREATE TABLE Granadas(
nombreGranada VARCHAR2(70) NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
alcance NUMBER(2) NOT NULL,
dano NUMBER(3) NOT NULL,
acumulado NUMBER(1) NOT NUll
);

--Armamentos--
CREATE TABLE Armamentos(
nombre VARCHAR2(50) NOT NULL,
definicion VARCHAR2(700) NOT NULL,
juego VARCHAR2(6) NOT NULL,
grupo CHAR(1) NOT NULL,
dano NUMBER(3) NOT NULL,
manejo VARCHAR2(7) NOT NULL,
peso NUMBER(3) NOT NULL,
nombreGranada VARCHAR2(50),
nombrePotenciador VARCHAR2(50),
nombrePersonaje VARCHAR2(50)
);

--Vehiculos--
CREATE TABLE Vehiculos(
nombreVehiculo VARCHAR2(50) NOT NULL,
asiento NUMBER(2) NOT NULL,
durabilidad NUMBER(4) NOT NULL,
velocidad NUMBER(3) NOT NULL,
altitud VARCHAR2(10),
tipoVehiculo VARCHAR2(10) NOT NULL
);

--Armas--
CREATE TABLE Armas(
nombreArma VARCHAR2(50) NOT NULL,
alcance NUMBER(3) NOT NULL,
capacidad NUMBER(3) NOT NULL,
rareza CHAR(1) NOT NULL,
idMunicion VARCHAR2(10),
tipoArma VARCHAR2(14)
);

--Municiones--
CREATE TABLE Municiones(
idMunicion VARCHAR2(10) NOT NULL,
material VARCHAR2(11) NOT NULL,
calibre NUMBER(2) NOT NULL,
cargador NUMBER(2) NOT NULL
);

--Logros--
CREATE TABLE Logros(
nombre VARCHAR2(100) NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
juego VARCHAR2(6) NOT NULL,
obtencion NUMBER(1) NOT NULL,
fecha DATE NOT NULL,
idUsuario VARCHAR2(12) NOT NULL
);

--ModoJuegos--
CREATE TABLE ModoJuegos(
idModo VARCHAR2(9) NOT NULL,
nombre VARCHAR2(20) NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
duracion NUMBER(2) NOT NULL,
jugadores NUMBER(2) NOT NULL,
puntuacion NUMBER(4) NOT NULL
);

--UsuariosporModos--
CREATE TABLE UsuariosporModos(
idUsuario VARCHAR2(12) NOT NULL,
idModo VARCHAR2(9) NOT NULL
);

--Usuarios--
CREATE TABLE Usuarios(
idUsuario VARCHAR2(12) NOT NULL,
correo VARCHAR2(150) NOT NULL,
nombreUsuario VARCHAR2(50) NOT NULL,
descripcion VARCHAR2(700),
fechaInicio DATE NOT NULL,
fechaFin DATE, 
acreditacion NUMBER(1) NOT NULL
);

--Usuarios Por Foros--
CREATE TABLE UsuariosporForos(
idUsuario VARCHAR2(12) NOT NULL,
nombreForo VARCHAR2(50) NOT NULL
);

--Foros--
CREATE TABLE Foros(
nombre VARCHAR2(50) NOT NULL,
tema VARCHAR2(70) NOT NULL,
juego VARCHAR2(6),
fecha DATE NOT NULL,
descripcion VARCHAR2(700) NOT NULL,
calificacion NUMBER(7) NOT NULL
);

--Solicitudes--
CREATE TABLE Solicitudes(
idSolicitud VARCHAR2(10) NOT NULL ,
descripcion VARCHAR2(700) NOT NULL,
estado CHAR(1) not null,
fechaCreacion DATE NOT NULL,
fechaFinalizacion DATE,
justificacion VARCHAR(700),
idUsuario VARCHAR2(12) NOT NULL
);

--UsuariosporCampañas--
CREATE TABLE UsuariosporCampañas(
idUsuario VARCHAR2(12) NOT NULL,
idCampaña VARCHAR2(9) NOT NULL
);

/*ATRIBUTOS*/
ALTER TABLE Campañas ADD CONSTRAINT CK_campaña_juego CHECK (juego IN ('HALO 1', 'HALO 2', 'HALO 3', 'HALO 4', 'REACH', '3ODST', 'C.E'));
ALTER TABLE Campañas ADD CONSTRAINT CK_campaña_dificultad CHECK (dificultad IN ('facil', 'normal', 'heroico', 'legendario'));
ALTER TABLE Campañas ADD CONSTRAINT CK_campaña_jugador CHECK (jugadores > 0 AND jugadores <= 4);
ALTER TABLE Calaveras ADD CONSTRAINT CK_calavera_tipo CHECK (tipoCalavera IN ('dificultad', 'experiencia'));
ALTER TABLE Mapas ADD CONSTRAINT CK_mapa_juego CHECK (juego IN ('HALO 1', 'HALO 2', 'HALO 3', 'HALO 4', 'REACH', '3ODST', 'C.E'));
ALTER TABLE Mapas ADD CONSTRAINT CK_mapa_lugar CHECK (lugar IN ('espacial', 'planetario', 'nave'));
ALTER TABLE Mapas ADD CONSTRAINT CK_mapa_bioma CHECK (bioma IN ('montaña', 'desierto', 'pantano', 'ciudad', 'nevado', 'isla', 'espacio', 'jungla', 'mar'));
ALTER TABLE Personajes ADD CONSTRAINT CK_personaje_grupo CHECK (grupo IN ('C', 'H', 'F'));
ALTER TABLE Personajes ADD CONSTRAINT CK_personaje_juego CHECK (juego IN ('HALO 1', 'HALO 2', 'HALO 3', 'HALO 4', 'REACH', '3ODST', 'C.E'));
ALTER TABLE Personajes ADD CONSTRAINT CK_personaje_bool CHECK (desaparecidos IN ('T', 'F'));
ALTER TABLE Personajes ADD CONSTRAINT CK_personaje_rol CHECK (rol IN ('principal', 'secundario', 'NPC', 'antagonista'));
ALTER TABLE Personajes ADD CONSTRAINT CK_personaje_vida CHECK (vida >= 100 and vida <= 2000);
ALTER TABLE Humanos ADD CONSTRAINT CK_humano_rango CHECK (rango IN ('A', 'B', 'C', 'D', 'S', 'SS'));
ALTER TABLE Humanos ADD CONSTRAINT CK_humano_armadura CHECK (armadura >= 0 AND armadura <= 100);
ALTER TABLE Floods ADD CONSTRAINT CK_flood_tipo CHECK (tiposInfectados IN ('combate', 'elite', 'humano', 'portadora', 'infeccion', 'gravemind', 'pura', 'desconocida'));
ALTER TABLE Floods ADD CONSTRAINT CK_flood_huesped CHECK (huesped IN ('sensible', 'no sensible'));
ALTER TABLE Covenant ADD CONSTRAINT CK_covenant_rango CHECK (rango IN ('A', 'B', 'C', 'D', 'S', 'SS'));
ALTER TABLE Covenant ADD CONSTRAINT CK_covenant_jerarquia CHECK (jerarquia > 0 AND jerarquia < 7);
ALTER TABLE Covenant ADD CONSTRAINT CK_covenant_especiealien CHECK (especieAlien IN ('elite', 'grunt', 'brute', 'jackal', 'profeta', 'drone', 'hunter', 'ingeniero'));
ALTER TABLE Covenant ADD CONSTRAINT CK_covenant_herejes CHECK (herejes IN ('T', 'F'));
ALTER TABLE Covenant ADD CONSTRAINT CK_covenant_armadura CHECK (armadura >= 0 AND armadura <= 100);
ALTER TABLE Potenciadores ADD CONSTRAINT CK_potenciador_grupo CHECK (grupo IN ('C', 'H', 'F'));
ALTER TABLE Potenciadores ADD CONSTRAINT CK_potenciador_durabilidad CHECK (durabilidad >= 5 AND durabilidad <= 30);
ALTER TABLE Granadas ADD CONSTRAINT CK_granada_daño CHECK (dano >= 50 AND dano <= 100);
ALTER TABLE Granadas ADD CONSTRAINT CK_granada_alcance CHECK (alcance >= 0 AND alcance <= 10);
ALTER TABLE Granadas ADD CONSTRAINT CK_granada_acumulado CHECK (acumulado >= 1 AND acumulado <= 4);
ALTER TABLE Armamentos ADD CONSTRAINT CK_armamento_juego CHECK (juego IN ('HALO 1', 'HALO 2', 'HALO 3', 'HALO 4', 'REACH', '3ODST', 'C.E'));
ALTER TABLE Armamentos ADD CONSTRAINT CK_armamento_grupo CHECK (grupo IN ('C', 'H', 'F'));
ALTER TABLE Armamentos ADD CONSTRAINT CK_armamento_daño CHECK (dano >= 50 AND dano <= 300);
ALTER TABLE Armamentos ADD CONSTRAINT CK_armamento_manejo CHECK (manejo IN ('facil', 'medio', 'dificil'));
ALTER TABLE Armamentos ADD CONSTRAINT CK_armamento_peso CHECK (peso > 0 and peso < 900);
ALTER TABLE Vehiculos ADD CONSTRAINT CK_vehiculo_asiento CHECK (asiento >=0 AND asiento <= 20);
ALTER TABLE Vehiculos ADD CONSTRAINT CK_vehiculo_durabilidad CHECK (durabilidad >= 200 AND durabilidad <= 2000);
ALTER TABLE Vehiculos ADD CONSTRAINT CK_vehiculo_velocidad CHECK (velocidad >= 20 AND velocidad <= 200);
ALTER TABLE Vehiculos ADD CONSTRAINT CK_vehiculo_altitud CHECK (altitud IN ('espacio', 'planetario'));
ALTER TABLE Vehiculos ADD CONSTRAINT CK_vehiculo_tipo CHECK (tipoVehiculo IN ('Terrestre','Aereo'));
ALTER TABLE Armas ADD CONSTRAINT CK_arma_alcance CHECK (alcance >= 0 AND alcance <= 200);
ALTER TABLE Armas ADD CONSTRAINT CK_arma_capacidad CHECK (capacidad >= 0 AND capacidad <= 300);
ALTER TABLE Armas ADD CONSTRAINT CK_arma_rareza CHECK (rareza IN ('C', 'R', 'E', 'L'));
ALTER TABLE Armas ADD CONSTRAINT CK_arma_tipoarma CHECK (tipoArma IN ('fusil', 'escopeta', 'francotirador', 'explosivo', 'cuerpo'));
ALTER TABLE Municiones ADD CONSTRAINT CK_municion_material CHECK (material IN ('plasma', 'metal', 'cristales', 'energia', 'combustible'));
ALTER TABLE Municiones ADD CONSTRAINT CK_municion_calibre CHECK (calibre >= 4 AND calibre <= 11);
ALTER TABLE Municiones ADD CONSTRAINT CK_municion_cargador CHECK (cargador >= 0 AND cargador <= 30);
ALTER TABLE Logros ADD CONSTRAINT CK_logro_juego CHECK (juego IN ('HALO 1', 'HALO 2', 'HALO 3', 'HALO 4', 'REACH', '3ODST', 'C.E'));
ALTER TABLE Logros ADD CONSTRAINT CK_logro_obtencion CHECK (obtencion >= 1 AND obtencion <= 5);
ALTER TABLE ModoJuegos ADD CONSTRAINT CK_modo_nombre CHECK (nombre IN('tiroteo', 'infestacion', 'juggernaut', 'asesino', 'bolaloca', 'captura la bandera', 'rey de la colina'));
ALTER TABLE ModoJuegos ADD CONSTRAINT CK_modo_duracion CHECK (duracion >= 20 AND duracion <= 60);
ALTER TABLE ModoJuegos ADD CONSTRAINT CK_modo_jugador CHECK (jugadores >= 4 AND jugadores <= 18);
ALTER TABLE ModoJuegos ADD CONSTRAINT CK_modo_puntuacion CHECK (puntuacion >= 0 AND puntuacion <= 9000);
ALTER TABLE Usuarios ADD CONSTRAINT CK_usuario_acreditacion CHECK (acreditacion >= 0 AND acreditacion <= 5);
ALTER TABLE Foros ADD CONSTRAINT CK_foro_juego CHECK (juego IN ('HALO 1', 'HALO 2', 'HALO 3', 'HALO 4', 'REACH', '3ODST', 'C.E'));
ALTER TABLE Foros ADD CONSTRAINT CK_foro_calificacion CHECK (calificacion > 0 and calificacion < 10000000);
ALTER TABLE Solicitudes ADD CONSTRAINT CK_solicitud_bool CHECK (estado IN ('A', 'R','E'));

/*PRIMARIAS*/
ALTER TABLE Campañas ADD CONSTRAINT PK_campañas PRIMARY KEY(idCampaña);
ALTER TABLE Calaveras ADD CONSTRAINT PK_calaveras PRIMARY KEY(idCalavera);
ALTER TABLE Mapas ADD CONSTRAINT PK_mapas PRIMARY KEY(nombre);
ALTER TABLE PersonajesporMapas ADD CONSTRAINT PK_personajespormapas PRIMARY KEY(nombrePersonaje,nombreMapa);
ALTER TABLE Personajes ADD CONSTRAINT PK_personajes PRIMARY KEY(nombre);
ALTER TABLE Humanos ADD CONSTRAINT PK_humanos PRIMARY KEY(nombreHumano);
ALTER TABLE Floods ADD CONSTRAINT PK_floods PRIMARY KEY(nombreFlood);
ALTER TABLE Covenant ADD CONSTRAINT PK_covenant PRIMARY KEY(nombreCovenant);
ALTER TABLE Potenciadores ADD CONSTRAINT PK_potenciadores PRIMARY KEY(nombrePotenciador);
ALTER TABLE Granadas ADD CONSTRAINT PK_granadas PRIMARY KEY(nombreGranada);
ALTER TABLE Armamentos ADD CONSTRAINT PK_armamentos PRIMARY KEY(nombre);
ALTER TABLE Vehiculos ADD CONSTRAINT PK_vehiculos PRIMARY KEY(nombreVehiculo);
ALTER TABLE Armas ADD CONSTRAINT PK_armas PRIMARY KEY(nombreArma);
ALTER TABLE Municiones ADD CONSTRAINT PK_municiones PRIMARY KEY(idMunicion);
ALTER TABLE Logros ADD CONSTRAINT PK_logros PRIMARY KEY(nombre);
ALTER TABLE ModoJuegos ADD CONSTRAINT PK_modojuegos PRIMARY KEY(idModo);
ALTER TABLE UsuariosporModos ADD CONSTRAINT PK_usuariopormodo PRIMARY KEY(idUsuario,idModo);
ALTER TABLE Usuarios ADD CONSTRAINT PK_usuarios PRIMARY KEY(idUsuario);
ALTER TABLE UsuariosporForos ADD CONSTRAINT PK_usuariosporforos PRIMARY KEY(idUsuario,nombreForo);
ALTER TABLE Foros ADD CONSTRAINT PK_foros PRIMARY KEY(nombre);
ALTER TABLE Solicitudes ADD CONSTRAINT PK_solicitudes PRIMARY KEY(idSolicitud);
ALTER TABLE UsuariosporCampañas ADD CONSTRAINT PK_usuariosporcampañas PRIMARY KEY(idUsuario,idCampaña);

/*UNICAS*/
ALTER TABLE Usuarios ADD CONSTRAINT UK_usuarios UNIQUE (correo,nombreUsuario);

/*FORANEAS*/
ALTER TABLE Calaveras ADD CONSTRAINT FK_calaveras_campañas FOREIGN KEY(idCampaña) REFERENCES Campañas(idCampaña) ON DELETE CASCADE;
ALTER TABLE PersonajesporMapas ADD CONSTRAINT FK_personajespormapas_personajes FOREIGN KEY(nombrePersonaje) REFERENCES Personajes(nombre);
ALTER TABLE PersonajesporMapas ADD CONSTRAINT FK_personajespormapas_mapas FOREIGN KEY(nombreMapa) REFERENCES Mapas(nombre);
ALTER TABLE Personajes ADD CONSTRAINT FK_personajes_campañas FOREIGN KEY(idCampaña) REFERENCES Campañas(idCampaña) ON DELETE CASCADE;
ALTER TABLE Humanos ADD CONSTRAINT FK_humanos_personaje FOREIGN KEY(nombreHumano) REFERENCES Personajes(nombre) ON DELETE CASCADE;
ALTER TABLE Floods ADD CONSTRAINT FK_flood_personaje FOREIGN KEY(nombreFlood) REFERENCES Personajes(nombre) ON DELETE CASCADE;
ALTER TABLE Covenant ADD CONSTRAINT FK_covenant_personaje FOREIGN KEY(nombreCovenant) REFERENCES Personajes(nombre) ON DELETE CASCADE;
ALTER TABLE Armamentos ADD CONSTRAINT FK_armamento_granada FOREIGN KEY(nombreGranada) REFERENCES Granadas(nombreGranada) ON DELETE CASCADE;
ALTER TABLE Armamentos ADD CONSTRAINT FK_armamento_potenciador FOREIGN KEY(nombrePotenciador) REFERENCES Potenciadores(nombrePotenciador) ON DELETE CASCADE;
ALTER TABLE Armamentos ADD CONSTRAINT FK_armamento_personaje FOREIGN KEY(nombrePersonaje) REFERENCES Personajes(nombre) ON DELETE CASCADE;
ALTER TABLE Vehiculos ADD CONSTRAINT FK_vehiculo_armamento FOREIGN KEY(nombreVehiculo) REFERENCES Armamentos(nombre) ON DELETE CASCADE;
ALTER TABLE Armas ADD CONSTRAINT FK_arma_armamento FOREIGN KEY(nombreArma) REFERENCES Armamentos(nombre) ON DELETE CASCADE;
ALTER TABLE Armas ADD CONSTRAINT FK_arma_municion FOREIGN KEY(idMunicion) REFERENCES Municiones(idMunicion) ON DELETE SET NULL;
ALTER TABLE Logros ADD CONSTRAINT FK_logros_usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE CASCADE;
ALTER TABLE UsuariosporModos ADD CONSTRAINT FK_usuariospormodo_usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario);
ALTER TABLE UsuariosporModos ADD CONSTRAINT FK_usuariospormodo_modos FOREIGN KEY(idModo) REFERENCES ModoJuegos(idModo) ON DELETE CASCADE;
ALTER TABLE UsuariosporForos ADD CONSTRAINT FK_usuariosporforos_usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario);
ALTER TABLE UsuariosporForos ADD CONSTRAINT FK_usuariosporforos_foros FOREIGN KEY(nombreForo) REFERENCES Foros(nombre) on delete cascade;
ALTER TABLE Solicitudes ADD CONSTRAINT FK_solicitud_usuario FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE SET NULL;
ALTER TABLE UsuariosporCampañas ADD CONSTRAINT FK_usuariosporcampañas_usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario);
ALTER TABLE UsuariosporCampañas ADD CONSTRAINT FK_usuariosporcampañas_campañas FOREIGN KEY(idCampaña) REFERENCES Campañas(idCampaña);

/*PoblarOK*/
--para la poblacion de datos, el atributo CHECK de juego, se repite en varias tablas por lo cual se puede mostrar la integridad en cada una de forma correcta--
--para campañas se muestra la integridad de la cantidad de jugadores, algunos de los tipos de dificultad y la correcta creacion de las PK
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (1, 'primera campaña', 'HALO 1', 4, 'legendario');
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (2, 'mi nueva aventura', 'HALO 2', 1, 'heroico');
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (3, 'nombres para probar la integridad', 'HALO 3', 3, 'facil');
--para Calaveras, se demustra la integridad de la FK con Campañas, ademas de mostrar la CK de tipoCalavera
insert into Calaveras (idCalavera, nombre, descripcion, tipoCalavera, idCampaña) values (1, 'one shot', 'esta es una calavera que le añade la dificultad a la partida', 'dificultad', 1);
insert into Calaveras (idCalavera, nombre, descripcion, tipoCalavera, idCampaña) values (2, 'disparo festivo', 'esta es una calavera que le añade una experiencia diferente a la partida', 'experiencia', 3);
--para mapas, se confirma la integridad de algunos tipos para el lugar y el bioma
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('sector 903', 'una parte de una ciudad dentro del planeta 903', '3ODST', 'planetario', 'ciudad');
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('tierras balidas', 'mapa desertico donde esta invadido', 'REACH', 'planetario', 'montaña');
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('nave -708', 'infiltracion de las naves enemigas', 'HALO 4', 'espacial', 'espacio');
--para personajes, se demuestra la integridad de la herencia propuesta para humanos, floods y covenant, ademas de los roles que tiene, el grupo y la desaparicion
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('espartan 117', 'H', 'REACH', 'el personaje principal de la historia de HALO', 'principal', 1756, 'T', 1);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('inquisidor', 'C', 'HALO 1', 'el antagonista principal de la saga de HALO', 'antagonista', 723, 'T', 3);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pesar', 'C', 'HALO 2', 'el jefe comandante de el grupo de Covenant', 'antagonista', 1793, 'F', 1);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('Contaminador', 'F', 'C.E', 'el jefe mas poderoso y rey de los FLOODS', 'secundario', 2000, 'F', 2);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('zombie 33', 'F', 'HALO 3', 'un seguidor de los floods', 'NPC', 100, 'F', 3);
--Para humanos, se muestra la relacion PK/FK con la tabla Personajes, ademas de la integridad del rango y las limitaciones de la armadura 
insert into Humanos (nombreHumano, rango, armadura) values ('espartan 117', 'SS', 90);
--para floods, se demustra la integridad de la PK/FK con personajes, ademas de qie tipo de infectado es y si es huesped, no o si es nula
insert into Floods (nombreFlood, tiposInfectados, huesped) values ('Contaminador', 'combate', 'sensible');
insert into Floods (nombreFlood, tiposInfectados, huesped) values ('zombie 33', 'infeccion', null);
--para covenant, se muestra la integridad de las especies de los aliens, el rango de la jerarquia, si es hereje o no y la armadura
insert into Covenant (nombreCovenant, especieAlien, jerarquia, rango, herejes, armadura) values ('inquisidor', 'elite', 1, 'S', 'T', 40);
insert into Covenant (nombreCovenant, especieAlien, jerarquia, rango, herejes, armadura) values ('pesar', 'profeta', 6, 'A', 'F', null);
--para potenciadores, se muestra la integridad de los grupos y el rango de la durabilidad
insert into Potenciadores (nombrePotenciador, descripcion, grupo, durabilidad) values ('escudo reforzado', 'un potenciador que ayuda a reforzar el escudo actual con 100 puntos mas', 'C', 8);
insert into Potenciadores (nombrePotenciador, descripcion, grupo, durabilidad) values ('speedrun', 'el potenciador que ayuda a hacer mas veloz al personaje', 'H', 29);
--para granadas, ayuda a mostrar el rango que tiene en alcance, dano y acumulado
insert into Granadas (nombreGranada, descripcion, alcance, dano, acumulado) values ('plasma', 'esta granada esta creada para pegarse al enemigo y explotar al instante', 0, 98, 3);
insert into Granadas (nombreGranada, descripcion, alcance, dano, acumulado) values ('polvora', 'esta granada es creada por los humanos y es la mas basica', 7, 51, 1);
--para municiones, muestra la integridad de material, calibre y cargador
insert into Municiones (idMunicion, material, calibre, cargador) values (1, 'cristales', 4, 0);
insert into Municiones (idMunicion, material, calibre, cargador) values (2, 'metal', 9, 30);
insert into Municiones (idMunicion, material, calibre, cargador) values (3, 'combustible', 11, 21);
--para armamentos, se muestra la integridad de el grupo, dano, manejo, peso y los tipos de nulidad enn las fk
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('tanque alienigena', 'un tanque fabricado por el Covenant para las guerras', 'HALO 1', 'C', 240, 'facil', 828, 'plasma', null, null);
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('ak-47', 'arma hecha por los humanos que tiene dificultad de punteria pero mucho daño', '3ODST', 'H', 103, 'dificil', 47, null, 'speedrun', 'espartan 117');
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('caza espacial', 'caza de combate para estar en el espacio', 'HALO 3', 'H', 96, 'dificil', 627, null, 'escudo reforzado', null);
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('rifle de plasma', 'arma hecha por los alienigenas que concentra energia y dispara', 'HALO 4', 'C', 183, 'medio', 20, 'polvora', 'speedrun', 'zombie 33');
--para vehiculos, se confirma la relacion de la PK/FK con armamentos, la integridad en asientos, durabilidad, velocidad, altitud y tipovehiculo
insert into Vehiculos (nombreVehiculo, asiento, durabilidad, velocidad, altitud, tipoVehiculo) values ('tanque alienigena', 6, 1255, 50, 'planetario', 'Terrestre');
insert into Vehiculos (nombreVehiculo, asiento, durabilidad, velocidad, altitud, tipoVehiculo) values ('caza espacial', 20, 1795, 140, 'espacio', 'Aereo');
--para armas, se ve la integridad de alcance, capacidad, rareza, tipoArma
insert into Armas (nombreArma, alcance, capacidad, rareza, tipoArma, idMunicion) values ('ak-47', 158, 6, 'L', 'fusil', 1);
insert into Armas (nombreArma, alcance, capacidad, rareza, tipoArma, idMunicion) values ('rifle de plasma', 77, 130, 'C', 'francotirador', 2);
--para usuarios, se muestra la integridad en fechainicio y acreditacion
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (1, 'pruebas@gmail.com', 'Probador 2000', 'no quiero colocar mi descripcion', '20/8/2019', null, 1);
--para logros, se muestra la integridad en juego, obtencion, fecha
insert into Logros (nombre, descripcion, juego, obtencion, fecha, idusuario) values ('2 pajaros de 1 tiro', 'matar a 2 enemigos con una misma bala ', 'HALO 3', 2, '3/5/2022', 1);
-- para modos de juego, se muestra la integridad de duracion, jugadores y puntuacion
insert into ModoJuegos (idModo, nombre, descripcion, duracion, jugadores, puntuacion) values (1, 'infestacion', 'un modo de juego multijugador donde gana el ultimo sobreviviente', 56, 11, 793);
--para foros, se muestra la iintegridad en juego, calificacion
insert into Foros (nombre, tema, juego, fecha, descripcion, calificacion) values ('porque halo es un goty', 'mejores momentos de HALO', 'HALO 1', '26/7/2021', 'en este foro se va a hablar de porque halo es considerado un gran juego en la comunidad gamer y sus mejores momentos', 228874);
--para solicitudes, se muestra la integridad en estado y sus nulidades
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (1, 'me gustaria arreglar en la informacion del personaje espartan 117, porque asi no se escribe el nombre', 'E', '10/12/2017', null, null, 1);
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (2, 'quiero arreglar armamentos porque no me gusta el nombre del tanque', 'R', '10/12/2017', '23/1/2018', 'el nombre del tanque es original de la saga', 1);
--para los inserts de las asociativas, se muestra la integridad de las relaciones entre tablas
insert into UsuariosporForos (idUsuario, nombreForo) values (1, 'porque halo es un goty');
insert into UsuariosporModos (idUsuario, idModo) values (1, 1);
insert into UsuariosporCampañas (idUsuario, idCampaña) values (1, 3);
insert into PersonajesporMapas (nombrePersonaje, nombreMapa) values ('inquisidor', 'nave -708');

/*Poblar NoOK*/
insert into Campañas (nombre, juego, jugadores, dificultad) values (1, 'primera campaña', 'HALO 1', 4, 'legendario');--no esta llamando idCampaña
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (4, 'otra aventura', 'HALO 2', 1, 'superFacil');--el tipo de dificultad no es el adecuado
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (3, 'nombres para no probar', 'HALO 3', 0, 'facil');--el rango de jugadores esta fuera

insert into Calaveras (idCalavera, nombre, descripcion, tipoCalavera, idCampaña) values (1, 'one shot', 'esta es una calavera que le añade la dificultad a la partida', 'aumento', 1);--no cumple la integridad de tipoCalavera
insert into Calaveras (idCalavera, nombre, descripcion, tipoCalavera, idCampaña) values (2, 'disparo festivo', 'esta es una calavera que le añade una experiencia diferente a la partida', 'experiencia', 7);--no existe el id de la campaña 7

insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('sector 903', 'una parte de una ciudad dentro del planeta 903', 'HALO 5', 'planetario', 'ciudad');-- el juego no esta en la restriccion dada
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('tierras balidas', 'mapa desertico donde esta invadido', 'REACH', null, 'montaña');-- el lugar no puede ser nulo
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('nave -708', 'infiltracion de las naves enemigas', 'HALO 4', 'espacial', 'galaxia');-- el bioma no concuerda con la restriccion dada

insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pruebano1', 'H', 'REACH', 'el peso ', 'principal', 1756, 'T', 1);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pruebano2', 'C', 'HALO 1', 'el antago HALO', 'antagonista', 723, 'T', 3);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pesar', 'R', 'HALO 2', 'el jefe comandante de el grupo de Covenant', 'antagonista', 1793, 'F', 1);-- el grupo esta mal especificado
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pesado', 'C', 'HALO 2', 'el jefe comandante de el grupo de Covenant', 'primer ministro', 1793, 'F', 1);-- el rol no esta bien identificado
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pesadito', 'C', 'HALO 2', 'el jefe comandante de el grupo de Covenant', 'antagonista', null, null, 1);-- ni vida ni desaparecidos pueden ser nulas
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('pruebano3', 'F', 'C.E', 'el jefe mas poderosito', 'secundario', 2000, 'F', 2);

insert into Humanos (nombreHumano, rango, armadura) values ('pruebano1', null, 90);-- el rango no puede ser nulo
insert into Humanos (nombreHumano, rango, armadura) values ('pruebano1', 'SS', 101);-- la armadura excede el rango 

insert into Floods (nombreFlood, tiposInfectados, huesped) values ('pruebano3', 'combatiente', 'sensible');-- el tipo de infectado esta mal insertado
insert into Floods (nombreFlood, tiposInfectados, huesped) values ('pruebano3', 'combate', 'para nada es un enemigo que es muy sensible');-- el huesped esta mal especificado y sale del rango

insert into Covenant (nombreCovenant, especieAlien, jerarquia, rango, herejes, armadura) values ('pruebano2', 'elite', 10, 'S', 'T', 40);--la jerarquia se sale del rango estimado
insert into Covenant (nombreCovenant, especieAlien, jerarquia, rango, herejes, armadura) values ('pruebano2', 'elite', 4, 'S', 'N/A', 40);-- se incumple la restriccion de herejes
insert into Covenant (nombreCovenant, especieAlien, jerarquia, rango, herejes, armadura) values ('pruebano4', 'elite', 1, 'S', 'T', 40);-- el nombre de la pk/fk no esta en personajes

insert into Potenciadores (nombrePotenciador, descripcion, grupo, durabilidad) values ('escudo reforzado', 'un potenciador que ayuda a reforzar el escudo actual con 100 puntos mas', null, 8);--el grupo no puede ser nulo
insert into Potenciadores (nombrePotenciador, descripcion, grupo, durabilidad) values ('speedrun', 'el potenciador que ayuda a hacer mas veloz al personaje', 'H', -7);--el rango de la durabilidad esta fuera de los limites

insert into Granadas (nombreGranada, descripcion, alcance, dano, acumulado) values ('plasma', 'esta granada esta creada para pegarse al enemigo y explotar al instante', -33, 98, 3);-- el alcance no puede ser negativo
insert into Granadas (nombreGranada, descripcion, alcance, dano, acumulado) values ('polvora', 'esta granada es creada por los humanos y es la mas basica', 7, 500, 1);-- el dano se sale de los limites impuestos
insert into Granadas (nombreGranada, descripcion, alcance, dano, acumulado) values ('polvora', 'esta granada es creada por los humanos y es la mas basica', 7, 51, null);-- no puede ser nulo el acumulado

insert into Municiones (idMunicion, material, calibre, cargador) values (1, 'mini cristal', 4, 0);-- la restriccion del material no es la correcta
insert into Municiones (idMunicion, material, calibre, cargador) values (2, 'metal', null, 35);-- el calibre no puede ser nulo, ademas el cargador se sale del limite

insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('arma1', 'un tanque fabricado por rras', 'HALO 1', 'C', 240, 'facil', 828, 'plasma', null, null);
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('arma2', 'arma hecmucho daño', '3ODST', 'H', 103, 'dificil', 47, null, 'speedrun', 'espartan 117');
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('arma3', 'caza de combate para estar en el espacio', 'HALO 3', 'H', 96, 'dificil', 627, null, 'escudo reforzado', null);
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('arma4', null, 'HALO 4', 'C', 183, 'medio', 20, 'polvoreado', 'este no es un pot', null);--la descripcion no puede ser nula, no existen las id de granadas ni potenciadores     
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('caza espacial', 'arma hecha a energia y dispara', 'HALO 4', 'C', 183, 'medianito', 20, 'polvora', 'speedrun', 'zombie 33');-- la pk ya existe, el manejo no esta bien especificado    

insert into Vehiculos (nombreVehiculo, asiento, durabilidad, velocidad, altitud, tipoVehiculo) values ('arma1', 6, 1255, 50, 'planetario', 'todo terreno');-- la altitud no esta bien especificada
insert into Vehiculos (nombreVehiculo, asiento, durabilidad, velocidad, altitud, tipoVehiculo) values ('arma2', null, null, null, 'espacio', 'Aereo');-- los asientos, durabilidad y velocidad no pueden ser nulas

insert into Armas (nombreArma, alcance, capacidad, rareza, tipoArma, idMunicion) values ('arma3', 158, 6, 'H', 'ub arma de fuego', 1);-- el tipoArma no esta bien especificado, al igual que la rareza

insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (1, 'pruebas@gmail.com', 'Probador 2000', 'no quiero colocar mi descripcion', '20/8/2019', null, 8000);-- la acreditacion esta fuera de rango

insert into Logros (nombre, descripcion, juego, obtencion, fecha, idusuario) values ('ojo por ojo...', 'matar a 2 enemigos con una misma bala ', 'C:E.O', 2, '3/5/2022', -1);-- el id del usuario no existe, el juego esta mal especificado

insert into ModoJuegos (idModo, nombre, descripcion, duracion, jugadores, puntuacion) values (1, 'infestacion', 'un modo de juego multijugador donde gana el ultimo sobreviviente', -44, 36, null);--duracion, jugadores estan fuera del rango, puntuacion no puede ser nula

insert into Foros (nombre, tema, juego, fecha, descripcion, calificacion) values (null, 'mejores momentos de HALO', 'HALO 1', '26/7/2021', 'en este foro se va a hablar de porque halo es considerado un gran juego en la comunidad gamer y sus mejores momentos', 228874);-- el nombre no puede ser nulo

insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (1, null, 'E', '10/12/2017', null, null, 1);-- la descripcion no puede ser nula
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (2, 'quiero arreglar armamentos porque no me gusta el nombre del tanque', 'null', '10/12/2017', '23/1/2018', 'el nombre del tanque es original de la saga', 1);-- el estado esta mal especificado

/*X POBLAR*/
DELETE FROM Campañas;
DELETE FROM Calaveras;
DELETE FROM Mapas;
DELETE FROM PersonajesporMapas;
DELETE FROM Personajes;
DELETE FROM Humanos;
DELETE FROM Floods;
DELETE FROM Covenant;
DELETE FROM Potenciadores;
DELETE FROM Granadas;
DELETE FROM Armamentos;
DELETE FROM Vehiculos;
DELETE FROM Armas;
DELETE FROM Municiones;
DELETE FROM Logros;
DELETE FROM Modojuegos;
DELETE FROM UsuariosporModos;
DELETE FROM Usuarios;
DELETE FROM UsuariosporForos;
DELETE FROM Foros;
DELETE FROM Solicitudes;
DELETE FROM UsuariosporCampañas;

/*X FORANEAS*/
ALTER TABLE Calaveras DROP CONSTRAINT FK_calaveras_campañas;
ALTER TABLE PersonajesporMapas DROP CONSTRAINT FK_personajespormapas_personajes;
ALTER TABLE PersonajesporMapas DROP CONSTRAINT FK_personajespormapas_mapas;
ALTER TABLE Personajes DROP CONSTRAINT FK_personajes_campañas;
ALTER TABLE Humanos DROP CONSTRAINT FK_humanos_personaje;
ALTER TABLE Floods DROP CONSTRAINT FK_flood_personaje;
ALTER TABLE Covenant DROP CONSTRAINT FK_covenant_personaje;
ALTER TABLE Armamentos DROP CONSTRAINT FK_armamento_granada;
ALTER TABLE Armamentos DROP CONSTRAINT FK_armamento_potenciador;
ALTER TABLE Armamentos DROP CONSTRAINT FK_armamento_personaje;
ALTER TABLE Vehiculos DROP CONSTRAINT FK_vehiculo_armamento;
ALTER TABLE Armas DROP CONSTRAINT FK_arma_armamento;
ALTER TABLE Armas DROP CONSTRAINT FK_arma_municion;
ALTER TABLE Logros DROP CONSTRAINT FK_logros_usuarios;
ALTER TABLE UsuariosporModos DROP CONSTRAINT FK_usuariospormodo_usuarios;
ALTER TABLE UsuariosporModos DROP CONSTRAINT FK_usuariospormodo_modos;
ALTER TABLE UsuariosporForos DROP CONSTRAINT FK_usuariosporforos_usuarios;
ALTER TABLE UsuariosporForos DROP CONSTRAINT FK_usuariosporforos_foros;
ALTER TABLE Solicitudes DROP CONSTRAINT FK_solicitud_usuario;
ALTER TABLE UsuariosporCampañas DROP CONSTRAINT FK_usuariosporcampañas_usuarios;
ALTER TABLE UsuariosporCampañas DROP CONSTRAINT FK_usuariosporcampañas_campañas;

/*X TABLAS*/
DROP TABLE Campañas;
DROP TABLE Calaveras;
DROP TABLE Mapas;
DROP TABLE PersonajesporMapas;
DROP TABLE Personajes;
DROP TABLE Humanos;
DROP TABLE Floods;
DROP TABLE Covenant;
DROP TABLE Potenciadores;
DROP TABLE Granadas;
DROP TABLE Armamentos;
DROP TABLE Vehiculos;
DROP TABLE Armas;
DROP TABLE Municiones;
DROP TABLE Logros;
DROP TABLE UsuariosporModos;
DROP TABLE Usuarios;
DROP TABLE UsuariosporForos;
DROP TABLE Foros;
DROP TABLE Solicitudes;
DROP TABLE UsuariosporCampañas;
DROP TABLE Modojuegos;
