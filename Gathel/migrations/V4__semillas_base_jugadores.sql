/* =========================================================
   PAÍSES
========================================================= */

SET IDENTITY_INSERT Countries ON;

INSERT INTO Countries
(
    CountryId,
    CountryName,
    Iso2Code,
    Iso3Code,
    PhoneCode,
    TimeZone,
    IsActive,
    CreatedAt
)
VALUES
(1, N'Costa Rica', 'CR', 'CRI', '+506', N'America/Costa_Rica', 1, SYSUTCDATETIME()),
(2, N'México', 'MX', 'MEX', '+52', N'America/Mexico_City', 1, SYSUTCDATETIME()),
(3, N'Colombia', 'CO', 'COL', '+57', N'America/Bogota', 1, SYSUTCDATETIME()),
(4, N'Argentina', 'AR', 'ARG', '+54', N'America/Argentina/Buenos_Aires', 1, SYSUTCDATETIME()),
(5, N'España', 'ES', 'ESP', '+34', N'Europe/Madrid', 1, SYSUTCDATETIME()),
(6, N'Estados Unidos', 'US', 'USA', '+1', N'America/New_York', 1, SYSUTCDATETIME()),
(7, N'Guatemala', 'GT', 'GTM', '+502', N'America/Guatemala', 1, SYSUTCDATETIME()),
(8, N'Panamá', 'PA', 'PAN', '+507', N'America/Panama', 1, SYSUTCDATETIME()),
(9, N'Chile', 'CL', 'CHL', '+56', N'America/Santiago', 1, SYSUTCDATETIME()),
(10, N'Perú', 'PE', 'PER', '+51', N'America/Lima', 1, SYSUTCDATETIME());

SET IDENTITY_INSERT Countries OFF;


/* =========================================================
   MONEDAS
========================================================= */

SET IDENTITY_INSERT Currencies ON;

INSERT INTO Currencies
(
    CurrencyId,
    CurrencyCode,
    CurrencyName,
    CreatedAt
)
VALUES
(1, N'PTS', N'Puntos Gathel', SYSUTCDATETIME()),
(2, N'CRC', N'Colón Costarricense', SYSUTCDATETIME()),
(3, N'USD', N'Dólar Estadounidense', SYSUTCDATETIME()),
(4, N'EUR', N'Euro', SYSUTCDATETIME()),
(5, N'MXN', N'Peso Mexicano', SYSUTCDATETIME()),
(6, N'COP', N'Peso Colombiano', SYSUTCDATETIME()),
(7, N'ARS', N'Peso Argentino', SYSUTCDATETIME()),
(8, N'CLP', N'Peso Chileno', SYSUTCDATETIME()),
(9, N'PAB', N'Balboa Panameño', SYSUTCDATETIME()),
(10, N'PEN', N'Sol Peruano', SYSUTCDATETIME());

SET IDENTITY_INSERT Currencies OFF;