IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'dim_activities'))
BEGIN 
  CREATE TABLE [dim_activities] (
  [activity-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [version] [int],
  [date_from] [datetime],
  [date_to] [datetime],
  [activity-identifier] [varchar](MAX),
  [title] [varchar](MAX) CONSTRAINT [DF_dim_activities_title] DEFAULT 'N/A',
  [description] [varchar](MAX) CONSTRAINT [DF_dim_activities_description] DEFAULT 'N/A',
  [activity-status] [varchar](MAX),
  [organisation-id] [varchar](MAX),
  [planned-start] [datetime],
  [planned-end] [datetime],
  [actual-start] [datetime],
  [actual-end] [datetime],
  [hierarchy] [varchar](MAX) CONSTRAINT [DF_dim_activities_hierarchy] DEFAULT 'project',
  [parent-identifier] [varchar](MAX),
  [programme-identifier] [varchar](MAX),
  [programme-title] [varchar](MAX),
  [last-update] [datetime],
  CONSTRAINT [dim_activities_pk] PRIMARY KEY ([activity-id]));
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'dim_countries'))
BEGIN 
  CREATE TABLE [dim_countries] (
  [country-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [version] [int],
  [date_from] [datetime],
  [date_to] [datetime],
  [country-code] [varchar](MAX),
  [oecd-dac-code] [varchar](MAX),
  [region-name-bz] [varchar](MAX),
  [un-ldc] [varchar](MAX),
  [income-class] [varchar](MAX),
  [fragile-state] [varchar](MAX),
  [country-name] [varchar](MAX),
  [oecd-dac-geography] [varchar](MAX),
  [Geography] [varchar](MAX),
  [Region - DAC Region] [varchar](MAX),
  [Region - Country] [varchar](MAX),
  CONSTRAINT [dim_countries_pk] PRIMARY KEY ([country-id]));

END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'dim_date'))
BEGIN 
  CREATE TABLE [dim_date] (
  [date_id] [date] NOT NULL,
  [date] [datetime],
  [year] [int],
  [year_for_week] [int],
  [year_for_week_iso8601] [int],
  [quarter] [int],
  [month] [int],
  [week_of_year] [int],
  [week_of_year_iso8601] [int],
  [week_of_month] [int],
  [week_of_month_iso8601] [int],
  [weekday_in_month] [int],
  [day] [int],
  [day_of_year] [int],
  [day_of_week] [int],
  [date_iso] [varchar](MAX),
  [days_in_month] [int],
  [days_in_year] [int],
  [days_in_year_for_week] [int],
  [days_in_year_for_week_iso8601] [int],
  [days_in_quarter] [int],
  [is_leap_year] [int],
  [is_leap_year_for_week] [int],
  [is_leap_year_for_week_iso8601] [int],
  [is_weekend] [int],
  [is_holiday] [int],
  [holiday_name] [varchar](MAX),
  [is_working_day] [int],
  [day_of_week_long_label_eng] [varchar](MAX),
  [day_of_week_short_label_eng] [varchar](MAX),
  [month_long_label_eng] [varchar](MAX),
  [month_short_label_eng] [varchar](MAX),
  CONSTRAINT [dim_date_pk] PRIMARY KEY ([date_id]));
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'dim_organisations'))
BEGIN 
  CREATE TABLE [dim_organisations] (
  [organisation-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [version] [int],
  [date_from] [datetime],
  [date_to] [datetime],
  [organisation-identifier] [varchar](MAX),
  [name] [varchar](MAX) CONSTRAINT [DF_dim_organisations_name] DEFAULT 'N/A',
  [type] [varchar](MAX) CONSTRAINT [DF_dim_organisations_type] DEFAULT 'N/A',
  CONSTRAINT [dim_organisations_pk] PRIMARY KEY ([organisation-id]));
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'dim_indicators'))
BEGIN 
  CREATE TABLE [dim_indicators] (
  [indicator-id] [bigint] IDENTITY (0, 1) NOT NULL,
  [version] [int],
  [date_from] [datetime],
  [date_to] [datetime],
  [indicator-measure] [varchar](MAX),
  [indicator-title] [varchar](MAX),
  [indicator-reference-code] [varchar](MAX),
  [indicator-reference-title] [varchar](MAX),
  [level-needs-improvement] [NUMERIC](5, 0),
  [level-satisfactory] [NUMERIC](5, 0),
  [level-good] [NUMERIC](5, 0),
  [level-very-good] [NUMERIC](5, 0),
  [level-maximum] [NUMERIC](5, 0),
  [level-minimum] [NUMERIC](5, 0),
  CONSTRAINT [dim_indicators_pk] PRIMARY KEY ([indicator-id]));
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'dim_results'))
BEGIN 
  CREATE TABLE [dim_results] (
  [result-id] [bigint] IDENTITY (0, 1) NOT NULL,
  [version] [int],
  [date_from] [datetime],
  [date_to] [datetime],
  [result-type] [varchar](MAX),
  [aggregation-status] [varchar](MAX),
  [result-title] [varchar](MAX),
  [result-reference-code] [varchar](MAX),
  [result-reference-vocabulary] [varchar](MAX),
  CONSTRAINT [dim_results_pk] PRIMARY KEY ([result-id]));
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'fct_budgets'))
BEGIN 
  CREATE TABLE [fct_budgets] (
  [budgetline-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [activity-identifier] [varchar](MAX),
  [period-start] [date],
  [period-end] [date],
  [budget-type] [varchar](MAX),
  [budget] [NUMERIC](17, 3) CONSTRAINT [DF_fct_budgets_budget] DEFAULT 0 NOT NULL,
  [value-date] [date],
  [currency] [varchar](MAX),
  [activity-id] [bigint],
  [organisation-id] [bigint],
  [country-id] [bigint],
  [country-percentage] [NUMERIC](9, 6) CONSTRAINT [DF_fct_budgets_country-percentage] DEFAULT 100,
  CONSTRAINT [fct_budgets_pk] PRIMARY KEY ([budgetline-id]));

  ALTER TABLE [fct_budgets] ADD CONSTRAINT [fct_budgets_dim_activities_fk] 
  FOREIGN KEY ([activity-id]) REFERENCES [dim_activities] ([activity-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;

  ALTER TABLE [fct_budgets] ADD CONSTRAINT [fct_budgets_dim_countries_fk] 
  FOREIGN KEY ([country-id]) REFERENCES [dim_countries] ([country-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_budgets] ADD CONSTRAINT [fct_budgets_dim_date_end_fk] 
  FOREIGN KEY ([period-end]) REFERENCES [dim_date] ([date_id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_budgets] ADD CONSTRAINT [fct_budgets_dim_date_start_fk] 
  FOREIGN KEY ([period-start]) REFERENCES [dim_date] ([date_id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_budgets] ADD CONSTRAINT [fct_budgets_dim_organisations_fk] 
  FOREIGN KEY ([organisation-id]) REFERENCES [dim_organisations] ([organisation-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'fct_countries_regions'))
BEGIN 
  CREATE TABLE [fct_countries_regions] (
  [country-region-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [country-id] [bigint] NOT NULL,
  [activity-id] [bigint] NOT NULL,
  [activity-identifier] [varchar](MAX),
  [organisation-id] [bigint] NOT NULL,
  [percentage] [NUMERIC](9, 6),
  CONSTRAINT [fct_countries_regions_pk] PRIMARY KEY ([country-region-id]));

  ALTER TABLE [fct_countries_regions] ADD CONSTRAINT [fct_countries_regions_dim_activities_fk] 
  FOREIGN KEY ([activity-id]) REFERENCES [dim_activities] ([activity-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;

  ALTER TABLE [fct_countries_regions] ADD CONSTRAINT [fct_countries_regions_dim_countries_fk] 
  FOREIGN KEY ([country-id]) REFERENCES [dim_countries] ([country-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_countries_regions] ADD CONSTRAINT [fct_countries_regions_dim_organisations_fk] 
  FOREIGN KEY ([organisation-id]) REFERENCES [dim_organisations] ([organisation-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'fct_baselines'))
BEGIN 
  CREATE TABLE [fct_baselines] (
  [baseline-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [activity-identifier] [varchar](MAX),
  [activity-id] [bigint] NOT NULL,
  [organisation-id] [bigint] NOT NULL,
  [result-id] [bigint] NOT NULL,
  [indicator-id] [bigint] NOT NULL,
  [baseline-year] [bigint],
  [baseline-value] [NUMERIC](18,6),
  [baseline-comment] [varchar](MAX),
  CONSTRAINT [fct_baselines_pk] PRIMARY KEY ([baseline-id]));

  ALTER TABLE [fct_baselines] ADD CONSTRAINT [fct_baselines_dim_activities_fk] 
  FOREIGN KEY ([activity-id]) REFERENCES [dim_activities] ([activity-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;

  ALTER TABLE [fct_baselines] ADD CONSTRAINT [fct_baselines_dim_organisations_fk] 
  FOREIGN KEY ([organisation-id]) REFERENCES [dim_organisations] ([organisation-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_baselines] ADD CONSTRAINT [fct_baselines_dim_indicators_fk] 
  FOREIGN KEY ([indicator-id]) REFERENCES [dim_indicators] ([indicator-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_baselines] ADD CONSTRAINT [fct_baselines_dim_results_fk] 
  FOREIGN KEY ([result-id]) REFERENCES [dim_results] ([result-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'fct_results'))
BEGIN 
  CREATE TABLE [fct_results] (
  [resultline-id] [bigint] IDENTITY (1, 1) NOT NULL,
  [activity-identifier] [varchar](MAX),
  [activity-id] [bigint] NOT NULL,
  [organisation-id] [bigint] NOT NULL,
  [result-id] [bigint] NOT NULL,
  [indicator-id] [bigint] NOT NULL,
  [period-start] [date],
  [period-end] [date],
  [target-value] [NUMERIC](18,6),
  [actual-value] [NUMERIC](18,6),
  [target-comment] [varchar](MAX),
  [actual-comment] [varchar](MAX),
  CONSTRAINT [fct_results_pk] PRIMARY KEY ([resultline-id]));

  ALTER TABLE [fct_results] ADD CONSTRAINT [fct_results_dim_activities_fk] 
  FOREIGN KEY ([activity-id]) REFERENCES [dim_activities] ([activity-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;

  ALTER TABLE [fct_results] ADD CONSTRAINT [fct_results_dim_organisations_fk] 
  FOREIGN KEY ([organisation-id]) REFERENCES [dim_organisations] ([organisation-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_results] ADD CONSTRAINT [fct_results_dim_indicators_fk] 
  FOREIGN KEY ([indicator-id]) REFERENCES [dim_indicators] ([indicator-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_results] ADD CONSTRAINT [fct_results_dim_results_fk] 
  FOREIGN KEY ([result-id]) REFERENCES [dim_results] ([result-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'fct_transactions'))
BEGIN 
  CREATE TABLE [fct_transactions] (
  [activity-identifier] [varchar](MAX), [date] [date],
  [type] [varchar](MAX),
  [value] [NUMERIC](17, 3) CONSTRAINT [DF_fct_transactions_value] DEFAULT 0 NOT NULL,
  [value-date] [date],
  [currency] [varchar](MAX),
  [activity-id] [bigint],
  [organisation-id] [bigint],
  [provider-organisation-id] [bigint],
  [provider-activity-id] [bigint],
  [receiver-organisation-id] [bigint],
  [receiver-activity-id] [bigint],
  [incoming-funds] [NUMERIC](18,3),
  [disbursement] [NUMERIC](18,3),
  [expenditure] [NUMERIC](18,3),
  [incoming-commitment] [NUMERIC](18,3),
  [outgoing-commitment] [NUMERIC](18,3));

  ALTER TABLE [fct_transactions] ADD CONSTRAINT [fct_transactions_dim_activities_fk] 
  FOREIGN KEY ([activity-id]) REFERENCES [dim_activities] ([activity-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;

  ALTER TABLE [fct_transactions] ADD CONSTRAINT [fct_transactions_dim_date_fk] 
  FOREIGN KEY ([date]) REFERENCES [dim_date] ([date_id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
  
  ALTER TABLE [fct_transactions] ADD CONSTRAINT [fct_transactions_dim_organisations_fk] 
  FOREIGN KEY ([organisation-id]) REFERENCES [dim_organisations] ([organisation-id]) ON
  UPDATE
    NO ACTION ON
    DELETE
    NO ACTION;
END

IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'etl'))
BEGIN 
  CREATE TABLE [etl] (
  [last_update] [datetime] CONSTRAINT [DF_etl_last_update] DEFAULT getdate(),
  [label] [varchar](MAX));
END



IF (NOT EXISTS (SELECT * 
  FROM INFORMATION_SCHEMA.TABLES 
  WHERE TABLE_SCHEMA = 'dbo' 
  AND  TABLE_NAME = 'partnership_info'))
BEGIN 
  CREATE TABLE [partnership_info] (
  [action_needed] [varchar](MAX),
  [by_whom] [varchar](MAX),
  [class] [varchar](MAX),
  [feedback] [varchar](MAX),
  [hierarchy] [varchar](MAX),
  [iati-identifier] [varchar](MAX),
  [level] [bigint],
  [linking_to_upstream organisation] [bit],
  [partnership] [varchar](MAX),
  [published] [bit],
  [upstream_iati-identifier] [varchar](MAX),
  [upstream_linking_to_this] [bit],
  [upstream_organisation] [varchar](MAX),
  [what_it_means] [varchar](MAX));
END
