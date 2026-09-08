# Add the maximum number of ingredients an individual is exposed simultaneously in a certain window

Add the maximum number of ingredients an individual is exposed
simultaneously in a certain window

## Usage

``` r
addPolypharmacyCount(
  x,
  indexDate = "cohort_start_date",
  window = c(0, 0),
  overlap = TRUE,
  nameStyle = "polypharmacy_count",
  name = tableName(x)
)
```

## Arguments

- x:

  A `cdm_table` object.

- indexDate:

  Name of a 'date' column that indicates the index date.

- window:

  Window of interest.

- overlap:

  Whether exposures must overlap in time or merely occur within the
  window of interest.

- nameStyle:

  Name of the new column.

- name:

  Name of the new table.

## Value

The table `x` with a new column column with the number of ingredients
used in the window of interest.

## Examples

``` r
# \donttest{
library(OmopIndices)
library(omock)
library(dplyr)

cdm <- mockCdmFromDataset(datasetName = "GiBleed", source = "duckdb")
#> ℹ Loading bundled GiBleed tables from package data.
#> ℹ Adding drug_strength table.
#> ℹ Creating local <cdm_reference> object.
#> ℹ Inserting <cdm_reference> into duckdb.
#> duckdb keeps downloaded extensions and secrets in a temporary directory:
#> ℹ /tmp/RtmpJequ8o/duckdb
#> This is removed when the R session ends.
#> • Extensions are re-downloaded each session.
#> • Secrets are lost.
#> ℹ Run duckdb(shared_home = TRUE) (or create ~/.duckdb) to keep them (suitable for most users).
#> ℹ Run duckdb(shared_home = FALSE) to accept the temporary directory (and silence this message).
#> ℹ See ?duckdb_storage for details and alternatives.

cdm$condition_occurrence |>
  slice_sample(n = 10) |>
  select("person_id", "condition_start_date") |>
  addPolypharmacyCount(indexDate = "condition_start_date")
#> # A query:  ?? x 3
#> # Database: DuckDB 1.5.5 [unknown@Linux 6.17.0-1022-azure:R 4.6.1//tmp/RtmpJequ8o/file1af31f89a360.duckdb]
#>    person_id condition_start_date polypharmacy_count
#>        <int> <date>                            <int>
#>  1      3893 1979-10-07                            0
#>  2      4492 1969-11-07                            0
#>  3      3756 1985-10-01                            0
#>  4      1231 1952-10-12                            0
#>  5      4960 1923-08-02                            0
#>  6       236 1983-02-11                            0
#>  7      4949 2013-02-28                            0
#>  8      2295 2013-09-10                            0
#>  9      2079 2005-11-01                            0
#> 10      3464 1997-04-15                            0
# }
```
