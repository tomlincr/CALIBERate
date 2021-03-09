library(dplyr)


#' Null initialises a wide table for all imported phenotypes
#'
#' @param vocab A string - specifies which clinical vocabulary is in use (ICD10, OPCS4, CPRD)
#' @return An empty data.table with 1 column per phenotype

initPhenoTable = function(vocab='ICD') {
    if (vocab == "ICD") {
      setNames(data.table(matrix(nrow = 0,
                                 ncol = length(unique(ICD$Phenotype)))),
               unique(ICD$Phenotype))
    } else if (vocab == "OPCS") {
      setNames(data.table(matrix(nrow = 0,
                                 ncol = length(unique(OPCS$Phenotype)))),
               unique(OPCS$Phenotype))
    } else if (vocab == "CPRD") {
      setNames(data.table(matrix(nrow = 0,
                                 ncol = length(unique(CPRD$Phenotype)))),
               unique(CPRD$Phenotype))
    } else {
      warning("Vocabulary not recognised. Valid options: ICD, OPCS, CPRD")
    }
  }



#' Converts narrow code table to wide phenotype table
#'
#' @param data Data frame/table with which to apply function to
#' @param code_var String. Specifies the column name of the code variable
#' @param vocab String. Specifies which clinical vocabulary is in use (ICD10, OPCS4, CPRD)
#' @return data.table which is a wide phenotype table
#' @export

makePhenoTable = function(data, code_var='dx', vocab='ICD'){
  # Initialise by joining blank phenotype table
  df = cbind(data, initPhenoTable(vocab = vocab))
  # Loop through rows (code per row)
  for (i in 1:nrow(df)) {
    # get code for that row
    code = data[i, get(code_var)]
    # For vocab, find code in codelist and get phenotype
    if (vocab == 'ICD') {
      pheno = ICD$Phenotype[ICD$ICD10code == code]
    } else if (vocab == 'OPCS') {
      pheno = OPCS$Phenotype[OPCS$Readcode == code]
    } else if (vocab == 'CPRD') {
      # TODO: check if should be readcode or medcode, see also synthesisEHR
      pheno = CPRD$Phenotype[CPRD$Readcode == code]
    } else {
      warning("Vocabulary not recognised. Valid options: ICD, OPCS, CPRD")
    }
      # Returns a vector of column names as code can map to >1 phenotype
    # Set value to 1 for those column names within the vector
    df[i] = df[i] %>% replace(pheno, 1)
  }
  return(df)
}
