/*
=================================================
V18 - Dynamic Data Masking
=================================================
*/

-------------------------------------------------
-- EMAIL DE JUGADORES
-------------------------------------------------

ALTER TABLE dbo.Players
ALTER COLUMN Email
ADD MASKED WITH (FUNCTION = 'email()');

-------------------------------------------------
-- USERNAME DE JUGADORES
-------------------------------------------------

ALTER TABLE dbo.Players
ALTER COLUMN Username
ADD MASKED WITH (FUNCTION = 'partial(2,"****",2)');

-------------------------------------------------
-- EMAIL DE AFILIADOS
-------------------------------------------------

ALTER TABLE dbo.AffiliatePartners
ALTER COLUMN ContactEmail
ADD MASKED WITH (FUNCTION = 'email()');