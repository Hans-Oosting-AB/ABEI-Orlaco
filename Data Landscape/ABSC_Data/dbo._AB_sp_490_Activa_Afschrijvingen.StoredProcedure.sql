/****** Object:  StoredProcedure [dbo].[_AB_sp_490_Activa_Afschrijvingen]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		AB, LVE
-- Create date: 2020-11-24
-- Description:	Activa Afschrijvingen
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_490_Activa_Afschrijvingen] 
	-- Add the parameters for the stored procedure here
	@Peildatum datetime = null
	, @Serienummer_van varchar(30) = ''
	, @Serienummer_tot varchar(30) = ''
	, @ValidForPeildatum bit = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Peildatum_year int

	SELECT @Peildatum_year = YEAR(ISNULL(@Peildatum, CURRENT_TIMESTAMP));

	-- List of all mutations for selection
	WITH mutations AS (
		SELECT 
			n.Number as Code
			, n.[Description] as Omschrijving
			, n.[Status] as S
			, CASE n.[Status] 
				WHEN 'A' THEN 'Actief'
				WHEN 'B' THEN 'Geblokkeerd'
				WHEN 'C' THEN 'Afgeschreven'
				WHEN 'D' THEN 'Non-actief'
				--WHEN 'G' THEN 'Niet gevalideerd'
				WHEN 'S' THEN 'Verkocht'
				--WHEN 'T' THEN 'Transfer'
				WHEN 'W' THEN 'Afgeboekt'
				ELSE n.[Status]
				END as S_desc
			, n.DateStart as Aanschaf
			, n.DateEnd as EindDatum
			, n.PurchasePriceLocal as Aanschafwaarde
			, ROUND(fa.percper * 12, 0) AS Afschrijving_Percentage
			, n.UserDate_01 AS verkocht

			, g.reknr
			, gr.oms25_0
			, g.transtype
			, g.transsubtype
			, CASE g.transsubtype 
				WHEN 'V' THEN 'Deprication'
				WHEN 'N' THEN 'Other'
				WHEN 'I' THEN 'Disposal'
				WHEN 'T' THEN 'Purchase Invoice'
				WHEN 'E' THEN 'Revaluation'
				WHEN 'B' THEN 'Fulfillment'
				--ELSE g.transsubtype 
				END as tst_oms
			, g.oms25
			, YEAR(g.datum) as yr
			, g.datum as Boekingsdatum
			, ISNULL(g.Type, 0) as gType
			, CAST(g.bdr_hfl as decimal(16,2)) as bdr_hfl
			, CAST((CASE WHEN g.transsubtype NOT IN ('R','S') THEN CASE WHEN g.bdr_hfl >= 0 THEN g.bdr_hfl ELSE NULL  END	ELSE CASE WHEN g.bdr_hfl < 0 THEN g.bdr_hfl ELSE NULL  END END) as decimal(16,2)) AS Debit
			, CAST((CASE WHEN g.transsubtype NOT IN ('R','S') THEN CASE WHEN g.bdr_hfl >= 0 THEN NULL ELSE -g.bdr_hfl END	ELSE CASE WHEN g.bdr_hfl < 0 THEN NULL ELSE -g.bdr_hfl END END) as decimal(16,2)) AS Credit

			, CAST(CASE WHEN (g.transsubtype = 'V'
					OR (g.transsubtype = 'N' AND g.bdr_hfl < 0)
					OR (g.transsubtype = 'I' AND g.bdr_hfl > 0))
				AND ISNULL(g.Type,0) <> 72
				THEN g.bdr_hfl*-1 ELSE 0 END as decimal(16,2)) as afschrijving
			, CAST(CASE WHEN ISNULL(g.Type,0) = 72
				THEN g.bdr_hfl*-1 ELSE 0 END as decimal(16,2)) as desinvestering

		FROM [490].dbo.ItemNumbers n WITH (NOLOCK) 
			INNER JOIN [490].dbo.gbkmut g WITH (NOLOCK) ON n.Number = g.facode 
			INNER JOIN [490].dbo.grtbk gr WITH (NOLOCK) ON g.reknr = gr.reknr 
			INNER JOIN [490].dbo.fadprm fa WITH (NOLOCK) ON n.PrimaryMethod = fa.deprmeth
		WHERE 1=1
			AND g.regelcode = 'B' -- Transaction in account entry line
			AND gr.omzrek = 'A' -- Asset account
			AND g.transtype IN ('N', 'C', 'P') 

			AND (n.Number >= @Serienummer_van OR @Serienummer_van = '')
			AND (n.Number <= @Serienummer_tot OR @Serienummer_tot = '')

			-- LVE 2021-05-18: only mutations before peildatum
			AND g.datum <= @Peildatum

	)
	-- List of all mutations but split by year
	, m_values AS (
		SELECT m.Code
			, m.Omschrijving
			, m.S_desc as S
			, m.Aanschaf
			, m.EindDatum
			, CASE WHEN DATEPART(YEAR, m.Aanschaf) >= @Peildatum_year THEN NULL ELSE m.Aanschafwaarde END as Aanschafwaarde --  Aanschafwaarde is 0 in het jaar dat het is aangeschaft
			, m.Afschrijving_Percentage

			, @Peildatum_year-1 as Previous_year
			, CASE WHEN m.yr < @Peildatum_year THEN m.afschrijving + m.desinvestering ELSE 0 END as Prev_Afschrijvingen_old
			, CASE WHEN m.yr < @Peildatum_year AND m.transsubtype != 'I' THEN m.Credit ELSE 0 END as Prev_Afschrijvingen -- afboekingen (I) uitsluiten
			, CASE WHEN m.yr < @Peildatum_year THEN m.bdr_hfl ELSE 0 END as Prev_Boekwaarde

			, @Peildatum_year as Current_year
			, CASE WHEN m.transsubtype = 'T' AND m.yr = @Peildatum_year THEN m.bdr_hfl ELSE 0 END as Curr_Investering
			, CASE WHEN m.yr = @Peildatum_year THEN m.afschrijving + m.desinvestering ELSE 0 END as Curr_Afschrijvingen_old
			, CASE WHEN m.yr = @Peildatum_year AND m.transsubtype != 'I' THEN m.Credit ELSE 0 END as Curr_Afschrijvingen -- afboekingen (I) uitsluiten

			, CASE WHEN m.transsubtype != 'I' THEN m.Credit ELSE 0 END as Tot_Afschrijvingen

			, m.bdr_hfl as Boekwaarde

			, CASE WHEN m.S = 'W' THEN m.Einddatum ELSE NULL END as AfgeboektOp -- W = Afgeboekt 
			
			--, CASE WHEN m.transsubtype = 'I' THEN m.Boekingsdatum ELSE NULL END as Disposal -- Type: Disposal
			--, m.Boekingsdatum

		FROM mutations m
	)
	-- Grouped list of all mutations per year
	SELECT m.Code
		, m.Omschrijving
		, m.S
		, m.Aanschaf
		, m.EindDatum
		, m.Aanschafwaarde
		, m.Afschrijving_Percentage
		, m.Previous_year
		, SUM(Prev_Afschrijvingen_old) as Prev_Afschrijvingen_old
		, SUM(Prev_Afschrijvingen) as Prev_Afschrijvingen
		, SUM(Prev_Boekwaarde) as Prev_Boekwaarde

		, m.Current_year
		, SUM(Curr_Investering) as Curr_Investering
		, SUM(Curr_Afschrijvingen_old) as Curr_Afschrijvingen_old
		, SUM(Curr_Afschrijvingen) as Curr_Afschrijvingen

		, CASE WHEN m.AfgeboektOp IS NOT NULL AND YEAR(ISNULL(m.AfgeboektOp, CURRENT_TIMESTAMP)) <= @Peildatum_year THEN 0 ELSE m.Aanschafwaarde END as Aanschafwaarde_vergelijk
		, CASE WHEN m.AfgeboektOp IS NOT NULL AND YEAR(ISNULL(m.AfgeboektOp, CURRENT_TIMESTAMP)) <= @Peildatum_year THEN 0 ELSE SUM(Tot_Afschrijvingen) END as Tot_Afschrijvingen
		, m.Aanschafwaarde - SUM(Tot_Afschrijvingen) as Cummulatief_Boekwaarde
	
		, SUM(Boekwaarde) as Boekwaarde

		--, CASE WHEN MAX(Disposal) = MAX(Boekingsdatum) THEN 1 ELSE 0 END as Sold -- When the disposal transaction is last, then mark as Sold (not used, use status 'Afgeboekt' instead)
	FROM m_values m

	WHERE 1=1
		-- Exclude or include Activa that ended before Peildatum
		AND (@ValidForPeildatum = 0 OR YEAR(ISNULL(m.AfgeboektOp, CURRENT_TIMESTAMP)) >= @Peildatum_year)
	GROUP BY m.Code
		, m.Omschrijving
		, m.S
		, m.Aanschaf
		, m.EindDatum
		, m.Aanschafwaarde
		, m.Afschrijving_Percentage
		, m.Previous_year
		, m.Current_year
		, m.AfgeboektOp
	ORDER BY m.Code
END

GO
