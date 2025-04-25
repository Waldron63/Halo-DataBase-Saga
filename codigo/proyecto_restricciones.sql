--restricciones del proyecto--
/*Campañas*/
--El idCampaña debe ser autogenerado--
CREATE OR REPLACE TRIGGER TR_campañas_id
BEFORE INSERT ON Campañas
FOR EACH ROW
DECLARE
    valor NUMBER(9);
BEGIN
    BEGIN
        SELECT COUNT(*) INTO valor
        FROM Campañas;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    valor := valor + 1;
    :NEW.idCampaña := TO_CHAR(valor);
end TR_campañas_id;
/
--Los usuarios no pueden tener mas de dos campañas con el mismo nombre--
CREATE OR REPLACE TRIGGER TR_campañas_repetidos
BEFORE INSERT ON Campañas
FOR EACH ROW
DECLARE
    valor NUMBER(1);
BEGIN
    BEGIN
        SELECT COUNT(nombre) INTO valor
        FROM Campañas
        WHERE nombre = :NEW.nombre;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    IF valor > 1 THEN
        RAISE_APPLICATION_ERROR(-20010, 'nonmbre de la campaña actualmente usado.');
    END IF;
end TR_campañas_repetidos;
/
--No se puede modificar el juego y la dificultad--
CREATE OR REPLACE TRIGGER TR_campañas_juego_dificultad
BEFORE UPDATE ON Campañas
FOR EACH ROW
BEGIN
    if :new.juego != :old.juego or :new.dificultad != :old.dificultad then
        RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el juego y la dificultad en las campañas');
    end if;
end TR_campañas_juego_dificultad;
/

/*Calaveras*/
--El id de calaveras es autogenerada--
CREATE OR REPLACE TRIGGER TR_calaveras_id
BEFORE INSERT ON Calaveras
FOR EACH ROW
DECLARE
    valor NUMBER(9);
BEGIN
    BEGIN
        SELECT COUNT(*) INTO valor
        FROM Calaveras;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    valor := valor + 1;
    :NEW.idCalavera := TO_CHAR(valor);
end TR_calaveras_id;
/
--no puede haber mas de una calavera que tengan el mismo nombre en una campaña--
CREATE OR REPLACE TRIGGER TR_calaveras_repetidas
BEFORE INSERT ON Calaveras
FOR EACH ROW
DECLARE
    valor NUMBER(1);
BEGIN
    BEGIN
        SELECT COUNT(nombre) INTO valor
        FROM Calaveras
        WHERE nombre = :NEW.nombre;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    IF valor > 1 THEN
        RAISE_APPLICATION_ERROR(-20010, 'nonmbre de la calavera actualmente usado.');
    END IF;
end TR_calaveras_repetidos;
/
--no se puede modificar el tipo--
CREATE OR REPLACE TRIGGER TR_calaveras_dificultad
BEFORE UPDATE ON Calaveras
FOR EACH ROW
BEGIN
    if :old.tipocalavera != :new.tipocalavera then
        RAISE_APPLICATION_ERROR(-20004, 'No se puede modificar el tipo en calaveras');
    end if;
end TR_calaveras_dificultad;
/

/*Mapas*/
-- el lugar debe concordar con el bioma--
CREATE OR REPLACE TRIGGER TR_mapa_bioma
BEFORE INSERT OR UPDATE ON Mapas
FOR EACH ROW
BEGIN
    IF :NEW.lugar = 'espacial' OR :NEW.lugar = 'nave' THEN
        :NEW.bioma := 'espacio';
    ELSIF :NEW.lugar = 'planetario' THEN
        IF :NEW.bioma = 'espacio' THEN
            RAISE_APPLICATION_ERROR(-20001,'El bioma no concuerda con el lugar dado');
        END IF;
    END IF;
END TR_mapa_bioma;
/
/*Personajes*/
---la vida depende del rol--
CREATE OR REPLACE TRIGGER TR_personajes_vida
BEFORE INSERT OR UPDATE ON Personajes
FOR EACH ROW
BEGIN
    IF :NEW.rol = 'principal' THEN
        :NEW.vida := 500;
    ELSIF :NEW.rol = 'Secundario' THEN
        :NEW.vida := 250;
    ELSIF :NEW.rol = 'NPC' THEN
        :NEW.vida := 100;
    ELSIF :NEW.rol = 'antagonista' THEN
        :NEW.vida := 400;
    end if;
