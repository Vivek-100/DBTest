

CREATE FUNCTION [dbo].[ufn_SYS_DataDictionary_ColumnIndexInfo] 
(
	@TBL_Name NVARCHAR(128), @CL_Name NVARCHAR(128)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	
	DECLARE @IX_Info_mem NVARCHAR(MAX)
	DECLARE @IX_Info_Short_chr NVARCHAR(512)
	DECLARE @Table_Name_chr NVARCHAR(128)
	DECLARE @Column_Name_chr NVARCHAR(128)

	SET @IX_Info_mem = NULL

	IF ISNULL(@TBL_Name,'') = '' OR ISNULL(@CL_Name,'') = '' 
		RETURN @IX_Info_mem
	
	DECLARE CL_Cursor CURSOR FOR  
		SELECT 
							CASE 
								WHEN 
									I.is_primary_key = 1 
								THEN
									'PK_'
								ELSE
									CASE 
										WHEN
											I.is_unique_constraint = 1
										THEN	
											'UQK_'
										ELSE
											CASE	
												WHEN
													is_unique = 1
												THEN
													'UIX_'
												ELSE
													'IX_'
											END
									END		
							END
							+ CAST(I.index_id AS NVARCHAR(15)) 
							+ 
							CASE ISNULL(I.filter_definition,'')
								WHEN 
									''
								THEN
									''
								ELSE
									' (WHERE ' + I.filter_definition + ')'
							END AS
						IX_Info_Short,
							o.[name] AS
						Table_Name,
							aic.[name] AS
						Column_Name
		FROM 
						sys.objects o 
							INNER JOIN 
						sys.indexes i 
								ON i.object_id = o.object_id 
							INNER JOIN
						sys.index_columns ic
								ON i.object_id = ic.object_id 
									AND 
								ic.index_id = i.index_id
							INNER JOIN
						sys.all_columns aic
								ON aic.object_id = o.object_id 
									AND  
								aic.column_id = ic.column_id
		WHERE 
						o.[name] = @TBL_Name
							AND
						aic.[name] = @CL_Name
		ORDER BY 
						i.index_id
	
	OPEN CL_Cursor  
	FETCH NEXT FROM CL_Cursor INTO @IX_Info_Short_chr, @Table_Name_chr, @Column_Name_chr  

	WHILE @@FETCH_STATUS = 0  

		BEGIN  
		    
			SET @IX_Info_mem = CASE WHEN ISNULL(@IX_Info_mem,'') = '' THEN ISNULL(@IX_Info_Short_chr,'') ELSE @IX_Info_mem + CHAR(13) + CHAR(10) + ISNULL(@IX_Info_Short_chr,'') END

			FETCH NEXT FROM CL_Cursor INTO @IX_Info_Short_chr, @Table_Name_chr, @Column_Name_chr   

		END  

	CLOSE CL_Cursor  
	DEALLOCATE CL_Cursor 
	
	RETURN @IX_Info_mem

END










