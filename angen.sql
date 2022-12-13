IF OBJECT_ID('angen') IS NOT NULL DROP FUNCTION angen
GO

CREATE FUNCTION angen()
RETURNS NVARCHAR(MAX)
AS
BEGIN
  DECLARE
    @delimiters NVARCHAR(MAX) = ' _|,;:.!?~@#$%^&+-*=/',
    @delimiters_max INT = 16,
    @delimiters_idx INT,
    @delimiter NVARCHAR(1)

  SELECT @delimiters_idx = ROUND(@delimiters_max * RandomValue, 0)
  FROM AngenRandom

  SET @delimiter = SUBSTRING(@delimiters, @delimiters_idx + 1, 1)

  DECLARE
    @adjectives_max INT,
    @adjectives_idx INT,
    @adjective NVARCHAR(MAX)

  SELECT @adjectives_max = COUNT(*) - 1
  FROM AngenAdjectives

  SELECT @adjectives_idx = ROUND(@adjectives_max * RandomValue, 0)
  FROM AngenRandom

  SELECT @adjective = AdjectiveValue
  FROM AngenAdjectives
  ORDER BY AdjectiveValue OFFSET @adjectives_idx ROWS FETCH NEXT 1 ROWS ONLY

  DECLARE
    @names_max INT,
    @names_idx INT,
    @name NVARCHAR(MAX)

  SELECT @names_max = COUNT(*) - 1
  FROM AngenNames

  SELECT @names_idx = ROUND(@names_max * RandomValue, 0)
  FROM AngenRandom

  SELECT @name = NameValue
  FROM AngenNames
  ORDER BY NameValue OFFSET @names_idx ROWS FETCH NEXT 1 ROWS ONLY

  DECLARE
    @number NVARCHAR(MAX)

  SELECT @number = RIGHT('000' + CAST(ROUND(999 * RandomValue, 0) AS NVARCHAR(MAX)), 3)
  FROM AngenRandom

  DECLARE
    @result NVARCHAR(MAX)

  SET @result = @adjective + @delimiter + @name + @delimiter + @number

  RETURN @result
END
GO
