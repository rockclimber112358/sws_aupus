% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ensureAupusParameter.R
\name{ensureAupusParameter}
\alias{ensureAupusParameter}
\title{Ensure AUPUS parameters}
\usage{
ensureAupusParameter(aupusParam)
}
\arguments{
\item{aupusParam}{The AUPUS parameter list, typically as generated by
getAupusParameter.}
}
\value{
No data is returned, but errors are raised if the aupusParam
argument is invalid.
}
\description{
This function performs several checks on the AUPUS parameters to ensure it
is valid.  Typically, these parameters are created by getAupusParameter and
should have no issues, but these parameters could be modified by the user.
}

