/* =========================================================
   IDIOMAS
========================================================= */

SET IDENTITY_INSERT Languages ON;

INSERT INTO Languages
(
    LanguageId,
    LanguageCode,
    LanguageName,
    CreatedAt
)
VALUES
(1, N'es', N'Español', SYSUTCDATETIME()),
(2, N'en', N'English', SYSUTCDATETIME()),
(3, N'pt', N'Português', SYSUTCDATETIME()),
(4, N'fr', N'Français', SYSUTCDATETIME());

SET IDENTITY_INSERT Languages OFF;


/* =========================================================
   FORMATOS DE BALANCE
========================================================= */

SET IDENTITY_INSERT WalletBalanceFormats ON;

INSERT INTO WalletBalanceFormats
(
    WalletBalanceFormatId,
    BalanceFormatName,
    CreatedAt
)
VALUES
(1, N'Puntos', SYSUTCDATETIME()),
(2, N'Moneda', SYSUTCDATETIME());

SET IDENTITY_INSERT WalletBalanceFormats OFF;