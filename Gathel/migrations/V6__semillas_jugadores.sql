/* =========================================================
   GENERAR 1000 JUGADORES
========================================================= */

DECLARE @i INT = 1;

WHILE @i <= 1000
BEGIN

    INSERT INTO Players
    (
        Username,
        Email,
        DisplayName,
        CountryId,
        IsVerified,
        IsActive,
        CreatedAt
    )
    VALUES
    (
        CONCAT('jugador', @i),
        CONCAT('jugador', @i, '@gathel.com'),
        CONCAT('Jugador ', @i),
        1,
        1,
        1,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, SYSUTCDATETIME())
    );

    DECLARE @PlayerId BIGINT = SCOPE_IDENTITY();

    /* ==========================================
       PERFIL
    ========================================== */

    INSERT INTO PlayerProfiles
    (
        PlayerId,
        Biography,
        ProfilePictureUrl,
        BirthDate,
        GenderId,
        PreferredLanguageId,
        CreatedAt
    )
    VALUES
    (
        @PlayerId,
        CONCAT('Biografía del jugador ', @i),
        CONCAT('https://gathel.com/profiles/', @PlayerId, '.jpg'),
        DATEADD(YEAR, -(18 + ABS(CHECKSUM(NEWID())) % 30), CAST(GETDATE() AS DATE)),
        ((ABS(CHECKSUM(NEWID())) % 4) + 1),
        1,
        SYSUTCDATETIME()
    );

    /* ==========================================
       CREDENCIALES
    ========================================== */

    INSERT INTO AuthenticationCredentials
    (
        PlayerId,
        PasswordHash,
        PasswordSalt,
        LastLoginAt,
        IsTemporaryPassword,
        IsBlocked,
        IsActive
    )
    VALUES
    (
        @PlayerId,
        CONCAT('HASH_', @PlayerId),
        CONCAT('SALT_', @PlayerId),
        SYSUTCDATETIME(),
        0,
        0,
        1
    );

    /* ==========================================
       ROL JUGADOR
    ========================================== */

    INSERT INTO PlayerRoles
    (
        PlayerId,
        RoleId,
        AssignedAt,
        AssignedByPlayerId
    )
    VALUES
    (
        @PlayerId,
        1,
        SYSUTCDATETIME(),
        NULL
    );

    /* ==========================================
       WALLET DE PUNTOS
    ========================================== */

    INSERT INTO Wallets
    (
        PlayerId,
        WalletTypeId,
        CurrencyId,
        CurrentBalance,
        IsBlocked,
        IsActive,
        CreatedAt
    )
    VALUES
    (
        @PlayerId,
        1,
        1,
        100,
        0,
        1,
        SYSUTCDATETIME()
    );

    /* ==========================================
       WALLET DE DINERO
    ========================================== */

    INSERT INTO Wallets
    (
        PlayerId,
        WalletTypeId,
        CurrencyId,
        CurrentBalance,
        IsBlocked,
        IsActive,
        CreatedAt
    )
    VALUES
    (
        @PlayerId,
        2,
        3,
        CAST((ABS(CHECKSUM(NEWID())) % 5000) AS DECIMAL(19,4)),
        0,
        1,
        SYSUTCDATETIME()
    );

    /* ==========================================
       INSTAGRAM
    ========================================== */

    INSERT INTO PlayerSocialAccounts
    (
        PlayerId,
        PlatformId,
        SocialUsername,
        SocialProfileUrl,
        AccessToken,
        RefreshToken,
        IsVerified,
        ConnectedAt,
        LastSyncAt
    )
    VALUES
    (
        @PlayerId,
        1,
        CONCAT('insta_jugador_', @i),
        CONCAT('https://instagram.com/insta_jugador_', @i),
        CONCAT('ACCESS_', @PlayerId),
        CONCAT('REFRESH_', @PlayerId),
        1,
        SYSUTCDATETIME(),
        SYSUTCDATETIME()
    );

    SET @i += 1;

END;