CREATE SCHEMA [Portfolio]
GO

CREATE TABLE [Portfolio].[Benchmark](
	[Number] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[ReturnSeriesId] [int] NULL,
 CONSTRAINT [PK_Portfolio_Benchmark] PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Portfolio].[Portfolio]    Script Date: 4/15/2017 7:37:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Portfolio].[Portfolio](
	[Number] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[InceptionDate] [datetime] NOT NULL,
	[CloseDate] [datetime] NULL,
	[NetReturnSeriesId] [int] NULL,
	[GrossReturnSeriesId] [int] NULL,
 CONSTRAINT [PK_Portfolio_Portfolio] PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Portfolio].[PortfolioToBenchmark]    Script Date: 4/15/2017 7:37:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Portfolio].[PortfolioToBenchmark](
	[PortfolioNumber] [int] NOT NULL,
	[BenchmarkNumber] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_Portfolio_PortfolioToBenchmark] PRIMARY KEY CLUSTERED 
(
	[PortfolioNumber] ASC,
	[BenchmarkNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Portfolio].[PortfolioToBenchmark]  WITH CHECK ADD  CONSTRAINT [FK_PortfolioToBenchmark_Benchmark] FOREIGN KEY([BenchmarkNumber])
REFERENCES [Portfolio].[Benchmark] ([Number])
GO
ALTER TABLE [Portfolio].[PortfolioToBenchmark] CHECK CONSTRAINT [FK_PortfolioToBenchmark_Benchmark]
GO
ALTER TABLE [Portfolio].[PortfolioToBenchmark]  WITH CHECK ADD  CONSTRAINT [FK_PortfolioToBenchmark_Portfolio] FOREIGN KEY([PortfolioNumber])
REFERENCES [Portfolio].[Portfolio] ([Number])
GO
ALTER TABLE [Portfolio].[PortfolioToBenchmark] CHECK CONSTRAINT [FK_PortfolioToBenchmark_Portfolio]
GO

CREATE SCHEMA [Performance]

GO

CREATE TABLE [Performance].[MonthlyReturn](
	[ReturnSeriesId] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[ReturnValue] [decimal](18, 8) NOT NULL,
 CONSTRAINT [PK_Performance_MonthlyReturn] PRIMARY KEY CLUSTERED 
(
	[ReturnSeriesId] ASC,
	[Year] ASC,
	[Month] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [Performance].[ReturnSeries](
	[ReturnSeriesId] [int] IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(64) NOT NULL,
	[Disclosure] NVARCHAR(MAX) NOT NULL,
 CONSTRAINT [PK_Performance_ReturnSeries] PRIMARY KEY CLUSTERED 
(
	[ReturnSeriesId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [Performance].[MonthlyReturn]  WITH CHECK ADD  CONSTRAINT [FK_Performance_MonthlyReturn_ReturnSeries] FOREIGN KEY([ReturnSeriesId])
REFERENCES [Performance].[ReturnSeries] ([ReturnSeriesId])
GO

ALTER TABLE [Performance].[MonthlyReturn] CHECK CONSTRAINT [FK_Performance_MonthlyReturn_ReturnSeries]
GO
