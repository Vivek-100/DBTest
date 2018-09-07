CREATE FUNCTION [dbo].[fnCandidateStageUpdate]
(@CandidateID NVARCHAR (128), @StageID NVARCHAR (128))
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [CLRCandidateStageUpdate].[ApplicantstackStageUpdation.Class1].[UpdateCandidateStage]

