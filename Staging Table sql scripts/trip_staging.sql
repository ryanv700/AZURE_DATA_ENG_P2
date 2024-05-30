IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacityproj2_udacityproj2_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacityproj2_udacityproj2_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacityproj2@udacityproj2.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.trip_staging (
	[trip_id] nvarchar(4000),
	[rideable_type] nvarchar(4000),
	[start_at] datetime2(0),
	[ended_at] datetime2(0),
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'publictrip.txt',
	DATA_SOURCE = [udacityproj2_udacityproj2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.trip_staging
GO