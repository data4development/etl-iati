CREATE OR ALTER VIEW [view_transactions] AS
SELECT
  fct_transactions."activity-identifier",
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
  (fct_countries_regions.percentage * fct_transactions.value) AS "country-value",
  (fct_countries_regions.percentage * fct_transactions."incoming-funds") AS "country-incoming-funds",
  (fct_countries_regions.percentage * fct_transactions.expenditure) AS "country-expenditure",
  (fct_countries_regions.percentage * fct_transactions.disbursement) AS "country-disbursement",
  (fct_countries_regions.percentage * fct_transactions."incoming-commitment") AS "country-incoming-commitment",
  (fct_countries_regions.percentage * fct_transactions."outgoing-commitment") AS "country-outgoing-commitment"
FROM
  (fct_transactions
JOIN fct_countries_regions ON
  ((fct_transactions."activity-id" = fct_countries_regions."activity-id")));
