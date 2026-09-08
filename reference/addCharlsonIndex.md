# Add Charlson Comorbidity Index (CCI) value based on [Charlson et al. (1987)](https://doi.org/10.1016/0021-9681(87)90171-8) and [Charlson et al. (1994)](https://doi.org/10.1016/0895-4356(94)90129-5) (age-adjusted) version.

Add Charlson Comorbidity Index (CCI) value based on [Charlson et al.
(1987)](https://doi.org/10.1016/0021-9681(87)90171-8) and [Charlson et
al. (1994)](https://doi.org/10.1016/0895-4356(94)90129-5) (age-adjusted)
version.

## Usage

``` r
addCharlsonIndex(
  x,
  indexDate = "cohort_start_date",
  ageAdjusted = TRUE,
  window = c(-Inf, 0),
  conceptSet = getIndexCodelist("charlson"),
  nameStyle = "charlson",
  categories = NULL,
  name = tableName(x)
)
```

## Arguments

- x:

  A `cdm_table` object, it mus contain `person_id` or `subject_id` as
  columns.

- indexDate:

  A character string that points to a `Date` column in the `x` table.

- ageAdjusted:

  Whether to calculate the Age-Adjusted Comorbidity Index (TRUE) or not
  (FALSE)

- window:

  Window to asses `Charlson index` in, it must be a vector of two
  numeric values `c(min, max)`. Window times refer to days since
  `indexDate`.

- conceptSet:

  It can either be a , \<codelist_with_details\> or
  \<concept_set_expression\> object. It must contain
  `myocardial_infarction`, `congestive_heart_failure`,
  `peripheral_vascular_disease`, `cerebrovascular_disease`, `dementia`,
  `chronic_pulmonary_disease`, `connective_tissue_disease`,
  `peptic_ulcer_disease`, `mild_liver_disease`,
  `diabetes_without_complication`, `hemiplegia`,
  `severe_chronic_kidney_disease`, `diabetes_with_complication`,
  `any_malignancy`, `moderate_or_severe_liver_disease`,
  `metastatic_solid_tumor`, `aids` as concepts. By default internal
  concepts are used.

- nameStyle:

  A character string with the name of the new column.

- categories:

  Named list of categories to group the values. If NULL the risk score
  is returned as numeric.

- name:

  A character string with the name of the new table. If `NULL` a
  temporary table will be created.

## Value

The table `x` with a new column column with the corresponding Charlson
index value.

## Examples

``` r
{
library(OmopIndices)
library(omock)

cdm <- mockCdmFromDataset()
cdm <- cdm |>
 mockCohort()

conceptSet <- list(
 "myocardial_infarction" = 329847L,
 "congestive_heart_failure" = 319835L,
 "peripheral_vascular_disease" = 321052L,
 "cerebrovascular_disease" = 381591L,
 "dementia" = 4182210L,
 "chronic_pulmonary_disease" = 255573L,
 "connective_tissue_disease" = 4134537L,
 "peptic_ulcer_disease" = 4027663L,
 "mild_liver_disease" = 194984L,
 "moderate_or_severe_liver_disease" = 4212540L,
 "diabetes_without_complication" = 201820L,
 "diabetes_with_complication" = 42538715L,
 "hemiplegia" = 374022L,
 "severe_chronic_kidney_disease" = 46271022L,
 "any_malignancy" = 4180914L,
 "metastatic_solid_tumor" = 432851L,
 "aids" = 4267414L)

cdm$cohort |>
  addCharlsonIndex(conceptSet = conceptSet)
}
#> ℹ Loading bundled GiBleed tables from package data.
#> ℹ Adding drug_strength table.
#> ℹ Creating local <cdm_reference> object.
#> Warning: 16 unique codelist concept IDs are not present in `cdm$concept`.
#> Warning: 16 unique codelist concept IDs are not present in `cdm$concept`.
#> ! 16 concept(s) from domain NA eliminated as it is not supported.
#> ℹ Supported domains are: device, specimen, measurement, drug, condition,
#>   observation, procedure, episode, and visit.
#> # A tibble: 2,694 × 5
#>    cohort_definition_id subject_id cohort_start_date cohort_end_date charlson
#>  *                <int>      <int> <date>            <date>             <dbl>
#>  1                    1          1 1992-08-21        2001-11-26             1
#>  2                    1          2 1986-05-10        2000-03-13             2
#>  3                    1          7 1971-04-25        1977-08-27             0
#>  4                    1          9 1991-08-07        2003-06-27             0
#>  5                    1          9 2009-09-14        2010-09-07             0
#>  6                    1         11 1993-11-14        1999-06-12             0
#>  7                    1         11 1999-06-13        2012-03-19             0
#>  8                    1         12 2007-06-30        2010-06-05             1
#>  9                    1         12 2010-06-06        2010-08-27             1
#> 10                    1         16 1990-08-22        1994-07-07             0
#> # ℹ 2,684 more rows
```
