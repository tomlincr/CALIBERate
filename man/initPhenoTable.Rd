% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/makePhenoTable.R
\name{initPhenoTable}
\alias{initPhenoTable}
\title{Null initialises a wide table for all imported phenotypes}
\usage{
initPhenoTable(vocab = "ICD")
}
\arguments{
\item{vocab}{A string - specifies which clinical vocabulary is in use (ICD10, OPCS4, CPRD)}
}
\value{
An empty data.table with 1 column per phenotype
}
\description{
Null initialises a wide table for all imported phenotypes
}
