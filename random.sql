IF OBJECT_ID('AngenRandom') IS NOT NULL DROP VIEW AngenRandom
GO

CREATE VIEW AngenRandom
AS
  SELECT RAND() RandomValue
GO
