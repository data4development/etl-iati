
CREATE TABLE IF NOT EXISTS dim_activities (
  "activity-id" bigserial NOT NULL,
  "version" int4 NULL,
  date_from timestamp NULL,
  date_to timestamp NULL,
  "activity-identifier" text NULL,
  title text NULL DEFAULT 'N/A'::text,
  description text NULL DEFAULT 'N/A'::text,
  "activity-status" text NULL,
  "organisation-id" text NULL,
  "planned-start" timestamp NULL,
  "planned-end" timestamp NULL,
  "actual-start" timestamp NULL,
  "actual-end" timestamp NULL,
  "hierarchy" varchar NULL DEFAULT 'project'::character varying,
  "parent-identifier" varchar NULL,
  "programme-identifier" varchar NULL,
  "programme-title" varchar NULL,
  "last-update" timestamp NULL,
  CONSTRAINT dim_activities_pk PRIMARY KEY ("activity-id")
)
WITH (
  OIDS=FALSE
);
CREATE INDEX idx_dim_activities_lookup ON dim_activities USING btree ("activity-identifier");
CREATE INDEX idx_dim_activities_tk ON dim_activities USING btree ("activity-id");


CREATE TABLE IF NOT EXISTS dim_countries (
  "country-id" bigserial NOT NULL,
  "version" int4 NULL,
  date_from timestamp NULL,
  date_to timestamp NULL,
  "country-code" text NULL,
  "oecd-dac-code" text NULL,
  "region-name-bz" text NULL,
  "un-ldc" text NULL,
  "income-class" text NULL,
  "fragile-state" text NULL,
  "country-name" text NULL,
  "oecd-dac-geography" text NULL,
  CONSTRAINT dim_countries_pk PRIMARY KEY ("country-id")
)
WITH (
  OIDS=FALSE
);


CREATE TABLE IF NOT EXISTS dim_date (
  date_id date NOT NULL,
  "date" timestamp NULL,
  "year" int4 NULL,
  year_for_week int4 NULL,
  year_for_week_iso8601 int4 NULL,
  quarter int4 NULL,
  "month" int4 NULL,
  week_of_year int4 NULL,
  week_of_year_iso8601 int4 NULL,
  week_of_month int4 NULL,
  week_of_month_iso8601 int4 NULL,
  weekday_in_month int4 NULL,
  "day" int4 NULL,
  day_of_year int4 NULL,
  day_of_week int4 NULL,
  date_iso text NULL,
  days_in_month int4 NULL,
  days_in_year int4 NULL,
  days_in_year_for_week int4 NULL,
  days_in_year_for_week_iso8601 int4 NULL,
  days_in_quarter int4 NULL,
  is_leap_year int4 NULL,
  is_leap_year_for_week int4 NULL,
  is_leap_year_for_week_iso8601 int4 NULL,
  is_weekend int4 NULL,
  is_holiday int4 NULL,
  holiday_name text NULL,
  is_working_day int4 NULL,
  day_of_week_long_label_eng text NULL,
  day_of_week_short_label_eng text NULL,
  month_long_label_eng text NULL,
  month_short_label_eng text NULL,
  CONSTRAINT dim_date_pk PRIMARY KEY (date_id)
)
WITH (
  OIDS=FALSE
);
CREATE INDEX idx_dim_date_lookup ON dim_date USING btree (date_id);


CREATE TABLE IF NOT EXISTS dim_organisations (
  "organisation-id" bigserial NOT NULL,
  "version" int4 NULL,
  date_from timestamp NULL,
  date_to timestamp NULL,
  "organisation-identifier" text NULL,
  "name" text NULL DEFAULT 'N/A'::text,
  "type" text NULL DEFAULT 'N/A'::text,
  CONSTRAINT dim_organisations_pk PRIMARY KEY ("organisation-id")
)
WITH (
  OIDS=FALSE
);
CREATE INDEX idx_dim_organisations_lookup ON dim_organisations USING btree ("organisation-identifier");


CREATE TABLE IF NOT EXISTS dim_indicators (
  "indicator-id" bigserial NOT NULL,
  "version" int4 NULL,
  date_from timestamp NULL,
  date_to timestamp NULL,
  "indicator-measure" varchar NULL,
  "indicator-title" varchar NULL,
  "indicator-reference-code" varchar NULL,
  "indicator-reference-title" varchar NULL,
  "level-needs-improvement" numeric NULL,
  "level-satisfactory" numeric NULL,
  "level-good" numeric NULL,
  "level-very-good" numeric NULL,
  "level-maximum" numeric NULL,
  "level-minimum" numeric NULL,
  CONSTRAINT dim_indicators_pk PRIMARY KEY ("indicator-id")
)
WITH (
  OIDS=FALSE
);


