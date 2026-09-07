
bnf <- readr::read_csv(
  file = here::here("data-raw", "bnf.csv"),
  col_types = c(concept_code = "c")
) |>
  dplyr::mutate(
    chapter = as.numeric(substr(bnf_code, 1, 2)),
    subchapter = as.numeric(substr(bnf_code, 3, 4))
  )

# eliminate the codes with no bnf
n <- nrow(bnf)
bnf <- bnf |>
  dplyr::filter(!is.na(bnf_code))
nt <- nrow(bnf)
cli::cli_inform("Eliminated {n - nt} rows for missing bnf code")

cdm <- omock::mockCdmFromDataset(datasetName = "delphi-100k")

ingredients <- bnf |>
  dplyr::select("concept_code", "chapter", "subchapter") |>
  dplyr::left_join(
    cdm$concept |>
      dplyr::select("concept_code", "concept_id"),
    by = "concept_code"
  )

# eliminate the codes that does not exist in OMOP
n <- nrow(ingredients)
ingredients <- ingredients |>
  dplyr::filter(!is.na(concept_id))
nt <- nrow(ingredients)
cli::cli_inform("Eliminated {n - nt} rows because concept id is NA")

# move to mapping
ingredients <- ingredients |>
  dplyr::left_join(
    cdm$concept_relationship |>
      dplyr::filter(relationship_id == "Maps to") |>
      dplyr::select("concept_id" = "concept_id_1", "omop_concept_id" = "concept_id_2"),
    by = "concept_id"
  )

n <- nrow(ingredients)
ingredients <- ingredients |>
  dplyr::filter(!is.na(omop_concept_id))
nt <- nrow(ingredients)
cli::cli_inform("Eliminated {n - nt} rows because omop concept id is NA")

# extract ingredient
ingredients <- ingredients |>
  dplyr::left_join(
    cdm$concept_ancestor |>
      dplyr::select("concept_id" = "descendant_concept_id", "igredient_id" = "ancestor_concept_id") |>
      dplyr::inner_join(
        cdm$concept |>
          dplyr::filter(concept_class_id == "Ingredient") |>
          dplyr::select()
      ),
    by = "concept_id"
  )