end TR_personajes_vida;
/
--cambiar el grupo dependiendo en que tabla se inserta---
CREATE OR REPLACE TRIGGER TR_Personajes_cov
BEFORE INSERT ON Covenant
FOR EACH ROW
BEGIN
    UPDATE Personajes
    SET grupo = 'C'
    WHERE Personajes.nombre = :NEW.nombreCovenant;
end TR_Personajes_cov;
/
CREATE OR REPLACE TRIGGER TR_Personajes_hum
BEFORE INSERT ON Humanos
FOR EACH ROW
BEGIN
    UPDATE Personajes
    SET grupo = 'H'
    WHERE Personajes.nombre = :NEW.nombreHumano;
end TR_Personajes_hum;
/
CREATE OR REPLACE TRIGGER TR_Personajes_fld
BEFORE INSERT ON Floods
FOR EACH ROW
BEGIN
    UPDATE Personajes
    SET grupo = 'F'
    WHERE Personajes.nombre = :NEW.nombreFlood;
end TR_Personajes_fld;
/


/*Humanos*/
--la armadura depende del rango del humano--
CREATE OR REPLACE TRIGGER TR_humanos_armadura
BEFORE INSERT OR UPDATE ON Humanos
FOR EACH ROW
BEGIN
    IF :NEW.rango = 'A' THEN
        :NEW.armadura := 70;
    ELSIF :NEW.rango = 'B' THEN
        :NEW.armadura := 60;
    ELSIF :NEW.rango = 'C' THEN
        :NEW.armadura := 50;
    ELSIF :NEW.rango = 'D' THEN
        :NEW.armadura := 40;
    ELSIF :NEW.rango = 'S' THEN
        :NEW.armadura := 90;
    ELSIF :NEW.rango = 'SS' THEN
        :NEW.armadura := 100;
    end if;
END TR_humanos_armadura;    
/

/*Floods*/
--El tipo de huesped depende del tipo de infectado--
CREATE OR REPLACE TRIGGER TR_floods_huesped
BEFORE INSERT ON Floods
FOR EACH ROW
BEGIN
    IF :NEW.tiposInfectados = 'combate' THEN
        :NEW.huesped := 'sensible';
    ELSIF :NEW.tiposInfectados = 'elite' THEN
        :NEW.huesped := 'sensible';
    ELSIF :NEW.tiposInfectados = 'humano' THEN
        :NEW.huesped := 'sensible';
    ELSIF :NEW.tiposInfectados = 'portadora' THEN
        :NEW.huesped := 'no sensible';
    ELSIF :NEW.tiposInfectados = 'infeccion' THEN
        :NEW.huesped := null;
    ELSIF :NEW.tiposInfectados = 'gravemind' THEN
        :NEW.huesped := null;
    ELSIF :NEW.tiposInfectados = 'pura' THEN
        :NEW.huesped := null;
    ELSIF :NEW.tiposInfectados = 'desconocida' THEN
        :NEW.huesped := null;   
    end if;
END TR_floods_huesped;    
/
--no se puede cambiar los tipos de infectados--
CREATE OR REPLACE TRIGGER TR_flood_tipo_mo
BEFORE UPDATE ON Floods
FOR EACH ROW
BEGIN
    IF :NEW.tiposInfectados != :OLD.tiposInfectados THEN
        RAISE_APPLICATION_ERROR(-20012, 'no se le puede cambiar el tipo a los floods');
    END IF;
end TR_flood_tipo_mo;
/

/*Covenant*/
--la jerarquia, rango, herejes y armadura dependen de especie Alien--
CREATE OR REPLACE TRIGGER TR_covenant_especiealien
BEFORE INSERT ON Covenant
FOR EACH ROW
DECLARE
    cons VARCHAR(10);
