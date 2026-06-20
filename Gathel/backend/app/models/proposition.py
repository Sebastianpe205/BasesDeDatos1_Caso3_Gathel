"""
Modelos ORM de solo lectura para el dominio de proposiciones.
Tablas: Propositions, PropositionGroups, PropositionStatuses, PropositionResults.

Nota sobre la dependencia circular: PropositionGroups.WinningPropositionId
apunta a Propositions.PropositionId, y Propositions.EventGroupId apunta a
PropositionGroups.EventGroupId (la misma circularidad que se resolvio en
el DDL con ALTER TABLE). Para mantener los modelos simples y evitar
relationships() ambiguos entre las mismas dos tablas, NO se define aqui
una coleccion inversa PropositionGroup.propositions ni
PropositionGroup.winning_proposition como objetos ORM. Si se necesitan,
se pueden consultar directamente, ej:
    db.query(Proposition).filter(Proposition.EventGroupId == group_id).all()
"""
from datetime import datetime
from decimal import Decimal

from sqlalchemy import BigInteger, Boolean, DateTime, ForeignKey, Numeric, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base


class PropositionStatus(Base):
    __tablename__ = "PropositionStatuses"

    StatusId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    StatusName: Mapped[str] = mapped_column(String(50))
    Description: Mapped[str | None] = mapped_column(String(255), nullable=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)


class PropositionGroup(Base):
    __tablename__ = "PropositionGroups"

    EventGroupId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    TargetPlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    FirstPropositionCreatedAt: Mapped[datetime] = mapped_column(DateTime)
    VotingDeadline: Mapped[datetime] = mapped_column(DateTime)
    WinningPropositionId: Mapped[int | None] = mapped_column(BigInteger, nullable=True)
    IsVotingClosed: Mapped[bool] = mapped_column(Boolean, default=False)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    target_player: Mapped["Player"] = relationship("Player", foreign_keys=[TargetPlayerId])


class Proposition(Base):
    __tablename__ = "Propositions"

    PropositionId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    CreatedByPlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    TargetPlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    StatusId: Mapped[int] = mapped_column(BigInteger, ForeignKey("PropositionStatuses.StatusId"))
    TypeId: Mapped[int] = mapped_column(BigInteger)
    AIValidationStatusId: Mapped[int] = mapped_column(BigInteger)
    EventGroupId: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("PropositionGroups.EventGroupId")
    )
    Title: Mapped[str] = mapped_column(String(200))
    Description: Mapped[str | None] = mapped_column(String(2000), nullable=True)
    EventDate: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    PredictionCloseDate: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    ResolutionDate: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    IsPublic: Mapped[bool] = mapped_column(Boolean, default=True)
    RequiresMoneyPrediction: Mapped[bool] = mapped_column(Boolean, default=False)
    RequiresPointPrediction: Mapped[bool] = mapped_column(Boolean, default=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    DeletedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    status: Mapped["PropositionStatus"] = relationship("PropositionStatus", lazy="joined")
    event_group: Mapped["PropositionGroup"] = relationship(
        "PropositionGroup", foreign_keys=[EventGroupId]
    )
    result: Mapped["PropositionResult"] = relationship(
        "PropositionResult", back_populates="proposition", uselist=False
    )


class PropositionResult(Base):
    __tablename__ = "PropositionResults"

    ResultId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PropositionId: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("Propositions.PropositionId")
    )
    WinningPredictionOptionId: Mapped[int] = mapped_column(BigInteger)
    WasSuccessful: Mapped[bool] = mapped_column(Boolean)
    AIConfidenceScore: Mapped[Decimal | None] = mapped_column(Numeric(5, 2), nullable=True)
    ManualReviewRequired: Mapped[bool] = mapped_column(Boolean, default=False)
    ResolutionSummary: Mapped[str | None] = mapped_column(String(1000), nullable=True)
    ResolvedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)

    proposition: Mapped["Proposition"] = relationship("Proposition", back_populates="result")


from app.models.player import Player  # noqa: E402,F401
