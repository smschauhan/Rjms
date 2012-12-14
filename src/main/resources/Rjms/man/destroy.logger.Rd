\name{destroy.logger}
\alias{destroy.logger}

\title{
kills a connection
}
\description{
kills an existing connection created with \code{initialize.logger}
}
\usage{
destroy.logger(obj)
}

\arguments{
  \item{obj}{
connection created using \code{initialize.logger}. The object maintains a live connection to activeMQ for streaming messages.
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
\code{initialize.logger}
}
\examples{
\dontrun{logger<-initialize.logger('tcp://localhost:61616',
'Q','queue:R:test')
send.status<-to.logger(logger,'Hello dolly.',T,'clientID',
'xxx-yy-zzz')
close.status<-destroy.logger(logger)
 }
 }
\keyword{messaging}
\keyword{logger}
