\name{initialize.logger}
\alias{initialize.logger}

\title{
Creates a logger
}
\description{
Creates a connection to a logger
}
\usage{
initialize.logger(url, type, name)
}

\arguments{
  \item{url}{
The URL for the activemq broker. Default as tcp://localhost:61616
}
  \item{type}{
Type - 'Q' or a 'T', depending on whether you are trying to create a queue or a topic
}
  \item{name}{
The name of the queue or topic created.
}
 
}
\details{
For the logger to be created, please ensure you have an activemq broker running in the background.
}
\value{
a connection to activeMQ
}

\author{
SMS Chauhan
}
\note{
No further notes.
}

\seealso{
\code{\link{to.logger}}
\code{\link{destroy.logger}}
}
\examples{
\dontrun{
logger<-initialize.logger('tcp://localhost:61616',
'Q','queue:R:test')
}
}
\keyword{messaging}
\keyword{logger}
