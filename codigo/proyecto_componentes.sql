/*CRUDE*/
--USUARIOS--
CREATE OR REPLACE PACKAGE PC_USUARIOS AS
    --El usuario puede crear un nuevo perfil para la base de datos--
    PROCEDURE registrarse(v_correo VARCHAR2, v_nombreUsuario VARCHAR2, v_descripcion VARCHAR2);
    --los usuarios pueden buscar informacion de los otros usuarios y de ellos mismos--
    FUNCTION vista_perfil(v_nombreUsuario VARCHAR2) RETURN SYS_REFCURSOR;
    --se puede actualizar el nombre del usuario--
    PROCEDURE editar_perfil(nombreUsuario_antiguo VARCHAR2, nombreUsuario_nuevo VARCHAR2, v_correo VARCHAR2, v_descripcion VARCHAR2, v_fechafin DATE);
    --Actualizar la acreditacion del usuario--
    PROCEDURE nueva_acreditacion(v_nombreUsuario VARCHAR2, v_acreditacion NUMBER); 
    --el usuario se puede eliminar si el mismo lo desea--
    PROCEDURE borrar_usuario(v_nombreUsuario VARCHAR2); 
    --se puede crear los datos para el modo de juego--
    PROCEDURE partida_modojuegos(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2, v_descripcion VARCHAR2); 
    --se pueden leer todos los modos de juego existente--
    FUNCTION historial_partidas(v_nombreUsuario VARCHAR2) RETURN SYS_REFCURSOR; 
    --actualizar los modos de juego--
    PROCEDURE actualizar_partida(v_nombreUsuario VARCHAR2, v_nombreAntiguo VARCHAR2,v_nombreNuevo VARCHAR2, v_descripcion VARCHAR2); 
    --eliminar los modos de juego--
    PROCEDURE eliminar_historial(v_nombreUsuario VARCHAR2,v_nombreModo VARCHAR2); 
    --se crean nuevos foros para los usuarios y sus conversaciones--
    PROCEDURE generar_nuevo_foro(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2, v_tema VARCHAR2, v_juego VARCHAR2, v_descripcion VARCHAR2);
    --buscar los foros de un usuario--
    FUNCTION buscar_foro(v_nombreUsuario VARCHAR2) RETURN SYS_REFCURSOR; 
    --actualizar los foros por su nombre--
    PROCEDURE actualizar_foro(v_nombreUsuario VARCHAR2,v_nombre_antiguo VARCHAR2,v_nombre_nuevo VARCHAR2,v_tema VARCHAR2,v_juego VARCHAR2, v_descripcion VARCHAR2);
    --dar like a los foros que le gusten a los usuarios--
    PROCEDURE like_foro(v_nombreForo VARCHAR2);
    --eliminar un foro por su nombre--
    PROCEDURE eliminar_foro(v_nombre VARCHAR2); 
    --creacion de una solicitud--
    PROCEDURE crear_solicitud(v_nombreUsuario VARCHAR2,v_descripcion VARCHAR2);
    --busqueda de las solicitudes del usuario--
    FUNCTION solicitudes_usuario(v_nombreUsuario VARCHAR2)
    RETURN SYS_REFCURSOR;
    --actualizacion de las solicitudes que aun estan en espera--
    PROCEDURE actualizar_solicitud(v_nombreUsuario VARCHAR2,v_descripcion VARCHAR2);
    --actualizar las solicitudes de los usuarios--
    PROCEDURE renovar_solicitud(v_idSolicitud VARCHAR2,v_estado CHAR, v_justificacion VARCHAR2);
    --borrado de las solicitudes que fueron rechazadas--
    PROCEDURE eliminar_solicitudes(v_idSolicitud VARCHAR2);
    --creacion de los logros de la saga--
    PROCEDURE logros_obtenidos(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2, v_descripcion VARCHAR2, v_juego VARCHAR2, v_obtencion NUMBER);
    --actualizacion de los logros de un usuario--
    PROCEDURE renovar_logros(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2, v_descripcion VARCHAR2, v_juego VARCHAR2,v_obtencion number);
    --borrar los logros del usuario--
    PROCEDURE quitar_logros(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2);
    --consultar los foros de interes--
    FUNCTION  foro_interes(v_tema VARCHAR2) RETURN SYS_REFCURSOR;
    --consultar los modos de juego por el nombre--
    FUNCTION modojuego_interes(v_nombre VARCHAR2) RETURN SYS_REFCURSOR;
    --consultar los foros con mayor calificacion--
    FUNCTION foro_popular RETURN SYS_REFCURSOR;
    --consultar los foros recientemente agregados--
    FUNCTION foro_reciente RETURN SYS_REFCURSOR; 
    --consultar  los logros que ha obtenido un usuario--
    FUNCTION logros_usuario(v_nombreUsuario VARCHAR2) RETURN SYS_REFCURSOR; 
    --consultar la acreditacion de un usuario--
    FUNCTION acreditacion(v_nombreUsuario NUMBER) RETURN SYS_REFCURSOR; 
    --consultar las solicitudes que fueron rechazadas--
    FUNCTION solicitudes_rechazadas RETURN SYS_REFCURSOR; 
     --consultar las solicitudes que fueron aceptadas--
    FUNCTION solicitudes_aceptadas RETURN SYS_REFCURSOR; 
    --consultar las solicitudes que aun estan en proceso--
    FUNCTION solicitudes_abiertas RETURN SYS_REFCURSOR; 
    --consultar los foros que ha creado el usuario--
    FUNCTION foros_usuario(v_nombreUsuario NUMBER) RETURN SYS_REFCURSOR; 
END PC_USUARIOS;
/

--CAMPAÑAS--
CREATE OR REPLACE PACKAGE PC_CAMPAÑAS AS
    --procedimiento para crear una nueva campaña--
    PROCEDURE nueva_campaña(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2, v_juego VARCHAR2, v_jugadores NUMBER, v_dificultad VARCHAR2);
    --funcion que retorna el detalle de la campaña del usuario--
    FUNCTION continuar_campaña(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2) RETURN SYS_REFCURSOR;
    --procedimiento para actualizar las campañas del usuario--
    PROCEDURE cargar_campaña(v_nombreUsuario VARCHAR2, v_nombre_antiguo VARCHAR2, v_nombre_nuevo VARCHAR2, v_jugadores NUMBER);
    --procedimiento para eliminar las campañas que ha creado el usuario--
    PROCEDURE eliminar_campaña(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2); 
    --procedimiento para insertar calaveras a una campaña del usuario--
    PROCEDURE insertar_calaveras(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2, v_nombre VARCHAR2, v_descripcion VARCHAR2, v_tipo VARCHAR2);
    --funcion que consulta las calaveras que tiene una campaña del usuario--
    FUNCTION mostrar_calaveras(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2) RETURN SYS_REFCURSOR;
    --precedimiento que elimina las calaveras de la campaña del Usuario--
    PROCEDURE remover_calaveras(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2, v_nombre VARCHAR2); 
    --funcion que consulta las campañas que tiene un usuario--
    FUNCTION campañas_usuario(v_nombreUsuario VARCHAR2) RETURN SYS_REFCURSOR;
    --funcion que consulta los tipos de calaveras que tiene el usuario en sus campañas--
    FUNCTION calaveras_campaña(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2, v_tipoCalavera VARCHAR2) RETURN SYS_REFCURSOR;
