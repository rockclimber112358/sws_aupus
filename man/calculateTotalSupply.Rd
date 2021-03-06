% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/calculateTotalSupply.R
\name{calculateTotalSupply}
\alias{calculateTotalSupply}
\title{Calculate Total Supply}
\usage{
calculateTotalSupply(data, aupusParam)
}
\arguments{
\item{data}{The AUPUS node dataset, typically as produced by buildNodes.}

\item{aupusParam}{A list of running parameters to be used in pulling the data.
Typically, this is generated from getAupusParameter (see that function for
a description of the required elements).}
}
\value{
No value is returned, but a new column ("TOTAL_SUPPLY") is
appended to the passed data.table.  This column provides the total supply
for the balancing.
}
\description{
This function calculates total supply by summing up elements 51, 58, 61,
and 66 (see arguments below to understand what these items are).  Also,
the itemTypeCol is required as a handful of commodities are treated
differently when computing supply (see aupusGroups$initialAsSupply).
}

