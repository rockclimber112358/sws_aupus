% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/calculateAvailability.R
\name{calculateAvailability}
\alias{calculateAvailability}
\title{Aggregate Availability}
\usage{
calculateAvailability(tree, standParams)
}
\arguments{
\item{tree}{The commodity tree, specified as a data.table object.  It should
have columns childVar (the commodity code of the child), parentVar (the
commodity code of the parent), extractionVar (numeric value specifying the
extraction rate), and possibly shareVar (numeric value specifying how the
commodity should be split up), all of which are specified in standParams.}

\item{standParams}{The parameters for standardization.  These parameters
  provide information about the columns of data and tree, specifying (for
  example) which columns should be standardized, which columns represent
  parents/children, etc.}
}
\value{
A data.table with columns parentVar, childVar, and the availability
  from that process.  Thus, if beer could be standardized into wheat, maize
  or barley (and there is availability in all three products) our final
  table will have three rows (beer/wheat, beer/maize, beer/barley).
}
\description{
In order to determine shares for standardization, we have to calculate
availability of parent commodities.  For example, if fruit juice is produced
from both apples and oranges, and the country has 400 tonnes of apples and
100 tonnes of oranges, then we should standardize 80% of fruit juice values
to apples and 20% to oranges.  This becomes more complicated when you
consider the multiple levels of the tree, and that there may be trade of
flour, for example, which influences the availability of wheat.
}
\details{
Note that availability becomes complicated with complicated graphs.  For
example, if A is a parent of B and C, and B and C are both parents of D,
what is the availability of A for standardizing D?  There is no clear best
approach, but we decided to compute availability of A for D in this case by
computing the availability of A, B, and C for D (i.e. aggregating the
imbalances over all parents in the path).  In the case of A and B are
parents of C and C is a parent of D, we have a different problem. Imbalances
in C shouldn't be double counted in the imbalances of A and B, so we should
split C's imbalance into A and B according to availability of A and B.
}

