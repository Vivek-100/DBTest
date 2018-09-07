

CREATE function [dbo].[ufn_SYS_List_To_Table_NVARCHAR] (@List_Delim_mem nvarchar(4000))
RETURNS @TBL_tbl TABLE (ID_chr NVARCHAR(500) NOT NULL)

BEGIN
	
	DECLARE @Chr_POS_1_int INT
	DECLARE @Chr_POS_2_int INT
	DECLARE @Chr_POS_3_int INT

	SET @Chr_POS_1_int = 0
	SET @Chr_POS_2_int = ISNULL(CHARINDEX(',', @List_Delim_mem, @Chr_POS_1_int), 0) 
	
	IF ISNULL(@Chr_POS_2_int, 0) = 0 
	BEGIN
		INSERT INTO @TBL_tbl (ID_chr) VALUES ('') 
		RETURN
	END
	
	WHILE @Chr_POS_2_int > 0
	BEGIN
		INSERT INTO @TBL_tbl (ID_chr) VALUES (SUBSTRING(@List_Delim_mem, @Chr_POS_1_int + 1, @Chr_POS_2_int - @Chr_POS_1_int - 1)) 
		SET @Chr_POS_1_int = @Chr_POS_2_int
		SET @Chr_POS_3_int = @Chr_POS_2_int
		SET @Chr_POS_2_int = ISNULL(CHARINDEX(',', @List_Delim_mem, @Chr_POS_1_int + 1), 0) 
	END

	INSERT INTO @TBL_tbl (ID_chr) values (SUBSTRING(@List_Delim_mem, @Chr_POS_3_int + 1, 4000)) 

	RETURN

END