CREATE TABLE IF NOT EXISTS dim_results (
  "result-id" bigserial NOT NULL,
  "version" int4 NULL,
  date_from timestamp NULL,
  date_to timestamp NULL,
  "result-type" varchar NULL,
  "aggregation-status" varchar(1) NULL,
  "result-title" varchar NULL,
  "result-reference-code" varchar NULL,
  "result-reference-vocabulary" varchar NULL,
  CONSTRAINT dim_results_pk PRIMARY KEY ("result-id")
)
WITH (
  OIDS=FALSE
);


CREATE TABLE IF NOT EXISTS fct_budgets (
  "budgetline-id" bigserial NOT NULL,
  "activity-identifier" text NULL,
  "period-start" date NULL,
  "period-end" date NULL,
  "budget-type" text NULL,
  budget numeric(17,3) NOT NULL DEFAULT 0,
  "value-date" date NULL,
  currency text NULL,
  "activity-id" int8 NULL,
  "organisation-id" int8 NULL,
  "country-id" int8 NULL,
  "country-percentage" numeric NULL DEFAULT 100,
  CONSTRAINT fct_budgets_pk PRIMARY KEY ("budgetline-id"),
  CONSTRAINT fct_budgets_dim_activities_fk FOREIGN KEY ("activity-id") REFERENCES dim_activities("activity-id"),
  CONSTRAINT fct_budgets_dim_countries_fk FOREIGN KEY ("country-id") REFERENCES dim_countries("country-id"),
  CONSTRAINT fct_budgets_dim_date_end_fk FOREIGN KEY ("period-end") REFERENCES dim_date(date_id),
  CONSTRAINT fct_budgets_dim_date_start_fk FOREIGN KEY ("period-start") REFERENCES dim_date(date_id),
  CONSTRAINT fct_budgets_dim_organisations_fk FOREIGN KEY ("organisation-id") REFERENCES dim_organisations("organisation-id")
)
WITH (
  OIDS=FALSE
);


CREATE TABLE IF NOT EXISTS fct_countries_regions (
  "country-region-id" bigserial NOT NULL,
  "country-id" int8 NOT NULL,
  "activity-id" int8 NOT NULL,
  "activity-identifier" varchar NULL,
  "organisation-id" int8 NOT NULL,
  percentage numeric NULL,
  CONSTRAINT fct_countries_regions_pk PRIMARY KEY ("country-region-id"),
  CONSTRAINT fct_countries_regions_dim_activities_fk FOREIGN KEY ("activity-id") REFERENCES dim_activities("activity-id"),
  CONSTRAINT fct_countries_regions_dim_countries_fk FOREIGN KEY ("country-id") REFERENCES dim_countries("country-id"),
  CONSTRAINT fct_countries_regions_dim_organisations_fk FOREIGN KEY ("organisation-id") REFERENCES dim_organisations("organisation-id")
)
WITH (
  OIDS=FALSE
);

CREATE TABLE IF NOT EXISTS fct_baselines (
  "baseline-id" bigserial NOT NULL,
  "activity-identifier" varchar NULL,
  "activity-id" int8 NOT NULL,
  "organisation-id" int8 NOT NULL,
  "result-id" int8 NOT NULL,
  "indicator-id" int8 NOT NULL,
  "baseline-year" int8 NULL,
  "baseline-value" numeric NULL,
  "baseline-comment" varchar NULL,
  CONSTRAINT fct_baselines_pk PRIMARY KEY ("baseline-id"),
  CONSTRAINT fct_baselines_dim_activities_fk FOREIGN KEY ("activity-id") REFERENCES dim_activities("activity-id"),
  CONSTRAINT fct_baselines_dim_organisations_fk FOREIGN KEY ("organisation-id") REFERENCES dim_organisations("organisation-id"),
  CONSTRAINT fct_baselines_dim_results_fk FOREIGN KEY ("result-id") REFERENCES dim_results("result-id"),
  CONSTRAINT fct_baselines_dim_indicators_fk FOREIGN KEY ("indicator-id") REFERENCES dim_indicators("indicator-id")
)
WITH (
  OIDS=FALSE
);


