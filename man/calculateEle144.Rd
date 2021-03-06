% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/calculateEle144.R
\name{calculateEle144}
\alias{calculateEle144}
\title{Calculate Element 144 (Consumption Per Day)}
\usage{
calculateEle144(population11Num, data, aupusParam)
}
\arguments{
\item{population11Num}{The column corresponds to element 11 of
population.}

\item{data}{The AUPUS node dataset, typically as produced by buildNodes.}

\item{aupusParam}{A list of running parameters to be used in pulling the data.
Typically, this is generated from getAupusParameter (see that function for
a description of the required elements).}
}
\value{
This function returns an integer vector
containing the row numbers of observations which were updated.
However, it also has a side effect: rows within the
passed data.table ("data") have element 144's value and symbol updated.
}
\description{
The consumption per day is the ratio of total consumption to the
population.  This value is computed for all replaceable symbols (i.e. when
the current figure is not official).  For some commodity groups, an
adjustment is made by multiplying by 1000.
}