BEGIN
    IF :NEW.especieAlien = 'profeta' THEN
        :NEW.jerarquia := 6;
        :NEW.rango := 'SS';
        :NEw.herejes := 'F';
        :NEW.armadura := null;
    ELSIF :NEW.especieAlien = 'brute' THEN
        :NEW.jerarquia := 5;
        :NEW.rango := 'S';
        :NEw.herejes := 'F';
        :NEW.armadura := 100;
    ELSIF :NEW.especieAlien = 'elite' THEN
        :NEW.jerarquia := 5;
        :NEW.rango := 'S';
        :NEw.herejes := 'T';
        :NEW.armadura := 100;
    ELSIF :NEW.especieAlien = 'hunter' THEN
        :NEW.jerarquia := 4;
        :NEW.rango := 'A';
        :NEw.herejes := 'F';
        :NEW.armadura := 100;
    ELSIF :NEW.especieAlien = 'jackal' THEN
        :NEW.jerarquia := 3;
        :NEW.rango := 'B';
        :NEw.herejes := 'F';
        :NEW.armadura := 50;
    ELSIF :NEW.especieAlien = 'grunt' THEN
        :NEW.jerarquia := 3;
        :NEW.rango := 'C';
        :NEw.herejes := 'F';
        :NEW.armadura := null;
    ELSIF :NEW.especieAlien = 'drone' THEN
        :NEW.jerarquia := 2;
        :NEW.rango := 'B';
        :NEw.herejes := 'F';
        :NEW.armadura := null;
    ELSIF :NEW.especieAlien = 'ingeniero' THEN
        :NEW.jerarquia := 1;
        :NEW.rango := 'D';
        :NEw.herejes := 'T';
        :NEW.armadura := 100;
    END IF;
END TR_covenant_especiealien;
/
--no se puede cambiar la especie del alien--
CREATE OR REPLACE TRIGGER TR_covenant_especie_mo
BEFORE UPDATE ON Covenant
FOR EACH ROW
BEGIN
    IF :NEW.especieAlien != :OLD.especieAlien THEN
        RAISE_APPLICATION_ERROR(-20011, 'no se le puede cambiar la especie a los aliens');
    END IF;
end TR_covenant_especie_mo;
/

/*Armamentos*/
--el manejo y peso del arma dependen del daño--
CREATE OR REPLACE TRIGGER TR_armamentos_daño
BEFORE INSERT ON Armamentos
FOR EACH ROW
BEGIN
    IF :new.dano >= 50 and :new.dano <= 100 then
        :new.manejo := 'facil';
        :new.peso := 500;
    ELSIF :new.dano > 100 and :new.dano <= 200 then
        :new.manejo := 'medio';
        :new.peso := 500;
    ELSIF :new.dano > 200 and :new.dano <= 300 then
        :new.manejo := 'dificil';
        :new.peso := 800;
    end if;
end TR_armamentos_daño;
/

/*Vehiculos*/
--la altitud depende del tipo de vehiculo--
CREATE OR REPLACE TRIGGER TR_vehiculos_altitud
BEFORE INSERT ON Vehiculos
FOR EACH ROW
BEGIN
    IF :new.tipoVehiculo = 'terrestre' then
        :new.altitud := null;
    elsif :new.tipoVehiculo = 'aereo' then
        if :new.altitud = null then
            :new.altitud := 'planetario';
        end if;
    end if;
end TR_vehiculos_altitud;
/

/*Armas*/
--el alcance, la capacidad y la rareza dependen del tipo de arma----
CREATE OR REPLACE TRIGGER TR_armas_tipoarma
BEFORE INSERT ON Armas
FOR EACH ROW
BEGIN
    if :new.tipoArma = 'fusil' then
        :new.alcance := 100;
        :new.capacidad := 30; 
        :new.rareza := 'C';
    elsif :new.tipoArma = 'escopeta' then
        :new.alcance := 10;
        :new.capacidad := 8;
        :new.rareza := 'E';
    elsif :new.tipoArma = 'francotirador' then
        :new.alcance := 200;
        :new.capacidad := 8;
        :new.rareza := 'E';
    elsif :new.tipoArma = 'explosivo' then
        :new.alcance := 200;
        :new.capacidad := 2;
        :new.rareza := 'E';
    elsif :new.tipoArma = 'cuerpo' then
        :new.alcance := 0;
        :new.capacidad := 20;
        :new.rareza := 'L';
    end if;
end TR_armas_tipoarma;
/
--si el alcance es 0 el idmunicion debe ser nula--
CREATE OR REPLACE TRIGGER TR_armas_municion
BEFORE INSERT OR UPDATE ON Armas
FOR EACH ROW
BEGIN
    if :new.alcance = 0 THEN
        :new.idMunicion := null;
    end if;
end TR_armas_municion;
/

/*Municiones*/
--el id es autogenerado--
CREATE OR REPLACE TRIGGER TR_municiones_id
BEFORE INSERT ON Municiones
FOR EACH ROW
DECLARE
    valor NUMBER(9);