END PC_CAMPAÑAS;
/


--PERSONAJES--
CREATE OR REPLACE PACKAGE PC_PERSONAJES AS
    --procedimiento para crear a los personajes junto con flood, humanos o covenant--
    PROCEDURE nuevo_personaje(v_nombreCampaña VARCHAR2,v_nombre VARCHAR2, v_juego VARCHAR2, v_descripcion VARCHAR2, v_desaparecidos CHAR, v_rol VARCHAR2, v_tiposInfectados VARCHAR2, v_rango VARCHAR2, v_especieAlien VARCHAR2);   
    --consulta al personaje por su nombre--
    FUNCTION bitacora_personaje(v_nombre VARCHAR2) RETURN SYS_REFCURSOR;
    --actualiza los datos del personaje en covenant--
    PROCEDURE mejorar_covenant(v_nombre VARCHAR2,v_rango VARCHAR2,v_herejes CHAR,v_armadura NUMBER,v_juego VARCHAR2,v_descripcion VARCHAR2,v_rol VARCHAR2,v_desaparecidos CHAR);
    --actualiza los datos del personaje en humanos--
    PROCEDURE mejorar_humano(v_nombreHumano VARCHAR2,v_rango VARCHAR2,v_juego VARCHAR2,v_descripcion VARCHAR2,v_rol VARCHAR2,v_desaparecidos CHAR);
    --procedimiento que elimina personajes--
    PROCEDURE borrar_personaje(v_nombre VARCHAR2); 
    --Crear los detalles de un mapa en los juegos--
    PROCEDURE generar_mapa(v_nombrePersonaje VARCHAR2,v_nombre VARCHAR2,v_descripcion VARCHAR2,v_juego VARCHAR2,v_lugar VARCHAR2,v_bioma VARCHAR2);
    --Consulta los detalles de un mapa--
    FUNCTION explorar_mapa(v_nombre VARCHAR2) RETURN SYS_REFCURSOR;
    --actualiza los detalles del mapa por su nombre--
    PROCEDURE recargar_mapa(v_nombre VARCHAR2,v_descripcion VARCHAR2,v_juego VARCHAR2,v_lugar VARCHAR2,v_bioma VARCHAR2);
    --elimina los mapas--
    PROCEDURE resetear_mapa(v_nombre VARCHAR2); 
    --devuelve en orden los rangos de los personajes humanos--
    FUNCTION rango_militar
    RETURN SYS_REFCURSOR;
    --retorna los personajes desaparecidos en la saga--
    FUNCTION desaparecidos
    RETURN SYS_REFCURSOR;
    --mapas en los que aparece un personaje--
    FUNCTION mapa_aparicion(v_nombrePersonaje VARCHAR2)
    RETURN SYS_REFCURSOR;
    --retorna los personajes flood mas peligrosos--
    FUNCTION infeccion_alta
    RETURN SYS_REFCURSOR;
    --retorna los herejes que han aparecido en el covenant--
    FUNCTION hereje_covenant
    RETURN SYS_REFCURSOR;
END PC_PERSONAJES;
/

--ARMAMENTOS--
CREATE OR REPLACE PACKAGE PC_ARMAMENTOS AS
    --procedimiento para crear los detalles de una granada--
    PROCEDURE obtener_granada(v_nombreGranada VARCHAR2, v_descripcion VARCHAR2, v_alcance NUMBER, v_daño NUMBER, v_acumulado NUMBER);
    --funcion que retorna los detalles de una granada --
    FUNCTION buscar_granada(v_nombreGranada VARCHAR2) 
    RETURN SYS_REFCURSOR;
    --procedimiento que actualiza los datos de una granada--
    PROCEDURE potenciar_granada(v_nombreGranada VARCHAR2, v_descripcion VARCHAR2, v_alcance NUMBER, v_daño NUMBER, v_acumulado NUMBER);
    --procedimiento que elimina una granada--
    PROCEDURE quitar_granada(v_nombreGranada VARCHAR2);
    --procedimiento que inserta un potenciador--
    PROCEDURE usar_potenciador(v_nombrePotenciador VARCHAR2, v_descripcion VARCHAR2, v_grupo CHAR, v_durabilidad NUMBER);
    --funcion que consulta los potenciadores--
    FUNCTION buscar_potenciador(v_nombrePotenciador VARCHAR2)
    RETURN SYS_REFCURSOR;
    --procedimiento que actualiza los detalles del potenciador--
    PROCEDURE mejorar_potenciador(v_nombrePotenciador VARCHAR2, v_descripcion VARCHAR2, v_durabilidad NUMBER);
    --procedimiento que elimina los potenciadores--
    PROCEDURE quitar_potenciador(v_nombrePotenciador VARCHAR2);
    --procedimiento que inserta en la base de datos el arma del personaje--
    PROCEDURE recolectar_arma(v_idMunicion VARCHAR2,v_nombreArma VARCHAR2, v_tipoArma VARCHAR2, v_definicion VARCHAR2, v_juego VARCHAR2, v_grupo CHAR, v_daño NUMBER, v_nombreGranada VARCHAR2, v_nombrePotenciador VARCHAR2, v_nombrePersonaje VARCHAR2);
    --funcion que retorna las armas de los personajes--
    FUNCTION encontrar_arma(v_nombreArma VARCHAR2)
    RETURN SYS_REFCURSOR;
    --procedimiento que actualiza las armas--
    PROCEDURE potenciar_arma(v_nombreArma VARCHAR2, v_definicion VARCHAR2, v_juego VARCHAR2, v_daño NUMBER, v_manejo VARCHAR2, v_peso NUMBER, v_alcance NUMBER, v_capacidad NUMBER, v_rareza CHAR);
    --procedimiento que elimina los armas--
    PROCEDURE dejar_arma(v_nombreArma VARCHAR2);
    --procedimiento que inserta los vehiculos--
    PROCEDURE subir_vehiculo(v_nombreVehiculo VARCHAR2, v_definicion VARCHAR2, v_asiento NUMBER, v_durabilidad NUMBER, v_velocidad NUMBER, v_tipoVehiculo VARCHAR2, v_juego VARCHAR2, v_grupo CHAR, v_daño NUMBER, v_nombreGranada VARCHAR2, v_nombrePotenciador VARCHAR2, v_nombrePersonaje VARCHAR2);
    --funcion que consulta los detalles de los vehiculos--
    FUNCTION manual_vehiculo(v_nombreVehiculo VARCHAR2)
    RETURN SYS_REFCURSOR;
    --procedimiento que actualiza los datos de los vehiculos--
    PROCEDURE arreglar_vehiculo(v_nombreVehiculo VARCHAR2, v_capacidad NUMBER, v_durabilidad NUMBER, v_velocidad NUMBER, v_definicion VARCHAR2, v_juego VARCHAR2, v_grupo CHAR, v_daño NUMBER, v_manejo VARCHAR2, v_peso NUMBER);
    --procedimiento que inserta municion en la base de datos para las armas--
    PROCEDURE fabricar_municion(v_nombreArma NUMBER, v_material VARCHAR2, v_calibre NUMBER, v_cargador NUMBER);
    --funcion que consulta los detalles de las municiones de las armas--
    FUNCTION buscar_municion(v_material VARCHAR2)
    RETURN SYS_REFCURSOR;
    --procedimiento que actualiza los datos de la municion de las armas--
    PROCEDURE cambiar_municion(v_nombreArma VARCHAR2, v_material VARCHAR2, v_calibre NUMBER, v_cargador NUMBER);
    --procedimiento que elimina los detalles de las municiones--
    PROCEDURE gastar_municion(v_nombreArma VARCHAR2);
    --funcion que consulta la durabilidad que tiene el potenciador--
    FUNCTION durabilidad_potenciador(v_nombrePotenciador VARCHAR2)
    RETURN SYS_REFCURSOR;
    --funcion que consulta el manejo y la dificultad que tiene un arma--
    FUNCTION manejo_arma(v_nombreArma VARCHAR2)
    RETURN SYS_REFCURSOR;
    --funcion que consulta el alcance que puede llegar a tener una granada--
    FUNCTION lanzar_granada(v_nombreGranada VARCHAR2)
    RETURN SYS_REFCURSOR;
    --funcion que consutla el daÃ±o que puede generar una granada al armamento--
    FUNCTION explosion(v_nombreGranada VARCHAR2)
    RETURN SYS_REFCURSOR;
