/* =========================================================
   GÉNEROS
========================================================= */

SET IDENTITY_INSERT Genders ON;

INSERT INTO Genders
(
    GenderId,
    GenderName,
    CreatedAt
)
VALUES
(1, N'Masculino', SYSUTCDATETIME()),
(2, N'Femenino', SYSUTCDATETIME()),
(3, N'No Binario', SYSUTCDATETIME()),
(4, N'Prefiero No Indicarlo', SYSUTCDATETIME());

SET IDENTITY_INSERT Genders OFF;


/* =========================================================
   ROLES
========================================================= */

SET IDENTITY_INSERT Roles ON;

INSERT INTO Roles
(
    RoleId,
    RoleName,
    Description,
    IsActive,
    CreatedAt
)
VALUES
(1, N'Jugador', N'Jugador regular de la plataforma', 1, SYSUTCDATETIME()),
(2, N'Moderador', N'Moderador de contenido y revisiones', 1, SYSUTCDATETIME()),
(3, N'Administrador', N'Administrador general del sistema', 1, SYSUTCDATETIME());

SET IDENTITY_INSERT Roles OFF;


/* =========================================================
   MÉTODOS DE PAGO
========================================================= */

SET IDENTITY_INSERT PaymentMethods ON;

INSERT INTO PaymentMethods
(
    PaymentMethodId,
    PaymentMethodName,
    Description,
    Configuration,
    IsActive,
    CreatedAt,
    UpdatedAt
)
VALUES
(1, N'Tarjeta de Crédito', N'Pago mediante tarjeta de crédito', N'{}', 1, SYSUTCDATETIME(), SYSUTCDATETIME()),
(2, N'Tarjeta de Débito', N'Pago mediante tarjeta de débito', N'{}', 1, SYSUTCDATETIME(), SYSUTCDATETIME()),
(3, N'Transferencia Bancaria', N'Transferencia desde cuenta bancaria', N'{}', 1, SYSUTCDATETIME(), SYSUTCDATETIME()),
(4, N'PayPal', N'Pago mediante PayPal', N'{}', 1, SYSUTCDATETIME(), SYSUTCDATETIME());

SET IDENTITY_INSERT PaymentMethods OFF;


/* =========================================================
   ESTADOS DE PAGO
========================================================= */

SET IDENTITY_INSERT PaymentStatuses ON;

INSERT INTO PaymentStatuses
(
    PaymentStatusId,
    PaymentStatusName,
    Description,
    IsActive,
    CreatedAt
)
VALUES
(1, N'Pendiente', N'Pago pendiente de procesamiento', 1, SYSUTCDATETIME()),
(2, N'Completado', N'Pago procesado exitosamente', 1, SYSUTCDATETIME()),
(3, N'Fallido', N'Error durante el procesamiento', 1, SYSUTCDATETIME()),
(4, N'Reembolsado', N'Monto devuelto al usuario', 1, SYSUTCDATETIME()),
(5, N'Cancelado', N'Pago cancelado', 1, SYSUTCDATETIME());

SET IDENTITY_INSERT PaymentStatuses OFF;


/* =========================================================
   ESTADOS DE PREDICCIÓN
========================================================= */

SET IDENTITY_INSERT PredictionStatuses ON;

INSERT INTO PredictionStatuses
(
    PredictionStatusId,
    PredictionStatusName,
    Description,
    CreatedAt
)
VALUES
(1, N'Pendiente', N'Esperando resultado de la proposición', SYSUTCDATETIME()),
(2, N'Ganadora', N'Predicción acertada', SYSUTCDATETIME()),
(3, N'Perdedora', N'Predicción incorrecta', SYSUTCDATETIME()),
(4, N'Cancelada', N'Predicción anulada', SYSUTCDATETIME());

SET IDENTITY_INSERT PredictionStatuses OFF;


/* =========================================================
   RESULTADOS DE PREDICCIÓN
========================================================= */

SET IDENTITY_INSERT PredictionOutcomes ON;