BEGIN
    BEGIN
        SELECT COUNT(*) INTO valor
        FROM Municiones;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    valor := valor + 1;
    :NEW.idMunicion := TO_CHAR(valor);
end TR_municiones_id;
/

/*Logros*/
-- las fechas de los logros son la fecha actual--
CREATE OR REPLACE TRIGGER TR_logros_fecha
BEFORE INSERT ON Logros
FOR EACH ROW
BEGIN
    :new.fecha := SYSDATE;
end TR_logros_fecha;
/

/*ModoJuegos*/
--el idmodo es autogenerado--
CREATE OR REPLACE TRIGGER TR_modojuegos_id
BEFORE INSERT ON ModoJuegos
FOR EACH ROW
DECLARE
    valor NUMBER(9);
BEGIN
    BEGIN
        SELECT COUNT(*) INTO valor
        FROM ModoJuegos;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    valor := valor + 1;
    :NEW.idModo := TO_CHAR(valor);
end TR_modojuegos_id;
/
--la duracion y el numero de jugadores dependen del nombre--
CREATE OR REPLACE TRIGGER TR_modojuegos_nombre
BEFORE INSERT ON ModoJuegos
FOR EACH ROW
BEGIN
    if :new.nombre = 'tiroteo' then
        :new.jugadores := 4;
        :new.duracion := 30;
    elsif :new.nombre = 'infestacion' then
        :new.jugadores := 8;
        :new.duracion := 50;
    elsif :new.nombre = 'juggernaut' then
        :new.jugadores := 8;
        :new.duracion := 30;
    elsif :new.nombre = 'asesino' then
        :new.jugadores := 10;
        :new.duracion := 40;
    elsif :new.nombre = 'bolaloca' then
        :new.jugadores := 8;
        :new.duracion := 30;
    elsif :new.nombre = 'captura la bandera' then
        :new.jugadores := 8;
        :new.duracion := 20;
    elsif :new.nombre = 'rey de la colina' then
        :new.jugadores := 10;
        :new.duracion := 20;
    end if;
end TR_modojuegos_nombre;
/

/*USUARIOS*/
--id de usuarios debe ser autogenerado--
CREATE OR REPLACE TRIGGER TR_usuarios_id
BEFORE INSERT ON Usuarios
FOR EACH ROW
DECLARE
    valor NUMBER(10);
BEGIN
    BEGIN
        SELECT COUNT(*) INTO valor
        FROM Usuarios;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    valor := valor + 1;
    :NEW.idUsuario := TO_CHAR(valor);
END TR_usuarios_id;
/
--la fechaFin empieza siendo nula y fecha inicio debe ser la fecha en el momento donde se registra un usuario, la acreditacion inicia en 0--
CREATE OR REPLACE TRIGGER TR_usuarios_inicio
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    :NEW.fechaInicio := SYSDATE;
    :NEW.fechaFin := NULL;
    :NEW.acreditacion := 0;
END TR_usuarios_inicio;
/
--fecha fin debe ser la fecha donde el usuario decide borrar la cuenta--
CREATE OR REPLACE TRIGGER TR_usuarios_fecha
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    :NEW.fechaFin := SYSDATE;
END TR_usuarios_fecha;
/
--solo se puede eliminar los usuarios que tengan fechaFin--
CREATE OR REPLACE TRIGGER TR_usuarios_el
BEFORE DELETE ON Usuarios
FOR EACH ROW
BEGIN
    if :old.Fechafin is null THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pueden eliminar usuarios de la base de datos.');
    END IF;
END TR_usuarios_fecha;
/
/*SOLICITUDES*/
--id autogenerado--
CREATE OR REPLACE TRIGGER TR_solicitudes_id
BEFORE INSERT ON Solicitudes
FOR EACH ROW
DECLARE
    valor NUMBER(10);
BEGIN
    BEGIN
        SELECT COUNT(*) INTO valor
        FROM Solicitudes;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            valor := 0;
    END;
    valor := valor + 1;
    :NEW.idSolicitud := TO_CHAR(valor);
END TR_solicitudes_id;
/
--el estado inicia en '(E)n proceso', la justificacion y fechaFinalizacion empiezan en NULL y fecha creacion es fecha actual--
CREATE OR REPLACE TRIGGER TR_solicitudes_estado
BEFORE INSERT ON Solicitudes
FOR EACH ROW
BEGIN
    :NEW.fechaCreacion := SYSDATE;
    :NEW.estado := 'E';
    :NEW.justificacion := NULL;
    :NEW.fechaFinalizacion := NULL;
