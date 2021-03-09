library(data.table)



# Import dictionary -------------------------------------------------------

dictionary = fread("./chronological-map-phenotypes/dictionary.csv")


# Build ICD-10 lookup table -----------------------------------------------

ICD = data.table()
for (pheno in 1:nrow(dictionary)) {
  pheno_name = dictionary$phenotype[pheno]
  file_name = dictionary$ICD[pheno]
  if (file_name == "") next # skip import if filename is empty
  path = paste0("./chronological-map-phenotypes-master/secondary_care/", file_name)
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
  path = paste0("./chronological-map-phenotypes-master/secondary_care/", file_name)
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
  path = paste0("./chronological-map-phenotypes-master/primary_care/", file_name)
  codelist = fread(path)
  # NB at *present* sum(Disease != Phenotype) = 0
  # Therefore adding phenotype name may be unecessary but included for completion
  codelist = cbind(codelist, Phenotype = rep(pheno_name, nrow(codelist)))
  CPRD = rbindlist(list(CPRD, codelist))
}