INSERT INTO PredictionOutcomes
(
    PredictionOutcomeId,
    PredictionOutcomeName,
    Description,
    CreatedAt
)
VALUES
(1, N'Sí', N'La proposición se cumplirá', SYSUTCDATETIME()),
(2, N'No', N'La proposición no se cumplirá', SYSUTCDATETIME());

SET IDENTITY_INSERT PredictionOutcomes OFF;


/* =========================================================
   ESTADOS DE PROPOSICIÓN
========================================================= */

SET IDENTITY_INSERT PropositionStatuses ON;

INSERT INTO PropositionStatuses
(
    StatusId,
    StatusName,
    Description,
    CreatedAt
)
VALUES
(1, N'Borrador', N'Proposición recién creada', SYSUTCDATETIME()),
(2, N'En Votación', N'Los jugadores pueden votar', SYSUTCDATETIME()),
(3, N'Pendiente de Aceptación', N'Esperando decisión del jugador objetivo', SYSUTCDATETIME()),
(4, N'Activa', N'Aceptando predicciones', SYSUTCDATETIME()),
(5, N'Cerrada', N'Periodo de predicciones finalizado', SYSUTCDATETIME()),
(6, N'Resuelta', N'Resultado validado y procesado', SYSUTCDATETIME()),
(7, N'Cancelada', N'Proposición cancelada', SYSUTCDATETIME());

SET IDENTITY_INSERT PropositionStatuses OFF;


/* =========================================================
   TIPOS DE PROPOSICIÓN
========================================================= */

SET IDENTITY_INSERT PropositionTypes ON;

INSERT INTO PropositionTypes
(
    TypeId,
    TypeName,
    Description,
    CreatedAt
)
VALUES
(1, N'Propia', N'Creada sobre uno mismo', SYSUTCDATETIME()),
(2, N'Tercero', N'Creada sobre otro jugador', SYSUTCDATETIME());

SET IDENTITY_INSERT PropositionTypes OFF;


/* =========================================================
   REDES SOCIALES
========================================================= */

SET IDENTITY_INSERT SocialPlatforms ON;

INSERT INTO SocialPlatforms
(
    PlatformId,
    PlatformName,
    PlatformUrl,
    IsActive,
    CreatedAt
)
VALUES
(1, N'Instagram', N'https://instagram.com', 1, SYSUTCDATETIME()),
(2, N'TikTok', N'https://tiktok.com', 1, SYSUTCDATETIME()),
(3, N'Facebook', N'https://facebook.com', 1, SYSUTCDATETIME()),
(4, N'X', N'https://x.com', 1, SYSUTCDATETIME()),
(5, N'YouTube', N'https://youtube.com', 1, SYSUTCDATETIME());

SET IDENTITY_INSERT SocialPlatforms OFF;


/* =========================================================
   TIPOS DE BILLETERA
========================================================= */

SET IDENTITY_INSERT WalletTypes ON;

INSERT INTO WalletTypes
(
    WalletTypeId,
    WalletTypeName,
    Description,
    CreatedAt
)
VALUES
(1, N'Puntos', N'Billetera de puntos virtuales', SYSUTCDATETIME()),
(2, N'Dinero Real', N'Billetera monetaria', SYSUTCDATETIME());

SET IDENTITY_INSERT WalletTypes OFF;


/* =========================================================
   TIPOS DE TRANSACCIÓN DE BILLETERA
========================================================= */

SET IDENTITY_INSERT WalletTransactionTypes ON;

INSERT INTO WalletTransactionTypes
(
    WalletTransactionTypeId,
    TransactionTypeName,
    CreatedAt
)
VALUES
(1, N'Depósito', SYSUTCDATETIME()),
(2, N'Retiro', SYSUTCDATETIME()),
(3, N'Apuesta', SYSUTCDATETIME()),
(4, N'Recompensa', SYSUTCDATETIME()),
(5, N'Penalización', SYSUTCDATETIME()),
(6, N'Comisión', SYSUTCDATETIME());

SET IDENTITY_INSERT WalletTransactionTypes OFF;