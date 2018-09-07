CREATE FUNCTION [dbo].[fnRandomPassword]
(@MinLength INT, @MaxLength INT)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [CLRRandomPasswordGenerator].[RandomPasswordGeneratorCLR.RandomPasswordGenerator].[GenerateMinMax]

