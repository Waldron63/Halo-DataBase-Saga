/*VISTAS*/
--vista de Usuarios con Campañas con Calaveras--
CREATE VIEW usuarios_calaveras
AS SELECT nombreUsuario as usuario, Campañas.nombre as campañas, Calaveras.nombre as calaveras, Campañas.juego, Campañas.dificultad, Campañas.jugadores, Calaveras.tipoCalavera
FROM Usuarios
JOIN UsuariosporCampañas ON (UsuariosporCampañas.idUsuario = Usuarios.idUsuario)
JOIN Campañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
JOIN Calaveras ON (Campañas.idCampaña = Calaveras.idCampaña)
WITH READ ONLY;
--vista de Usuarios con Foros--
CREATE VIEW usuarios_foros
AS SELECT nombre as titulo, Foros.tema, Foros.juego, Foros.fecha, Foros.descripcion, Foros.calificacion, Usuarios.nombreUsuario
FROM Foros
JOIN UsuariosporForos ON (UsuariosporForos.nombreForo = Foros.nombre)
JOIN Usuarios ON (Usuarios.idUsuario = UsuariosporForos.idUsuario)
WITH READ ONLY;
--vista de usuarios y modos de juego--
CREATE VIEW usuarios_modos
AS SELECT ModoJuegos.idModo as modo, ModoJuegos.nombre as nombre,ModoJuegos.descripcion,ModoJuegos.duracion,ModoJuegos.jugadores,ModoJuegos.puntuacion,UsuariosporModos.idUsuario as idUsuarios
FROM ModoJuegos
JOIN UsuariosporModos ON (UsuariosporModos.idModo = ModoJuegos.idModo)
JOIN Usuarios ON (Usuarios.idUsuario = UsuariosporModos.idUsuario)
WITH READ ONLY;
CREATE VIEW usuarios_campañas
AS SELECT Campañas.idCampaña as idcampaña,Campañas.nombre AS campaña,Campañas.juego,Campañas.jugadores,Campañas.dificultad,Usuarios.idUsuario as idUsuarios
FROM Campañas
JOIN UsuariosporCampañas ON (UsuariosporCampañas.idCampaña = Campañas.idCampaña)
JOIN Usuarios ON (Usuarios.idUsuario = UsuariosporCampañas.idCampaña)
WITH READ ONLY;
/*INDICES*/
--indice para el nombre de Usuario--
CREATE UNIQUE INDEX Usuarios_1
on Usuarios(nombreUsuario);

--indice para la acreditacion del usuario--
CREATE INDEX Usuarios_2
on Usuarios(acreditacion);

--indice para el estado de la solicitud--
CREATE INDEX solicitudes_1
on Solicitudes(estado);

/*XINDICES*/
DROP INDEX Usuarios_1;
DROP INDEX Usuarios_2;
DROP INDEX solicitudes_1;

/*XVISTAS*/
DROP VIEW usuarios_calaveras;
DROP VIEW usuarios_foros;
drop view usuarios_modos;
drop view usuarios_campañas;