END TR_solicitudes_estado;
/
--la justificacion debe ser aceptada o rechazada si hay una justificacion--
CREATE OR REPLACE TRIGGER TR_solicitudes_justificacion
BEFORE UPDATE ON Solicitudes
FOR EACH ROW
BEGIN
    IF :NEW.justificacion IS NOT NULL AND :NEW.estado = 'E' THEN
        RAISE_APPLICATION_ERROR(-20002, 'el estado no puede estar en proceso, debe ser aceptado o rechazado.');
    END IF;
    :new.fechaFinalizacion := SYSDATE;
END TR_solicitudes_justificacion;
/
--Las solicitudes se pueden eliminar solo si tienen fecha de finalizacion y el estado es rechazado--
CREATE OR REPLACE TRIGGER TR_solicitudes_el
BEFORE DELETE ON Solicitudes
FOR EACH ROW
BEGIN
    IF :OLD.fechaFinalizacion IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003,'No se puede eliminar una solicitud que no tiene respuesta');
    ELSIF :OLD.estado != 'R' THEN
        RAISE_APPLICATION_ERROR(-20004,'No se puede eliminar una que no halla sido rechazada'); 
    END IF;
END TR_solititudes_el;
/

/*FORO*/
--fecha debe ser fecha actual--
CREATE OR REPLACE TRIGGER TR_foros_fecha
BEFORE INSERT ON Foros
FOR EACH ROW
BEGIN
    :NEW.fecha := SYSDATE;
END TR_foros_fecha;
/


---------------Tuplas---------------------
/*Usuarios*/
--el correo de usuarios debe tener %@%.%--
ALTER TABLE Usuarios ADD CONSTRAINT ck_usuario_correo CHECK (correo LIKE '%@%.%');
--fechafin debe ser mayor o igual a fecha inicio--
ALTER TABLE Usuarios ADD CONSTRAINT ck_usuario_fecha CHECK (fechaFin >= fechaInicio);
/*Solicitudes*/
--fechafinalizacion mayor a fechacreacion--
ALTER TABLE Solicitudes ADD CONSTRAINT CK_solicitud_fecha CHECK (fechaCreacion <= fechaFinalizacion);

