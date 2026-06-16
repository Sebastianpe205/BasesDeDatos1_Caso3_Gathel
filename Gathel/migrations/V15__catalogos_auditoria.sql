SET IDENTITY_INSERT AuditActions ON;

INSERT INTO AuditActions
(
    AuditActionId,
    ActionName,
    ActionCode,
    Description,
    IsActive,
    CreatedAt
)
VALUES
(1,'Insertar','INSERT','Creación de registros',1,SYSUTCDATETIME()),
(2,'Actualizar','UPDATE','Modificación de registros',1,SYSUTCDATETIME()),
(3,'Eliminar','DELETE','Eliminación de registros',1,SYSUTCDATETIME());

SET IDENTITY_INSERT AuditActions OFF;
GO


SET IDENTITY_INSERT AuditEntities ON;

INSERT INTO AuditEntities
(
    AuditEntityId,
    EntityName,
    EntityCode,
    Description,
    IsActive,
    CreatedAt
)
VALUES
(1,'Proposition','PROPOSITION','Proposiciones',1,SYSUTCDATETIME()),
(2,'Prediction','PREDICTION','Predicciones',1,SYSUTCDATETIME()),
(3,'Wallet','WALLET','Billeteras',1,SYSUTCDATETIME());

SET IDENTITY_INSERT AuditEntities OFF;
GO