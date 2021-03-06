/****** Object:  StoredProcedure [dbo].[GetUnprocessedSectorTimes]    Script Date: 10/22/2008 07:43:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUnprocessedSectorTimes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetUnprocessedSectorTimes]
GO
/****** Object:  StoredProcedure [dbo].[UpdateProcessedSectorTime]    Script Date: 10/22/2008 07:43:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProcessedSectorTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProcessedSectorTime]
GO
/****** Object:  StoredProcedure [dbo].[GetUnprocessedSectorTimes]    Script Date: 10/22/2008 07:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUnprocessedSectorTimes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUnprocessedSectorTimes]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		RaceId, 
		AthleteId, 
		SectorId , 
		Duration , 
		Processed 
	FROM SectorTimes
	WHERE processed = 0
	FOR XML PATH (''''), ELEMENTS;

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateProcessedSectorTime]    Script Date: 10/22/2008 07:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProcessedSectorTime]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateProcessedSectorTime]
	@RaceId int,
	@AthleteId int,
	@SectorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE SectorTimes
	SET Processed = 1
	WHERE RaceId = @RaceId
		AND AthleteId = @AthleteId
		AND SectorId = @SectorId
		AND Processed = 0;

END
' 
END
GO
