SET IDENTITY_INSERT AIValidationStatuses ON;

INSERT INTO AIValidationStatuses
(
    AIValidationStatusId,
    AIValidationStatusName,
    CreatedAt
)
VALUES
(1, N'Pendiente', SYSUTCDATETIME()),
(2, N'Aprobada', SYSUTCDATETIME()),
(3, N'Rechazada', SYSUTCDATETIME()),
(4, N'Requiere Revisión Manual', SYSUTCDATETIME());

SET IDENTITY_INSERT AIValidationStatuses OFF;