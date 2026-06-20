/*
=================================================
V20 - Encryption con Certificado
=================================================
*/

-------------------------------------------------
-- MASTER KEY
-------------------------------------------------

CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Gathel2026!SecureKey';

-------------------------------------------------
-- CERTIFICADO
-------------------------------------------------

CREATE CERTIFICATE GathelCertificate
WITH SUBJECT = 'Certificado de cifrado Gathel';

-------------------------------------------------
-- CLAVE SIMÉTRICA
-------------------------------------------------

CREATE SYMMETRIC KEY GathelSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE GathelCertificate;