\name{initialize.consumer}
\alias{initialize.consumer}
\title{
creates a consumer
}
\description{
creates a connection to a consumer
}
\usage{
initialize.consumer(url, type, name)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{url}{
The URL for the activemq broker. Default as tcp://localhost:61616
}
  \item{type}{
Type - 'Q' for creating a queue
}
  \item{name}{
The name of the queue created.
}
}
\details{
For the consumer to be created, please ensure you have an activemq broker running in the background.
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
\code{\link{listen}}
\code{\link{consume}}
\code{\link{destroy.consumer}}
}
\examples{
\dontrun{
consumer<-initialize.consumer('tcp://localhost:61616',
'Q','queue:R:test')
}
}

\keyword{ messaging }
\keyword{ logger }
