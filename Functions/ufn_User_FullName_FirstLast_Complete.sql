
CREATE FUNCTION [dbo].[ufn_User_FullName_FirstLast_Complete]
(
	@UserID_ids nvarchar(128) 
)
RETURNS NVARCHAR(256)
AS
BEGIN

	DECLARE @User_FullName NVARCHAR(256)

	SET @User_FullName = NULL

	IF ISNULL(@UserID_ids, '') = ''
			RETURN NULL

	SELECT 
					@User_FullName = 
							LTRIM(RTRIM(LTRIM(RTRIM(ISNULL(FirstName_chr ,''))) + ' ' +
							LTRIM(RTRIM(LTRIM(RTRIM(ISNULL(MiddleName_chr,'') + ' ' + ISNULL(LastName_chr,''))) + ' ' + 
							LTRIM(RTRIM(ISNULL(PostNominal_chr,''))))))) 
	FROM
					tblAssociate
	WHERE
					UserID_ids = @UserID_ids
	
	IF ISNULL(@User_FullName, '') = ''
			SET @User_FullName = NULL

	RETURN @User_FullName

END








