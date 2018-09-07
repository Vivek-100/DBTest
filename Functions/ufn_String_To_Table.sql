CREATE FUNCTION [dbo].[ufn_String_To_Table] ( @StringInput NVARCHAR(MAX), @Delimiter nvarchar(1))
RETURNS @OutputTable TABLE ( [String] NVARCHAR(128) )
AS
BEGIN

    DECLARE @String    NVARCHAR(128)

    WHILE LEN(@StringInput) > 0
    BEGIN
        SET @String      = LEFT(@StringInput, 
                                ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput) - 1, -1),
                                LEN(@StringInput)))
        SET @StringInput = SUBSTRING(@StringInput,
                                     ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput), 0),
                                     LEN(@StringInput)) + 1, LEN(@StringInput))

        INSERT INTO @OutputTable ( [String] )
        VALUES ( @String )
    END

    RETURN
END
