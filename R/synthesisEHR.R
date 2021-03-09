library(data.table)

#' Generates synthetic EHR data from imported phenotypes for testing
#'
#' @param n number of patients
#' @param vocab A string - specifies which clinical vocabulary is in use (ICD10, OPCS4, CPRD)
#'
#' @return data.table
#' @export


synthesisEHR = function(n, vocab='ICD') {
  if (vocab == "ICD") {
    data.table(id = seq(1,n),
               date = sample(seq(as.Date('1997/01/01'), Sys.Date(), by = "day"), n, replace = TRUE),
               dx = sample(ICD$ICD10code, n, replace = TRUE))
  } else if (vocab == "OPCS") {
    data.table(id = seq(1,n),
               date = sample(seq(as.Date('1997/01/01'), Sys.Date(), by = "day"), n, replace = TRUE),
               dx = sample(OPCS$Readcode, n, replace = TRUE))
  } else if (vocab == "CPRD") {
    # TODO: check if should be readcode or medcode, see also makePhenoTable
    data.table(id = seq(1,n),
               date = sample(seq(as.Date('1997/01/01'), Sys.Date(), by = "day"), n, replace = TRUE),
               dx = sample(CPRD$Readcode, n, replace = TRUE))
  } else {
    warning("Vocabulary not recognised. Valid options: ICD, OPCS, CPRD")
  }
}



dummy = synthesisEHR(10000, vocab = "ICD")

