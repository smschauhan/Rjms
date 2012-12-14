\name{destroy.consumer}
\alias{destroy.consumer}
\title{
kills a connection
}
\description{
kills an existing connection created with \code{initialize.consumer}
}
\usage{
destroy.consumer(obj)
}
\arguments{
  \item{obj}{
connection created using \code{initialize.consumer}. The object maintains a live connection to activeMQ for streaming messages.
}
}
\details{
A word of caution: Please ensure that the logger is created successfully before using this function.
}
\value{
returns the status of closing a connection. True, if the activeMQ connection is closed successfully.
}
\author{
SMS Chauhan
}
\note{
No further notes.
}

\seealso{
\code{\link{initialize.consumer}}
}
\examples{
\dontrun{
logger<-initialize.logger('tcp://localhost:61616',
'Q','queue:R:test')
L3 <- LETTERS[1:3]
d <- data.frame(cbind(x=1, y=1:10), fac=
	sample(L3, 10, replace=TRUE))
send.status<-to.logger(logger,d,F,'clientID',
'xxx-yy-zzz')
close.status<-destroy.logger(logger)
consumer<-initialize.consumer('tcp://localhost:61616',
'Q','queue:R:test')
z<-consume(consumer,'clientID','xxx-yy-zzz')
close.consumer<-destroy.consumer(consumer)
identical(d,z)
}
}
\keyword{messaging}
\keyword{logger}
