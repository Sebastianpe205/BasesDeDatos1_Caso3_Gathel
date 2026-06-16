/* =========================================================
   EVENT TYPES
========================================================= */

SET IDENTITY_INSERT EventTypes ON;

INSERT INTO EventTypes
(
    EventTypeId,
    EventTypeName,
    CreatedAt
)
VALUES
(1, N'Creación de Proposición', SYSUTCDATETIME()),
(2, N'Votación', SYSUTCDATETIME()),
(3, N'Aceptación', SYSUTCDATETIME()),
(4, N'Rechazo', SYSUTCDATETIME()),
(5, N'Predicción Creada', SYSUTCDATETIME()),
(6, N'Predicción Actualizada', SYSUTCDATETIME()),
(7, N'Cierre de Predicción', SYSUTCDATETIME()),
(8, N'Validación de Resultado', SYSUTCDATETIME()),
(9, N'Pago Procesado', SYSUTCDATETIME()),
(10, N'Notificación Enviada', SYSUTCDATETIME());

SET IDENTITY_INSERT EventTypes OFF;


/* =========================================================
   EVENT SOURCES
========================================================= */

SET IDENTITY_INSERT EventSources ON;

INSERT INTO EventSources
(
    EventSourceId,
    EventSourceName,
    CreatedAt
)
VALUES
(1, N'Sistema', SYSUTCDATETIME()),
(2, N'Jugador', SYSUTCDATETIME()),
(3, N'IA', SYSUTCDATETIME()),
(4, N'Moderador', SYSUTCDATETIME()),
(5, N'API', SYSUTCDATETIME());

SET IDENTITY_INSERT EventSources OFF;


/* =========================================================
   ENTITY TYPES
========================================================= */

SET IDENTITY_INSERT EntityTypes ON;

INSERT INTO EntityTypes
(
    EntityTypeId,
    EntityTypeName,
    CreatedAt
)
VALUES
(1, N'Jugador', SYSUTCDATETIME()),
(2, N'Proposición', SYSUTCDATETIME()),
(3, N'Predicción', SYSUTCDATETIME()),
(4, N'Billetera', SYSUTCDATETIME()),
(5, N'Pago', SYSUTCDATETIME()),
(6, N'Evidencia', SYSUTCDATETIME()),
(7, N'Notificación', SYSUTCDATETIME());

SET IDENTITY_INSERT EntityTypes OFF;