/*Triggers Ok*/
--con estas 3 inserciones en Usuarios, se demuestra el id autogenerado; junto con fechainicio, fechafin y acreditacion.
--TR_usuarios_id, TR_usuarios_inicio
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (400, 'correoPruebas1@gmail.com', 'laura Rodriguez', '', '4/7/2018', '22/1/2023', 5);
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (671, 'correoPruebas2@gmail.com', 'Jose Matador', '', '18/9/2018', '3/12/2021', 2);
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (622, 'correoPruebas3@gmail.com', 'Carlos Campo', '', '25/7/2017', '25/4/2022', 1);
-- En estas lineas se muestra como se actualiza la acreditacion y la fechaFin de un Usuario, luego se elimina por tener fechaFin
--TR_usuarios_fecha
UPDATE Usuarios SET acreditacion = 1 WHERE nombreUsuario = 'Jose Matador';
--TR_usuarios_el
DELETE FROM Usuarios WHERE nombreUsuario = 'Jose Matador';
--con estos 3 inserciones en Solicitudes, se demuestra el id autogenerado; ademas de la fechaCreacion, fechaFinalizacion, Juestificacion, estado
--TR_solicitudes_id, TR_solicitudes_estado
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (559, 'descripcion de solicitud 1', 'A', '22/10/2019', null, 'juestificacion 1', 1);
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (665, 'descripcion de solicitud 2', 'R', '16/12/2018', '19/1/2023', null, 1);
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (342, 'descripcion de solicitud 3', 'E', '9/3/2017', '26/11/2021', 'juestificacion 2', 1);
--En esta linea se demuestra como se actualiza la solicitud correctamente
--TR_solicitudes_justificacion
UPDATE Solicitudes SET estado = 'R', justificacion = 'su solicitud ha sido rechazada'
WHERE descripcion = 'descripcion de solicitud 1';
--En esta linea se demuestra como se elimina una solicitud rechazada
--TR_solicitudes_el
DELETE FROM Solicitudes WHERE descripcion = 'descripcion de solicitud 1';
--El id de campaña se autogenera
--TR_campañas_id
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (1, 'campaña de prueba 1', '3ODST', 2, 'legendario');
--El id de calaveras se autogenera
--TR_calaveras_id
insert into Calaveras (idCalavera, nombre, descripcion, tipoCalavera, idCampaña) values (527, 'exterminio', 'descripcion de calavera 1', 'experiencia', 1);
--el lugar debe concordar con el bioma en mapas
--TR_mapa_bioma
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('destierro', 'descripcion de mapa 1', 'C.E', 'planetario', 'desierto');
--en las siguientes inserciones se muestra la integridad para los atributos de personajes, ademas de el cambio de tipo cuando se inserta en alguna de las facciones
--TR_personajes_vida, TR_personajes_cov, TR_personajes_hum, TR_personajes_fld, TR_covenant_especieAlien, TR_humanos_armadura, TR_floods_huesped
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('Jefe Maestro', 'H', 'HALO 2', 'descripcion de personaje 1', 'antagonista', 1756, 'T', 645);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('el martillo', 'C', 'HALO 1', 'descripcion de personaje 2', 'principal', 723, 'F', 965);
insert into Personajes (nombre, grupo, juego, descripcion, rol, vida, desaparecidos, idCampaña) values ('bomba movil', 'F', 'REACH', 'descripcion de personaje 3', 'NPC', 955, 'F', 999);
insert into Covenant (nombreCovenant, especieAlien, jerarquia, rango, herejes, armadura) values ('el martillo', 'brute', 6, 'SS', 'F', 81);
insert into Humanos (nombreHumano, rango, armadura) values ('Jefe Maestro', 'A', 50);
insert into Floods (nombreFlood, tiposInfectados, huesped) values ('bomba movil', 'portadora', 'sensible');
--para estas inserciones, se demuestra la implementacion de los atributos de armamentos, vehiculos y armas.
--TR_armamentos_daño, TR_armas_tipoarma, TR_armas_municion, TR_vehiculos_altitud
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('carro blindado', 'descripcion de vehiculo 1', 'HALO 4', 'H', 88, 'facil', 86, null, null, null);
insert into Armamentos (nombre, definicion, juego, grupo, dano, manejo, peso, nombreGranada, nombrePotenciador, nombrePersonaje) values ('espada', 'descripcion de arma 1', 'HALO 3', 'F', 142, 'facil', 872, null, null, null);
insert into Vehiculos (nombreVehiculo, asiento, durabilidad, velocidad, altitud, tipoVehiculo) values ('carro blindado', 12, 510, 166, 'planetario', 'Terrestre');
insert into Armas (nombreArma, alcance, capacidad, rareza, tipoArma, idMunicion) values ('espada', 110, 207, 'L', 'cuerpo', 1);
--el id de municiones es autogenerado
--TR_municiones_id
insert into Municiones (idMunicion, material, calibre, cargador) values (1, 'cristales', 6, 7);
--la fecha en logros es autogenerada
--TR_logros_fecha
insert into Logros (nombre, descripcion, juego, obtencion, fecha, idusuario) values ('donde hay 1 hay 2', 'descripcion de logro 1', '3ODST', 4, '6/10/2023', 1);
--la siguiente insercion autogenera los atributos de modo de Juegos
--TR_modoJuegos_id, TR_modoJuegos_nombre
insert into ModoJuegos (idModo, nombre, descripcion, duracion, jugadores, puntuacion) values (99, 'rey de la colina', 'descripcion de el modo de juego 1', 45, 7, 5241);
--TR_foros_fecha
insert into Foros (nombre, tema, juego, fecha, descripcion, calificacion) values ('foro de prueba 1', 'tema del foro de prueba', 'HALO 1', '14/7/2020', 'descripcion del nuevo foro 1', 45463);

