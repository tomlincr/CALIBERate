library(data.table)



# Import dictionary -------------------------------------------------------

dictionary = fread("./chronological-map-phenotypes/dictionary.csv")


# Build ICD-10 lookup table -----------------------------------------------

ICD = data.table()
for (pheno in 1:nrow(dictionary)) {
  pheno_name = dictionary$phenotype[pheno]
  file_name = dictionary$ICD[pheno]
  if (file_name == "") next # skip import if filename is empty
  path = paste0("./chronological-map-phenotypes/secondary_care/", file_name)
  codelist = fread(path)
  # NB at *present* sum(Disease != Phenotype) = 0
  # Therefore adding phenotype name may be unecessary but included for completion
  codelist = cbind(codelist, Phenotype = rep(pheno_name, nrow(codelist)))
  ICD = rbindlist(list(ICD, codelist))
}


# OPCS --------------------------------------------------------------------

OPCS = data.table()
for (pheno in 1:nrow(dictionary)) {
  pheno_name = dictionary$phenotype[pheno]
  file_name = dictionary$OPCS[pheno]
  if (file_name == "") next # skip import if filename is empty
  path = paste0("./chronological-map-phenotypes/secondary_care/", file_name)
  codelist = fread(path)
  # NB at *present* sum(Disease != Phenotype) = 0
  # Therefore adding phenotype name may be unecessary but included for completion
  codelist = cbind(codelist, Phenotype = rep(pheno_name, nrow(codelist)))
  OPCS = rbindlist(list(OPCS, codelist))
}


# CPRD --------------------------------------------------------------------

CPRD = data.table()
for (pheno in 1:nrow(dictionary)) {
  pheno_name = dictionary$phenotype[pheno]
  file_name = dictionary$CPRD[pheno]
  if (file_name == "") next # skip import if filename is empty
  path = paste0("./chronological-map-phenotypes/primary_care/", file_name)
  codelist = fread(path)
  # NB at *present* sum(Disease != Phenotype) = 0
  # Therefore adding phenotype name may be unecessary but included for completion
  codelist = cbind(codelist, Phenotype = rep(pheno_name, nrow(codelist)))
  CPRD = rbindlist(list(CPRD, codelist))
}


# Strip symbols -----------------------------------------------------------

# Decision to strip decimal points from codes as this is done in pre-processing for HES

ICD$ICD10code = gsub("[[:punct:]]", "", ICD$ICD10code)
OPCS$OPCS4code = gsub("[[:punct:]]", "", OPCS$OPCS4code)
# Unsure about CPRD therefore leaving for now!
# TODO: build parameter into library to allow specification of this process on loading
