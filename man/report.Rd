% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/report.R
\name{report}
\alias{report}
\title{Generate an Audit Report}
\usage{
report(object = NULL, file = NULL, format = "html_document")
}
\arguments{
\item{object}{an object of class \code{jfaEvaluation} as returned by the \code{evaluation()} function.}

\item{file}{a string that gives the desired name of the file (e.g. \code{"report.html"}). The report is created in your current working directory.}

\item{format}{can be either one of \code{"html_document"} or \code{"pdf_document"} (compiling to pdf requires MikTex).}
}
\value{
A html or pdf report containing the results of the evaluation.
}
\description{
This function takes an object of class \code{jfaEvaluation}, creates a report containing the results, and saves the report to a file in your working directory.

For more details on how to use this function see the package vignette:
\code{vignette("jfa", package = "jfa")}
}
\examples{
library(jfa)
set.seed(1)

# Generate some audit data (N = 1000):
data <- data.frame(ID = sample(1000:100000, size = 1000, replace = FALSE), 
                   bookValue = runif(n = 1000, min = 700, max = 1000))

# Using monetary unit sampling, draw a random sample from the population.
s1 <- selection(population = data, sampleSize = 100, units = "mus", 
                 bookValues = "bookValue", algorithm = "random")
s1_sample <- s1$sample
s1_sample$trueValue <- s1_sample$bookValue
s1_sample$trueValue[2] <- s1_sample$trueValue[2] - 500 # One overstatement is found

e2 <- evaluation(sample = s1_sample, bookValues = "bookValue", auditValues = "trueValue", 
                 method = "stringer", materiality = 0.05, counts = s1_sample$counts)

# Generate report
# report(e2, file = "myFile.html")

}
\seealso{
\code{\link{evaluation}}
}
\author{
Koen Derks, \email{k.derks@nyenrode.nl}
}
\keyword{audit}
\keyword{evaluation}
\keyword{report}
