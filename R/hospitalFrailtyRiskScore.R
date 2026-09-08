
#' Add the hospital frailty risk score as defined in
#' [Gilbert et al. (2018)](https://doi.org/10.1016/S0140-6736(18)30668-8)
#'
#' @inheritParams xDoc
#' @inheritParams indexDateDoc
#' @param conceptSet
#' `r documentationConceptSet(requiredConcepts$hospital_frailty_risk_score)`
#' @inheritParams categoriesDoc
#' @inheritParams nameStyleDoc
#' @inheritParams nameDoc
#'
#' @returns The `x` table with a new column added with the hospital
#' frailty risk score of the patient.
#'
#' @export
#'
addHospitalFrailtyRiskScore <- function(x,
                                        indexDate = "cohort_start_date",
                                        conceptSet = getIndexCodelist("hospital_frailty_risk_score"),
                                        categories = list(
                                          "low" = c(0, 5),
                                          "intermediate" = c(5, 15),
                                          "high" = c(15, Inf)
                                        ),
                                        nameStyle = "hfrs",
                                        name = tableName(x)) {
  addIndex(
    x = x,
    type = "hospital_frailty_risk_score",
    indexDate = indexDate,
    window = c(-730, 0),
    conceptSet = conceptSet,
    categories = categories,
    nameStyle = nameStyle,
    ageAdjusted = FALSE,
    name = name
  )
}