/*triggers NoOk*/
--no pueden haber 2 campañas con el mismo nombre
--TR_campañas_repetidos
insert into Campañas (idCampaña, nombre, juego, jugadores, dificultad) values (1, 'campaña de prueba 1', 'HALO 1', 2, 'legendario');
--No se puede modificar el juego y la dificultad
--TR_campañas_juego_dificultad
UPDATE Campañas SET dificultad = 'heroico' WHERE nombre = 'campaña de prueba 1';
--no puede haber mas de una calavera que tengan el mismo nombre
--TR_calaveras_repetidas
insert into Calaveras (idCalavera, nombre, descripcion, tipoCalavera, idCampaña) values (527, 'exterminio', 'descripcion de calavera 2', 'experiencia', 1);
--no se puede modificar el tipo
--TR_calaveras_dificultad
UPDATE Calaveras SET tipoCalavera = 'dificultad' WHERE nombre = 'exterminio';
-- el lugar debe concordar con el bioma en mapas
--TR_mapa_bioma
insert into Mapas (nombre, descripcion, juego, lugar, bioma) values ('gran valle', 'descripcion mapa 5', 'REACH', 'planetario', 'espacio');
--no se puede cambiar los tipos de infectados
--TR_flood_tipo_mo
UPDATE Floods SET tiposInfectados = 'gravemind' WHERE nombreFlood = 'bomba movil';
--no se puede cambiar la especie del alien
--TR_covenant_especie_mo
UPDATE Covenant SET especieAlien = 'ingeniero' WHERE nombreCovenant = 'el martillo';
--solo se puede eliminar los usuarios que tengan fechaFin
--TR_usuarios_el
DELETE FROM Usuarios WHERE nombreUsuario = 'laura Rodriguez';
--la justificacion debe ser aceptada o rechazada si hay una justificacion
--TR_solicitudes_justificacion
UPDATE Solicitudes SET estado = 'R'
WHERE descripcion = 'descripcion de solicitud 2';
--Las solicitudes se pueden eliminar solo si tienen fecha de finalizacion y el estado es rechazado
--TR_solicitudes_el
DELETE FROM Solicitudes WHERE descripcion = 'descripcion de solicitud 3';

/*Tuplas Ok*/
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (2, 'correoPrueba@hotmail.com', 'Pedro Pascal', 'tampoco quiero hacer una descripcion', '24/3/2017', '7/6/2022', 5);
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (386, 'esta es la descripcion para una solicitud', 'R', '24/2/2018', '21/7/2022', 'No es necesaria esta solicitud', 2);

/*TuplasNoOk*/
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (562, 'correoPrueba*hotmail.com', 'Pedro Pascal', 'descripcion', '24/3/2017', '7/6/2022', 5);-- el correo esta mal especificado    
insert into Usuarios (idusuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (562, 'correoPrueba@hotmail.com', 'Pedro Pascal', 'descripcion', '24/3/2023', '7/6/2020', 5);-- la fechafin es menor a la fecha inicio
insert into Solicitudes (idSolicitud, descripcion, estado, fechaCreacion, fechaFinalizacion, justificacion, idusuario) values (386, 'esta es la descripcion para una solicitud', 'R', '24/2/2022', '21/7/2017', 'No es necesaria esta solicitud', 2);-- la fecha fin es menor a la fecha incio  

/*X TRIGGERS*/
DROP TRIGGER TR_armamentos_daño;
DROP TRIGGER TR_armas_tipoarma;
DROP TRIGGER TR_armas_municion;
DROP TRIGGER TR_calaveras_dificultad;
DROP TRIGGER TR_calaveras_repetidas;
DROP TRIGGER TR_calaveras_id;
DROP TRIGGER TR_mapa_bioma;
DROP TRIGGER TR_campañas_id;
DROP TRIGGER TR_campañas_juego_dificultad;
DROP TRIGGER TR_campañas_repetidos;
DROP TRIGGER TR_covenant_especieAlien;
DROP TRIGGER TR_covenant_especie_mo;
DROP TRIGGER TR_humanos_armadura;
DROP TRIGGER TR_floods_huesped;
DROP TRIGGER TR_flood_tipo_mo;
DROP TRIGGER TR_foros_fecha;
DROP TRIGGER TR_logros_fecha;
DROP TRIGGER TR_modoJuegos_id;
DROP TRIGGER TR_modoJuegos_nombre;
DROP TRIGGER TR_municiones_id;
DROP TRIGGER TR_personajes_vida;
DROP TRIGGER TR_personajes_cov;
DROP TRIGGER TR_personajes_hum;
DROP TRIGGER TR_personajes_fld;
DROP TRIGGER TR_solicitudes_id;
DROP TRIGGER TR_solicitudes_estado;
DROP TRIGGER TR_solicitudes_justificacion;
DROP TRIGGER TR_solicitudes_el;
DROP TRIGGER TR_usuarios_el;
DROP TRIGGER TR_usuarios_fecha;
DROP TRIGGER TR_usuarios_inicio;
DROP TRIGGER TR_usuarios_id;
DROP TRIGGER TR_vehiculos_altitud;