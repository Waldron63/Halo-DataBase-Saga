--------------
---Para esta prueba vamos a simular el comportamiento de un usuario dentro de la base de datos, partiendo de la creacion del mismo--
--1. Registro del Usuario a la base de datos--
BEGIN
    PC_USUARIOS.registrarse(
    v_correo => 'usuario@gmail.com',
    v_nombreUsuario => 'Usuario de Prueba',
    v_descripcion => 'este es de prueba'
    );
    end;
/
--2. el usuario al ser un fan de la saga decide crear un foro con un tema de su interes--
    PC_USUARIOS.generar_nuevo_foro(
    
    );
    end;
/

