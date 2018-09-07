CREATE FUNCTION [dbo].[fnRandomPasswordHash]
(@Password NVARCHAR (15))
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [CLRRandomPasswordGenerator].[RandomPasswordGeneratorCLR.RandomPasswordGenerator].[HashPassword]