END PC_ARMAMENTOS;
/

/*CRUDI*/
--USUARIOS--
CREATE OR REPLACE PACKAGE BODY PC_USUARIOS AS
    PROCEDURE registrarse (v_correo VARCHAR2, v_nombreUsuario VARCHAR2, v_descripcion VARCHAR2) AS
    BEGIN
        insert into Usuarios(idUsuario, correo, nombreUsuario, descripcion, fechaInicio, fechaFin, acreditacion) values (1,v_correo,v_nombreUsuario,v_descripcion,'10/1/2020','10/1/2023',1);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible crear un usuario');
    end registrarse;
    FUNCTION vista_perfil(v_nombreUsuario VARCHAR2) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT Usuarios.correo,Usuarios.nombreUsuario,Usuarios.descripcion,Usuarios.fechainicio FROM Usuarios WHERE Usuarios.nombreUsuario = v_nombreUsuario;
        return v_cursor;
    end vista_perfil;
    PROCEDURE editar_perfil(nombreUsuario_antiguo VARCHAR2, nombreUsuario_nuevo VARCHAR2, v_correo VARCHAR2, v_descripcion VARCHAR2, v_fechaFin DATE) IS
    BEGIN
        IF nombreUsuario_antiguo is not null AND nombreUsuario_nuevo is not null THEN
            UPDATE Usuarios
            SET nombreUsuario = nombreUsuario_nuevo
            WHERE nombreUsuario = nombreUsuario_antiguo;
        ELSIF nombreUsuario_antiguo is not null and v_correo is not null THEN
            UPDATE Usuarios
            SET correo = v_correo
            WHERE nombreUsuario = nombreUsuario_antiguo;
        ELSIF nombreUsuario_antiguo is not null and v_descripcion is not null THEN
            UPDATE Usuarios
            SET descripcion = v_descripcion
            WHERE nombreUsuario = nombreUsuario_antiguo;
        ELSIF nombreUsuario_antiguo is not null and v_fechaFin is not null THEN
            UPDATE Usuarios
            SET fechaFin = v_fechaFin
            WHERE nombreUsuario = nombreUsuario_antiguo;
        end if;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible actualizar un usuario');
    end editar_perfil;
    PROCEDURE nueva_acreditacion(v_nombreUsuario VARCHAR2, v_acreditacion NUMBER) IS
    BEGIN
        UPDATE Usuarios
        SET acreditacion = v_acreditacion
        WHERE nombreUsuario = v_nombreUsuario;
    end nueva_acreditacion;
    PROCEDURE borrar_usuario(v_nombreUsuario VARCHAR2) IS
        v_idUsuario VARCHAR2(12);   
    BEGIN
        DELETE FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible eliminar al usuario');
    end borrar_usuario;
    PROCEDURE partida_modojuegos(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2, v_descripcion VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
        v_idModo VARCHAR2(9);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        insert into ModoJuegos(idModo, nombre, descripcion, duracion, jugadores, puntuacion) values (1,v_nombre,v_descripcion,1,0,2);
        SELECT MAX(idModo) INTO v_idModo FROM ModoJuegos;
        INSERT INTO UsuariosporModos (idUsuario, idModo) values (v_idUsuario,v_idModo);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible crear un modo de juego');
    end partida_modojuegos;
    FUNCTION historial_partidas(v_nombreUsuario VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
    BEGIN
        select Usuarios.idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        open v_cursor for SELECT ModoJuegos.nombre,ModoJuegos.descripcion,ModoJuegos.duracion,Modojuegos.jugadores,ModoJuegos.puntuacion
        FROM ModoJuegos 
        JOIN UsuariosporModos ON(UsuariosporModos.idModo = ModoJuegos.idModo)
        WHERE idUsuario = v_idUsuario;
        return v_cursor;
    end historial_partidas;
    PROCEDURE actualizar_partida(v_nombreUsuario VARCHAR2, v_nombreAntiguo VARCHAR2,v_nombreNuevo VARCHAR2, v_descripcion VARCHAR2) IS
        v_idModo VARCHAR2(9);
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT modo into v_idModo FROM usuarios_modos WHERE idUsuarios = v_idUsuario and nombre = v_nombreAntiguo;
        if v_nombreAntiguo is not null and v_nombreNuevo is not null THEN
            UPDATE ModoJuegos
            SET nombre = v_nombreNuevo
            WHERE idModo = v_idModo;
        elsif v_nombreAntiguo is not null and v_descripcion is not null THEN
            UPDATE ModoJuegos
            SET descripcion = v_descripcion
            WHERE idModo = v_idModo;
        end if;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible actualizar el modo de juego');
    end actualizar_partida;
    PROCEDURE eliminar_historial(v_nombreUsuario VARCHAR2,v_nombreModo VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        DELETE FROM ModoJuegos WHERE nombre IN (SELECT nombre from usuarios_modos WHERE idUsuarios = v_idUsuario and nombre = v_nombreModo);
        COMMIT; 
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible eliminar el modo de juego');
    end eliminar_historial;
    PROCEDURE generar_nuevo_foro(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2, v_tema VARCHAR2, v_juego VARCHAR2, v_descripcion VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
    BEGIN
        INSERT INTO Foros(nombre,tema,juego,fecha,descripcion,calificacion) values (v_nombre,v_tema,v_juego,'1/1/2020',v_descripcion,0);
        SELECT Usuarios.idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        INSERT INTO UsuariosporForos(idUsuario, nombreForo) values (v_idUsuario,v_nombre);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible crear un foro');
    end generar_nuevo_foro;
    FUNCTION buscar_foro(v_nombreUsuario VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM usuarios_foros WHERE nombreUsuario = v_nombreUsuario;
        return v_cursor;
    end buscar_foro;
    PROCEDURE actualizar_foro(v_nombreUsuario VARCHAR2,v_nombre_antiguo VARCHAR2,v_nombre_nuevo VARCHAR2,v_tema VARCHAR2,v_juego VARCHAR2, v_descripcion VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
    BEGIN 
        select Usuarios.idUsuario into v_idUsuario FROM Usuarios WHERE Usuarios.nombreUsuario = v_nombreUsuario;
        IF v_nombre_antiguo is not null and v_nombre_nuevo is not null THEN
            UPDATE Foros
            SET nombre = v_nombre_nuevo
            WHERE nombre = v_nombre_antiguo;
            UPDATE UsuariosporForos
            SET nombreForo = v_nombre_nuevo
            WHERE nombreForo = v_nombre_antiguo and idUsuario = v_idUsuario;
        elsif v_nombre_antiguo is not null and v_tema is not null THEN
            UPDATE Foros
            SET tema = v_tema
            WHERE nombre = v_nombre_antiguo;
        elsif v_nombre_antiguo is not null and v_juego is not null THEN
            UPDATE Foros
            SET juego = v_juego
            WHERE nombre = v_nombre_antiguo;
        elsif v_nombre_antiguo is not null and v_descripcion is not null THEN
            UPDATE Foros
            SET descripcion = v_descripcion
            WHERE nombre = v_nombre_antiguo;
        end if;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible actualizar el foro');
    end actualizar_foro;
    PROCEDURE like_foro(v_nombreForo VARCHAR2) IS
    BEGIN
        UPDATE Foros
        SET calificacion = calificacion + 1
        WHERE nombre = v_nombreForo;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible darle like al foro');
    end like_foro;
    PROCEDURE eliminar_foro(v_nombre VARCHAR2) IS
    BEGIN
        DELETE FROM Foros WHERE nombre = v_nombre;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible eliminar el foro');
    end eliminar_foro;
    PROCEDURE crear_solicitud(v_nombreUsuario VARCHAR2,v_descripcion VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        insert into Solicitudes(idSolicitud, descripcion, estado, fechacreacion, fechaFinalizacion, justificacion,  idUsuario) values ('a',v_descripcion,'a','a','a','a',v_idUsuario);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible crear una solicitud');
    end crear_solicitud;
    FUNCTION solicitudes_usuario(v_nombreUsuario VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        open v_cursor for SELECT descripcion,estado,fechacreacion,FechaFinalizacion,justificacion FROM Solicitudes
        WHERE idUsuario = v_idUsuario;
        return v_cursor;
    end solicitudes_usuario;
    PROCEDURE actualizar_solicitud(v_nombreUsuario VARCHAR2,v_descripcion VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        UPDATE Solicitudes
        SET descripcion = v_descripcion
        WHERE idUsuario = v_idUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible actualizar la solicitud');
    end actualizar_solicitud;
    PROCEDURE renovar_solicitud(v_idSolicitud VARCHAR2,v_estado CHAR, v_justificacion VARCHAR2) IS
    BEGIN
        UPDATE Solicitudes
        SET estado = v_estado,justificacion = v_justificacion,fechaFinalizacion = SYSDATE
        WHERE idSolicitud = v_idSolicitud;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible Actualizar la solicitud');
    end renovar_solicitud;
    PROCEDURE eliminar_solicitudes(v_idSolicitud VARCHAR2) IS
    BEGIN
        DELETE FROM Solicitudes WHERE idSolicitud = v_idSolicitud;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible eliminar la solicitud');
    end eliminar_solicitudes;
    PROCEDURE logros_obtenidos(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2, v_descripcion VARCHAR2, v_juego VARCHAR2, v_obtencion NUMBER) IS
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        insert into Logros(nombre, descripcion, juego, obtencion, fecha, idUsuario)
        values (v_nombre,v_descripcion,v_juego,v_obtencion,'a',v_idUsuario);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible crear un logro');
    end logros_obtenidos;
    PROCEDURE renovar_logros(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2, v_descripcion VARCHAR2, v_juego VARCHAR2,v_obtencion number) IS
    v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        IF v_nombre is not null THEN
            UPDATE Logros
            SET nombre = v_nombre
            WHERE idUsuario = v_idUsuario;
        ELSIF v_descripcion is not null and v_nombre is not null THEN
            UPDATE Logros
            SET descripcion = v_descripcion
            WHERE nombre = v_nombre and idUsuario = v_idUsuario;
        ELSIF v_juego is not null and v_nombre is not null THEN
            UPDATE Logros
            SET juego = v_juego
            WHERE nombre = v_nombre and idUsuario = v_idUsuario;
        ELSIF v_obtencion is not null and v_nombre is not null THEN
            UPDATE Logros
            SET obtencion = v_obtencion
            WHERE nombre = v_nombre and idUsuario = v_idUsuario;
        end if;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible actualizar el logro');
    end renovar_logros;
    PROCEDURE quitar_logros(v_nombreUsuario VARCHAR2,v_nombre VARCHAR2) IS
    v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        IF v_nombre is not null THEN
            DELETE FROM Logros WHERE nombre = v_nombre and idUsuario = v_idUsuario;
        ELSIF v_nombre is null THEN 
            DELETE FROM Logros WHERE idUsuario = v_idUsuario;
        end if;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible borrar el logro');
    end quitar_logros;
    FUNCTION  foro_interes(v_tema VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor for SELECT * FROM Foros WHERE tema = v_tema;
        return v_cursor;
    end foro_interes;
    FUNCTION modojuego_interes(v_nombre VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT nombre,descripcion,duracion,jugadores,puntuacion FROM ModoJuegos WHERE nombre = v_nombre;
        return v_cursor;
    end modojuego_interes;
    FUNCTION foro_popular 
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * from Foros WHERE calificacion > 1000;
        return v_cursor;
    end foro_popular ;
    FUNCTION foro_reciente
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM Foros WHERE fecha = SYSDATE;
        return v_cursor;
    end foro_reciente;
    FUNCTION logros_usuario(v_nombreUsuario VARCHAR2)
    RETURN SYS_REFCURSOR
    is
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios where nombreUsuario = v_nombreUsuario;
        open v_cursor for SELECT nombre,descripcion,juego,obtencion,fecha FROM Logros WHERE idUsuario = v_idUsuario;
        return v_cursor;
    end logros_usuario;
    FUNCTION acreditacion(v_nombreUsuario NUMBER)
    RETURN SYS_REFCURSOR
    is
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT nombreUsuario,acreditacion FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        return v_cursor;
    end acreditacion;
    FUNCTION solicitudes_rechazadas
    RETURN SYS_REFCURSOR
    is
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM Solicitudes WHERE estado = 'R';
        return v_cursor;
    end solicitudes_rechazadas;
    FUNCTION solicitudes_aceptadas
    RETURN SYS_REFCURSOR
    is
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor FOR SELECT * FROM Solicitudes WHERE estado = 'A';
        return v_cursor;
    end solicitudes_aceptadas;
    FUNCTION solicitudes_abiertas
    RETURN SYS_REFCURSOR
    is
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM Solicitudes WHERE estado = 'E';
        return v_cursor;
    end solicitudes_abiertas;
    FUNCTION foros_usuario(v_nombreUsuario NUMBER)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        OPEN v_cursor FOR SELECT * FROM Foros WHERE nombre = (SELECT nombreForo FROM UsuariosporForos WHERE idUsuario = v_idUsuario);
        return v_cursor;
    end foros_usuario;
end PC_USUARIOS;
/

--CAMPAÑAS--
CREATE OR REPLACE PACKAGE BODY PC_CAMPAÑAS AS
    --crear una nueva campaña--
    PROCEDURE nueva_campaña(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2, v_juego VARCHAR2, v_jugadores NUMBER, v_dificultad VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        INSERT INTO Campañas(nombre, juego, jugadores, dificultad) values (v_nombre, v_juego, v_jugadores, v_dificultad);
        SELECT idUsuario INTO v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT MAX(idCampaña) INTO v_idCampaña FROM Campañas;
        INSERT INTO UsuariosporCampañas(idUsuario, idCampaña) values (v_idUsuario, v_idCampaña);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020,'No es posible crear una nueva campaña');
    end nueva_campaña;
    --retorna el detalle de la campaña de un usuario--
    FUNCTION continuar_campaña(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE idUsuario = v_idUsuario;
        OPEN v_cursor FOR SELECT nombre,juego,jugadores,dificultad FROM Campañas
        JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
        WHERE idUsuario = v_idUsuario and nombre = v_nombre;
        return v_cursor;
    end continuar_campaña;
    --actualizar las campañas de un usuario--
    PROCEDURE cargar_campaña(v_nombreUsuario VARCHAR2, v_nombre_antiguo VARCHAR2, v_nombre_nuevo VARCHAR2, v_jugadores NUMBER) IS
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT Campañas.idCampaña INTO v_idCampaña FROM Campañas
        JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
        WHERE idUsuario = v_idUsuario and nombre = v_nombre_antiguo;
        IF v_jugadores != Null THEN
            UPDATE Campañas
            SET jugadores = v_jugadores
            WHERE idCampaña = v_idCampaña;
        end if;
        IF v_nombre_nuevo != Null THEN
            UPDATE Campañas
            SET nombre = v_nombre_nuevo
            WHERE idCampaña = v_idCampaña;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021,'No es posible actualizar la campaña deseada');
    end cargar_campaña;
    --eliminar las campañas creadas por un Usuario--
    PROCEDURE eliminar_campaña(v_nombreUsuario VARCHAR2, v_nombre VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT Campañas.idCampaña INTO v_idCampaña FROM Campañas JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
        WHERE idUsuario = v_idUsuario and nombre = v_nombre;
        DELETE FROM Campañas WHERE idCampaña = v_idCampaña;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible eliminar la campaña');
    END eliminar_campaña;
    --crear calaveras para una campaña--
    PROCEDURE insertar_calaveras(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2, v_nombre VARCHAR2, v_descripcion VARCHAR2, v_tipo VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(12);
        v_contador NUMBER;
    BEGIN
        v_contador := 0;
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT Campañas.idCampaña INTO v_idCampaña FROM Campañas
        JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
        WHERE idUsuario = v_idUsuario and nombre = v_nombreCampaña;
        insert into Calaveras(nombre, descripcion, tipoCalavera, idCampaña) values (v_nombre, v_descripcion, v_tipo, v_idCampaña);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20023,'No es posible insertar la calavera');
    end insertar_calaveras;
    --consulta las calaveras que tiene una campaña--
    FUNCTION mostrar_calaveras(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT Campañas.idCampaña INTO v_idCampaña FROM Campañas
        JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
        WHERE idUsuario = v_idUsuario and nombre = v_nombreCampaña;
        OPEN v_cursor FOR SELECT nombre, descripcion, tipoCalavera FROM calaveras 
        WHERE idCampaña = v_idCampaña;
        return v_cursor;
    end mostrar_calaveras;
    --elimina las calaveras de una campaña--
    PROCEDURE remover_calaveras(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2, v_nombre VARCHAR2) IS
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        SELECT idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_nombreUsuario;
        SELECT Campañas.idCampaña INTO v_idCampaña FROM Campañas
        JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
        WHERE idUsuario = v_idUsuario and nombre = v_nombreCampaña;
        DELETE FROM Calaveras WHERE nombre = v_nombre and idCampaña = v_idCampaña;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20024,'No es posible eliminar la calavera');
    END remover_calaveras;
    --consulta las campañas creadas por un usuario--
    FUNCTION campañas_usuario(v_nombreUsuario VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        select Usuarios.idUsuario into v_idUsuario FROM Usuarios WHERE nombreUsuario = v_idUsuario;
        select UsuariosporCampañas.idCampaña into v_idCampaña FROM UsuariosporCampañas WHERE idUsuario = v_idUsuario;
        OPEN v_cursor FOR SELECT Campañas.nombre, Campañas.juego, Campañas.jugadores, Campañas.dificultad FROM Campañas WHERE idCampaña = v_idCampaña;
        RETURN v_cursor;
    end campañas_usuario;
    --consulta los tipos de calavera que tiene una campaña--
    FUNCTION calaveras_campaña(v_nombreUsuario VARCHAR2, v_nombreCampaña VARCHAR2, v_tipoCalavera VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
        v_idUsuario VARCHAR2(12);
        v_idCampaña VARCHAR2(9);
    BEGIN
        OPEN v_cursor FOR SELECT * FROM usuarios_calaveras
        WHERE usuario = v_nombreUsuario and campañas = v_nombreCampaña and tipoCalavera = v_tipoCalavera;
        RETURN v_cursor;
    end calaveras_campaña;
end PC_CAMPAÑAS;
/
--PERSONAJES--
CREATE OR REPLACE PACKAGE BODY PC_PERSONAJES AS
    --procedimiento para crear a los personajes junto con flood, humanos o covenant--
    PROCEDURE nuevo_personaje(v_nombreCampaña VARCHAR2,v_nombre VARCHAR2, v_juego VARCHAR2, v_descripcion VARCHAR2, v_desaparecidos CHAR, v_rol VARCHAR2, v_tiposInfectados VARCHAR2, v_rango VARCHAR2, v_especieAlien VARCHAR2) IS
        v_idCampaña VARCHAR2(9);
    BEGIN
        SELECT idCampaña into v_idCampaña FROM Campañas WHERE nombre = v_nombreCampaña;
        IF v_rango is not null THEN
            insert into Personajes(nombre, grupo, juego, descripcion, rol, desaparecidos, idCampaña,vida) values (v_nombre,'H',v_juego,v_descripcion,v_rol,v_desaparecidos,v_idCampaña,'a');
            insert into Humanos(nombreHumano, rango,armadura) values (v_nombre,v_rango,0);
        ELSIF v_tiposInfectados is not null THEN
            insert into Personajes(nombre, grupo, juego, descripcion, rol, desaparecidos, idCampaña,vida) values (v_nombre,'F',v_juego,v_descripcion,v_rol,v_desaparecidos,v_idCampaña,'a');
            insert into Floods(nombreFlood, tiposInfectados,huesped) values (v_nombre,v_tiposInfectados,'sensible');
        ELSIF v_especieAlien is not null THEN
            insert into Personajes(nombre, grupo, juego, descripcion, rol, desaparecidos, idCampaña,vida) values (v_nombre,'C',v_juego,v_descripcion,v_rol,v_desaparecidos,v_idCampaña,'a');
            insert into Covenant(nombreCovenant,especieAlien,jerarquia,rango,herejes,armadura) values (v_nombre,v_especieAlien,'a','a','a','a');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
            RAISE_APPLICATION_ERROR(-20020,'No es posible agregar un personaje');
    end nuevo_personaje;
    --consulta al personaje por su nombre--
    FUNCTION bitacora_personaje(v_nombre VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT nombre,grupo,juego,descripcion,rol,desaparecidos,vida FROM Personajes WHERE
        nombre = v_nombre;
        return v_cursor;
    end bitacora_personaje;
    --actualiza los datos del personaje en covenant--
    PROCEDURE mejorar_covenant(v_nombre VARCHAR2,v_rango VARCHAR2,v_herejes CHAR,v_armadura NUMBER,v_juego VARCHAR2,v_descripcion VARCHAR2,v_rol VARCHAR2,v_desaparecidos CHAR) IS
    BEGIN
        IF v_nombre != null and v_rango != null THEN
            UPDATE Covenant
            SET rango = v_rango
            WHERE nombreCovenant = v_nombre;
        ELSIF v_nombre != null and v_herejes != null THEN
            UPDATE Covenant
            SET herejes = v_herejes
            WHERE nombreCovenant = v_nombre;
        ELSIF v_nombre != null and v_armadura != null THEN
            UPDATE Covenant 
            SET armadura = v_armadura
            WHERE nombreCovenant = v_nombre;
        ELSIF v_nombre != null and v_juego != null THEN
            UPDATE Personajes
            SET juego = v_juego
            WHERE nombre = v_nombre;
        ELSIF v_nombre != null and v_descripcion != null THEN
            UPDATE Personajes
            SET descripcion = v_descripcion
            WHERE nombre = v_nombre;
        ELSIF v_nombre != null and v_rol != null THEN
            UPDATE Personajes
            SET rol = v_rol
            WHERE nombre = v_nombre;
        ELSIF v_nombre != null and v_desaparecidos != null THEN
            UPDATE Personajes
            SET desaparecidos = v_desaparecidos
            WHERE nombre = v_nombre;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021,'no es posible actualizar al personaje Covenant');
    end mejorar_covenant;
    --actualiza los datos del personaje en humanos--
    PROCEDURE mejorar_humano(v_nombreHumano VARCHAR2,v_rango VARCHAR2,v_juego VARCHAR2,v_descripcion VARCHAR2,v_rol VARCHAR2,v_desaparecidos CHAR) IS
    BEGIN
        if v_nombreHumano != null and v_rango != null THEN
            UPDATE Humanos
            SET rango = v_rango
            WHERE nombreHumano = v_nombreHumano;
        elsif v_nombreHumano != null and v_juego != null THEN
            UPDATE Personajes
            SET juego = v_juego
            WHERE nombre = v_nombreHumano;
        elsif v_nombreHumano != null and v_descripcion != null THEN
            UPDATE Personajes
            SET descripcion = v_descripcion
            WHERE nombre = v_nombreHumano;
        elsif v_nombreHumano != null and v_rol != null THEN
            UPDATE Personajes
            SET rol = v_rol
            WHERE nombre = v_nombreHumano;
        elsif v_nombreHumano != null and v_desaparecidos != null THEN
            UPDATE Personajes
            SET desaparecidos = v_desaparecidos
            WHERE nombre = v_nombreHumano;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021,'no se puede actualizar al personaje humano');
    end mejorar_humano;
    --procedimiento que elimina personajes--
    PROCEDURE borrar_personaje(v_nombre VARCHAR2) IS
    BEGIN
        DELETE FROM Personajes WHERE nombre = v_nombre;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021,'No es posible eliminar al personaje');
    end borrar_personaje;
    --Crear los detalles de un mapa en los juegos--
    PROCEDURE generar_mapa(v_nombrePersonaje VARCHAR2,v_nombre VARCHAR2,v_descripcion VARCHAR2,v_juego VARCHAR2,v_lugar VARCHAR2,v_bioma VARCHAR2) IS
    BEGIN
        INSERT INTO Mapas(nombre, descripcion, juego, lugar, bioma) values (v_nombre,v_descripcion,v_juego,v_lugar,v_bioma);
        INSERT INTO PersonajesporMapas(nombrePersonaje, nombreMapa) values (v_nombrePersonaje,v_nombre);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021,'No es posible crear un mapa');
    end generar_mapa;
    --Consulta los detalles de un mapa--
    FUNCTION explorar_mapa(v_nombre VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM Mapas WHERE nombre = v_nombre;
        return v_cursor;
    end explorar_mapa;
    --actualiza los detalles del mapa por su nombre--
    PROCEDURE recargar_mapa(v_nombre VARCHAR2,v_descripcion VARCHAR2,v_juego VARCHAR2,v_lugar VARCHAR2,v_bioma VARCHAR2) IS
    BEGIN
        IF v_nombre != null and v_descripcion != null THEN
            UPDATE Mapas
            SET descripcion = v_descripcion
            WHERE nombre = v_nombre;
        ELSIF v_nombre != null and v_juego != null THEN
            UPDATE Mapas
            SET juego = v_juego
            WHERE nombre = v_nombre;
        ELSIF v_nombre != null and v_lugar != null and v_bioma != null THEN
            UPDATE Mapas
            SET lugar = v_lugar,bioma = v_bioma
            WHERE nombre = v_nombre;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
            RAISE_APPLICATION_ERROR(-20021,'No es posible actualizar el mapa');
    end recargar_mapa;
    --elimina los mapas--
    PROCEDURE resetear_mapa(v_nombre VARCHAR2) IS
    BEGIN
        DELETE FROM Mapas WHERE nombre = v_nombre;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021,'No es posible eliminar el mapa');
    end resetear_mapa;
    --devuelve en orden los rangos de los personajes humanos--
    FUNCTION rango_militar
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM Humanos ORDER BY rango ASC;
        return v_cursor;
    end rango_militar;
    --retorna los personajes desaparecidos en la saga--
    FUNCTION desaparecidos
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT Personajes.nombre,Personajes.grupo,Personajes.juego,Personajes.descripcion,Personajes.rol,Personajes.desaparecidos,Personajes.vida FROM Personajes WHERE desaparecidos = 'T';
        return v_cursor;
    end desaparecidos;
    --mapas en los que aparece un personaje--
    FUNCTION mapa_aparicion(v_nombrePersonaje VARCHAR2)
    RETURN SYS_REFCURSOR
    IS 
        v_cursor SYS_REFCURSOR;
        v_nombremapa VARCHAR2(100);
    BEGIN
        SELECT nombreMapa into v_nombremapa FROM PersonajesporMapas WHERE nombrePersonaje = v_nombrePersonaje;
        open v_cursor for SELECT * FROM Mapas WHERE nombre = v_nombremapa;
        return v_cursor;
    end mapa_aparicion;
    --retorna los personajes flood mas peligrosos--
    FUNCTION infeccion_alta
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT * FROM Floods WHERE huesped = 'sensible';
        return v_cursor;
    end infeccion_alta;
    --retorna los herejes que han aparecido en el covenant--
    FUNCTION hereje_covenant
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN  
        open v_cursor for SELECT * FROM Covenant WHERE herejes = 'T';
        return v_cursor;
    end hereje_covenant;
end PC_PERSONAJES;
/

--ARMAMENTOS--
CREATE OR REPLACE PACKAGE BODY PC_ARMAMENTOS AS
    --crear una granada--
    PROCEDURE obtener_granada(v_nombreGranada VARCHAR2, v_descripcion VARCHAR2, v_alcance NUMBER, v_daño NUMBER, v_acumulado NUMBER) IS
    BEGIN
        INSERT INTO Granadas(nombreGranada, descripcion, alcance, dano, acumulado) VALUES (v_nombreGranada, v_descripcion, v_alcance, v_daño, v_acumulado);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible crear una granada');
    END obtener_granada;
    --consultar una granada por su nombre--
    FUNCTION buscar_granada(v_nombreGranada VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM Granadas 
        WHERE nombreGranada = v_nombreGranada;
        RETURN v_cursor;
    END buscar_granada;
    --actualiza los datos de una granada--
    PROCEDURE potenciar_granada(v_nombreGranada VARCHAR2, v_descripcion VARCHAR2, v_alcance NUMBER, v_daño NUMBER, v_acumulado NUMBER) IS
    BEGIN
        IF v_descripcion IS NOT NULL THEN
            UPDATE Granadas
            SET descripcion = v_descripcion 
            WHERE nombreGranada = v_nombreGranada;
        END IF;
        IF v_alcance IS NOT NULL THEN
            UPDATE Granadas
            SET alcance = v_alcance
            WHERE nombreGranada = v_nombreGranada;
        END IF;
        IF v_daño IS NOT NULL THEN
            UPDATE Granadas
            SET dano = v_daño
            WHERE nombreGranada = v_nombreGranada;
        END IF;
        IF v_acumulado IS NOT NULL THEN
            UPDATE Granadas
            SET acumulado = v_acumulado
            WHERE nombreGranada = v_nombreGranada;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible actualizar la granada');
    END potenciar_granada;
    --elimina una granada--
    PROCEDURE quitar_granada(v_nombreGranada VARCHAR2) IS
    BEGIN
        DELETE FROM Granadas WHERE nombreGranada = v_nombreGranada;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible eliminar la granada');
    END quitar_granada;
    --crear un potenciador--
    PROCEDURE usar_potenciador(v_nombrePotenciador VARCHAR2, v_descripcion VARCHAR2, v_grupo CHAR, v_durabilidad NUMBER) IS
    BEGIN
        INSERT INTO potenciadores (nombrePotenciador, descripcion, grupo, durabilidad) VALUES (v_nombrePotenciador, v_descripcion, v_grupo, v_durabilidad);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible crear un potenciador');
    END usar_potenciador;
    --consultar un potenciador por su nombre--
    FUNCTION buscar_potenciador(v_nombrePotenciador VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM potenciadores
        WHERE nombrePotenciador = v_nombrePotenciador;
        RETURN v_cursor;
    END buscar_potenciador;
    --actualiza los detalles del potenciador--
    PROCEDURE mejorar_potenciador(v_nombrePotenciador VARCHAR2, v_descripcion VARCHAR2, v_durabilidad NUMBER) IS
    BEGIN
        IF v_descripcion IS NOT NULL THEN
            UPDATE potenciadores
            SET descripcion = v_descripcion
            WHERE nombrePotenciador = v_nombrePotenciador;
        END IF;
        IF v_durabilidad IS NOT NULL THEN
            UPDATE potenciadores
            SET durabilidad = v_durabilidad
            WHERE nombrePotenciador = v_nombrePotenciador;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible actualizar el potenciador');
    END mejorar_potenciador;
    --elimina el potenciador--
    PROCEDURE quitar_potenciador(v_nombrePotenciador VARCHAR2) IS
    BEGIN
        DELETE FROM potenciadores WHERE nombrePotenciador = v_nombrePotenciador;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible eliminar un potenciador');
    END quitar_potenciador;
    --crear un arma--
    PROCEDURE recolectar_arma(v_idMunicion VARCHAR2,v_nombreArma VARCHAR2, v_tipoArma VARCHAR2, v_definicion VARCHAR2, v_juego VARCHAR2, v_grupo CHAR, v_daño NUMBER, v_nombreGranada VARCHAR2, v_nombrePotenciador VARCHAR2, v_nombrePersonaje VARCHAR2) IS
    BEGIN
        INSERT INTO Armamentos (nombre, definicion, juego, grupo, dano, nombreGranada, nombrePotenciador, nombrePersonaje) VALUES (v_nombreArma, v_definicion, v_juego, v_grupo, v_daño, v_nombreGranada, v_nombrePotenciador, v_nombrePersonaje);
        INSERT INTO armas (nombreArma, tipoArma, idMunicion) VALUES (v_nombreArma, v_tipoArma, v_idMunicion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible crear un arma');
    END recolectar_arma;
    --consulta las armas de un personaje--
    FUNCTION encontrar_arma(v_nombreArma VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT Armamentos.nombre, Armamentos.definicion, Armamentos.juego, Armamentos.grupo, Armamentos.dano, Armamentos.manejo, Armamentos.peso, Armas.tipoArma, Armas.alcance, Armas.capacidad, Armas.rareza FROM Armamentos
        JOIN Armas ON (Armas.nombreArma = Armamentos.nombre)
        WHERE nombre = v_nombreArma;
        RETURN v_cursor;
    END encontrar_arma;
    --actualiza los datos de un arma--
    PROCEDURE potenciar_arma(v_nombreArma VARCHAR2, v_definicion VARCHAR2, v_juego VARCHAR2, v_daño NUMBER, v_manejo VARCHAR2, v_peso NUMBER, v_alcance NUMBER, v_capacidad NUMBER, v_rareza CHAR) IS
    BEGIN
        IF v_definicion IS NOT NULL THEN
            UPDATE Armamentos
            SET definicion = v_definicion
            WHERE nombre = v_nombreArma;
        END IF;
        IF v_juego IS NOT NULL THEN
            UPDATE Armamentos
            SET juego = v_juego
            WHERE nombre = v_nombreArma;
        END IF;
        IF v_daño IS NOT NULL THEN
            UPDATE Armamentos
            SET dano = v_daño
            WHERE nombre = v_nombreArma;
        END IF;
        IF v_manejo IS NOT NULL THEN
            UPDATE Armamentos
            SET manejo = v_manejo
            WHERE nombre = v_nombreArma;
        END IF;
        IF v_peso IS NOT NULL THEN
            UPDATE Armamentos
            SET peso = v_peso
            WHERE nombre = v_nombreArma;
        END IF;
        IF v_alcance IS NOT NULL THEN
            UPDATE Armas
            SET alcance = v_alcance
            WHERE nombreArma = v_nombreArma;
        END IF;
        IF v_capacidad IS NOT NULL THEN
            UPDATE Armas
            SET capacidad = v_capacidad
            WHERE nombreArma = v_nombreArma;
        END IF;
        IF v_rareza IS NOT NULL THEN
            UPDATE Armas
            SET rareza = v_rareza
            WHERE nombreArma = v_nombreArma;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible actualizar el arma');
    END potenciar_arma;
    --eliminar un arma--
    PROCEDURE dejar_arma(v_nombreArma VARCHAR2) IS
    BEGIN
        DELETE FROM Armamentos WHERE nombre = v_nombreArma;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible eliminar el arma');
    END dejar_arma;
    --inserta vehiculos a la base de datos--
    PROCEDURE subir_vehiculo(v_nombreVehiculo VARCHAR2, v_definicion VARCHAR2, v_asiento NUMBER, v_durabilidad NUMBER, v_velocidad NUMBER, v_tipoVehiculo VARCHAR2, v_juego VARCHAR2, v_grupo CHAR, v_daño NUMBER, v_nombreGranada VARCHAR2, v_nombrePotenciador VARCHAR2, v_nombrePersonaje VARCHAR2) IS
    BEGIN
        INSERT INTO Armamentos (nombre, definicion, juego, grupo, dano, nombreGranada, nombrePotenciador, nombrePersonaje) VALUES (v_nombreVehiculo, v_definicion, v_juego, v_grupo, v_daño, v_nombreGranada, v_nombrePotenciador, v_nombrePersonaje);
        INSERT INTO vehiculos (nombreVehiculo, asiento, durabilidad, velocidad, tipoVehiculo) VALUES (v_nombreVehiculo, v_asiento, v_durabilidad, v_velocidad, v_tipoVehiculo);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible crear un vehiculo');
    END subir_vehiculo;
    --consulta un vehiculo por su nombre--
    FUNCTION manual_vehiculo(v_nombreVehiculo VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT Armamentos.nombre, Armamentos.definicion, Armamentos.juego, Armamentos.grupo, Armamentos.dano, Armamentos.manejo, Armamentos.peso, Vehiculos.tipoVehiculo, Vehiculos.altitud, Vehiculos.asiento, Vehiculos.durabilidad, Vehiculos.velocidad
        FROM Armamentos
        JOIN vehiculos ON (vehiculos.nombreVehiculo = Armamentos.nombre)
        WHERE nombre = v_nombreVehiculo;
        RETURN v_cursor;
    END manual_vehiculo;
    --actualiza los datos de un vehiculo--
    PROCEDURE arreglar_vehiculo(v_nombreVehiculo VARCHAR2, v_capacidad NUMBER, v_durabilidad NUMBER, v_velocidad NUMBER, v_definicion VARCHAR2, v_juego VARCHAR2, v_grupo CHAR, v_daño NUMBER, v_manejo VARCHAR2, v_peso NUMBER) IS
    BEGIN
        IF v_definicion IS NOT NULL THEN
            UPDATE Armamentos
            SET definicion = v_definicion
            WHERE nombre = v_nombreVehiculo;
        END IF;
        IF v_juego IS NOT NULL THEN
            UPDATE Armamentos
            SET juego = v_juego
            WHERE nombre = v_nombreVehiculo;
        END IF;
        IF v_daño IS NOT NULL THEN
            UPDATE Armamentos
            SET dano = v_daño
            WHERE nombre = v_nombreVehiculo;
        END IF;
        IF v_manejo IS NOT NULL THEN
            UPDATE Armamentos
            SET manejo = v_manejo
            WHERE nombre = v_nombreVehiculo;
        END IF;
        IF v_peso IS NOT NULL THEN
            UPDATE Armamentos
            SET peso = v_peso
            WHERE nombre = v_nombreVehiculo;
        END IF;
        IF v_durabilidad IS NOT NULL THEN
            UPDATE vehiculos
            SET durabilidad = v_durabilidad
            WHERE nombreVehiculo = v_nombreVehiculo;
        END IF;
        IF v_velocidad IS NOT NULL THEN
            UPDATE vehiculos
            SET velocidad = v_velocidad
            WHERE nombreVehiculo = v_nombreVehiculo;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible actualizar el vehiculo');
    END arreglar_vehiculo;
    --inserta municion a la base de datos--
    PROCEDURE fabricar_municion(v_nombreArma NUMBER, v_material VARCHAR2, v_calibre NUMBER, v_cargador NUMBER) IS
    BEGIN
        INSERT INTO municiones (material, calibre, cargador) VALUES (v_material, v_calibre, v_cargador);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible crear una municion');
    END fabricar_municion;
    --consulta los detalles de una municion--
    FUNCTION buscar_municion(v_material VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM municiones
        WHERE material = v_material;
        RETURN v_cursor;
    END buscar_municion;
    --actualiza los datos de una municion--
    PROCEDURE cambiar_municion(v_nombreArma VARCHAR2, v_material VARCHAR2, v_calibre NUMBER, v_cargador NUMBER) IS
        v_idMunicion VARCHAR2(10);
    BEGIN
        SELECT idMunicion INTO v_idMunicion FROM Armas 
        WHERE nombreArma = v_nombreArma;
        IF v_material IS NOT NULL THEN
            UPDATE Municiones
            SET material = v_material
            WHERE idMunicion = v_idMunicion;
        END IF;
        IF v_calibre IS NOT NULL THEN
            UPDATE Municiones
            SET calibre = v_calibre
            WHERE idMunicion = v_idMunicion;
        END IF;
        IF v_cargador IS NOT NULL THEN
            UPDATE Municiones
            SET cargador = v_cargador
            WHERE idMunicion = v_idMunicion;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible actualizar la municion');
    END cambiar_municion;
    --elimina municion de la base de datos--
    PROCEDURE gastar_municion(v_nombreArma VARCHAR2) IS
        v_idmunicion VARCHAR2(10);
    BEGIN
        SELECT idMunicion into v_idmunicion FROM Armas WHERE nombreArma = v_nombreArma;
        DELETE FROM Municiones WHERE idMunicion = v_idmunicion;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20022,'No es posible eliminar la municion');
    end gastar_municion;
    --consultar la durabilidad de un potenciador--
    FUNCTION durabilidad_potenciador(v_nombrePotenciador VARCHAR2) 
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT Potenciadores.nombrePotenciador,Potenciadores.durabilidad FROM Potenciadores WHERE nombrePotenciador = v_nombrePotenciador;
        return v_cursor;
    end durabilidad_potenciador;
    --consulta el manejo de un arma--
    FUNCTION manejo_arma(v_nombreArma VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT nombre,manejo FROM Armamentos WHERE nombre = v_nombreArma;
        return v_cursor;
    end manejo_arma;
    --consulta el alcance que tiene una granada--
    FUNCTION lanzar_granada(v_nombreGranada VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT nombreGranada,alcance FROM Granadas WHERE nombreGranada = v_nombreGranada;
        return v_cursor;
    end lanzar_granada;
    --consulta el daño que hace una granada--
    FUNCTION explosion(v_nombreGranada VARCHAR2)
    RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        open v_cursor for SELECT nombreGranada,dano FROM Granadas WHERE nombreGranada = v_nombreGranada;
        return v_cursor;
    end explosion;
end PC_ARMAMENTOS;
/
/*X CRUD*/
DROP PACKAGE PC_USUARIOS;
DROP PACKAGE PC_CAMPAÑAS;
DROP PACKAGE PC_PERSONAJES;
DROP PACKAGE PC_ARMAMENTOS;