CREATE TABLE IF NOT EXISTS fct_results (
  "resultline-id" bigserial NOT NULL,
  "activity-identifier" varchar NULL,
  "activity-id" int8 NOT NULL,
  "organisation-id" int8 NOT NULL,
  "result-id" int8 NOT NULL,
  "indicator-id" int8 NOT NULL,
  "period-start" date NULL,
  "period-end" date NULL,
  "target-value" numeric NULL,
  "actual-value" numeric NULL,
  "target-comment" varchar NULL,
  "actual-comment" varchar NULL,
  CONSTRAINT fct_results_pk PRIMARY KEY ("resultline-id"),
  CONSTRAINT fct_results_dim_activities_fk FOREIGN KEY ("activity-id") REFERENCES dim_activities("activity-id"),
  CONSTRAINT fct_results_dim_organisations_fk FOREIGN KEY ("organisation-id") REFERENCES dim_organisations("organisation-id"),
  CONSTRAINT fct_results_dim_results_fk FOREIGN KEY ("result-id") REFERENCES dim_results("result-id"),
  CONSTRAINT fct_results_dim_indicators_fk FOREIGN KEY ("indicator-id") REFERENCES dim_indicators("indicator-id")
)
WITH (
  OIDS=FALSE
);

CREATE TABLE IF NOT EXISTS fct_transactions (
  "activity-identifier" text NULL,
  "date" date NULL,
  "type" text NULL,
  value numeric(17,3) NOT NULL DEFAULT 0,
  "value-date" date NULL,
  currency text NULL,
  "activity-id" int8 NULL,
  "organisation-id" int8 NULL,
  "provider-organisation-id" int8 NULL,
  "provider-activity-id" int8 NULL,
  "receiver-organisation-id" int8 NULL,
  "receiver-activity-id" int8 NULL,
  "incoming-funds" numeric NULL,
  disbursement numeric NULL,
  expenditure numeric NULL,
  "incoming-commitment" numeric NULL,
  "outgoing-commitment" numeric NULL,
  CONSTRAINT fct_transactions_dim_activities_fk FOREIGN KEY ("activity-id") REFERENCES dim_activities("activity-id"),
  CONSTRAINT fct_transactions_dim_date_fk FOREIGN KEY (date) REFERENCES dim_date(date_id),
  CONSTRAINT fct_transactions_dim_organisations_fk FOREIGN KEY ("organisation-id") REFERENCES dim_organisations("organisation-id")
)
WITH (
  OIDS=FALSE
);
CREATE INDEX idx_fct_transactions_lookup ON fct_transactions USING btree ("activity-identifier", date, type, value);


CREATE TABLE IF NOT EXISTS etl (
  "last_update" timestamp NULL DEFAULT now(),
  "label" varchar NULL
)
WITH (
  OIDS=FALSE
);


CREATE TABLE IF NOT EXISTS partnership_info (
  "action_needed" text NULL,
  "by_whom" text NULL,
  "class" text NULL,
  "feedback" text NULL,
  "hierarchy" text NULL,
  "iati-identifier" text NULL,
  "level" int8 NULL,
  "linking_to_upstream organisation" boolean NULL,
  "partnership" text NULL,
  "published" boolean NULL,
  "upstream_iati-identifier" text NULL,
  "upstream_linking_to_this" boolean NULL,
  "upstream_organisation" text NULL,
  "what_it_means" text NULL
)
WITH (
  OIDS=FALSE
);



CREATE OR REPLACE VIEW view_transactions
AS SELECT fct_transactions."activity-identifier",
    fct_transactions.date,
    fct_transactions.type,
    fct_transactions.value,
    fct_transactions."value-date",
    fct_transactions.currency,
    fct_transactions."activity-id",
    fct_transactions."organisation-id",
    fct_transactions."provider-organisation-id",
    fct_transactions."provider-activity-id",
    fct_transactions."receiver-organisation-id",
    fct_transactions."receiver-activity-id",
    fct_transactions."incoming-funds",
    fct_transactions.disbursement,
    fct_transactions.expenditure,
    fct_transactions."incoming-commitment",
    fct_transactions."outgoing-commitment",
    fct_countries_regions."country-id",
    fct_countries_regions.percentage * fct_transactions.value AS "country-value",
    fct_countries_regions.percentage * fct_transactions."incoming-funds" AS "country-incoming-funds",
    fct_countries_regions.percentage * fct_transactions.expenditure AS "country-expenditure",
    fct_countries_regions.percentage * fct_transactions.disbursement AS "country-disbursement",
    fct_countries_regions.percentage * fct_transactions."incoming-commitment" AS "country-incoming-commitment",
    fct_countries_regions.percentage * fct_transactions."outgoing-commitment" AS "country-outgoing-commitment"
   FROM fct_transactions
     JOIN fct_countries_regions ON fct_transactions."activity-id" = fct_countries_regions."activity-id";
