/*
=================================================
V21 - Semilla financiera
=================================================
*/

-------------------------------------------------
-- TIPOS DE MOVIMIENTO FINANCIERO
-------------------------------------------------

INSERT INTO FinancialMovementTypes
(
    MovementTypeName,
    CreatedAt
)
VALUES
('Deposito', GETDATE()),
('Retiro', GETDATE()),
('Compra de Puntos', GETDATE()),
('Premio', GETDATE()),
('Comision', GETDATE());

-------------------------------------------------
-- COMPRA DE PUNTOS
-------------------------------------------------

INSERT INTO PointPurchases
(
    PlayerId,
    WalletId,
    PaymentMethodId,
    PaymentStatusId,
    CurrencyId,
    PointsAmount,
    AmountPaid,
    ExternalReference,
    PurchaseDate,
    CreatedAt,
    Checksum
)
VALUES
(
    2,
    4,
    1,
    1,
    3,
    500,
    5.00,
    'PUR-001',
    GETDATE(),
    GETDATE(),
    NULL
);

-------------------------------------------------
-- MOVIMIENTO FINANCIERO
-------------------------------------------------

INSERT INTO FinancialMovements
(
    PlayerId,
    WalletId,
    PaymentMethodId,
    PaymentStatusId,
    CurrencyId,
    FinancialMovementTypeId,
    Amount,
    CommissionAmount,
    ExternalReference,
    GatewayResponse,
    ObjectSource,
    ReferenceId,
    MovementDate,
    ProcessedByPlayerId,
    Checksum
)
VALUES
(
    2,
    4,
    1,
    1,
    3,
    3,
    5.00,
    0.25,
    'PUR-001',
    'APPROVED',
    'PointPurchase',
    1,
    GETDATE(),
    2,
    NULL
);

-------------------------------------------------
-- TRANSACCION DE BILLETERA
-------------------------------------------------

INSERT INTO WalletTransactions
(
    WalletId,
    WalletTransactionTypeId,
    WalletBalanceFormatId,
    Amount,
    PreviousBalance,
    NewBalance,
    Reference,
    ObjectSource,
    ReferenceId,
    Description,
    TransactionDate,
    CreatedByPlayerId,
    Checksum
)
VALUES
(
    4,
    1,
    1,
    500,
    3811,
    4311,
    'PUR-001',
    'PointPurchase',
    1,
    'Compra inicial de puntos',
    GETDATE(),
    2,
    NULL
);