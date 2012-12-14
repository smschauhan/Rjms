\name{to.logger}
\alias{to.logger}

\title{
sends a message
}
\description{
sends a message to a queue or topic, with a property and value eg. a client id
}
\usage{
to.logger(obj, log, asString = F, propertyName=NULL, propertyValue=NULL)
}

\arguments{
  \item{obj}{
The object maintains a live connection to activeMQ for streaming messages.
}
  \item{log}{
The message value (string only allowed) that you wish to send to a topic or a queue
}
  \item{asString}{
TRUE if the message is to be sent as a string, FALSE if a serialized R Object. FALSE by default
}
 \item{propertyName}{
Default is \code{NULL}.This is a generic property that is used to set message headers. One property per message is allowed for now. This could easily be used for filtering messages when using topics.
}
  \item{propertyValue}{
Default is \code{NULL}. The value of the message header that is being set in propertyName.
}
}
\details{
Please ensure that an activeMQ connection is created successfully before using this function.
}
\value{
The function returns a boolean. If a message is delivered successfully, the result is true.
}

\author{
SMS Chauhan
}
\note{
propertyName and propertyValue default to \code{NULL}. In a typical scenario, these parameters don't need to be set. In specific cases, where propertyName and propertyValue are to be used for message filtering purposes, please ensure that both are well set. If any of them is \code{NULL}, the setting will be ignored.
}

\seealso{
\code{\link{initialize.logger}}
\code{\link{destroy.logger}}
}
\examples{
\dontrun{
logger<-initialize.logger('tcp://localhost:61616',
'Q','queue:R:test')
send.status<-to.logger(logger,'Hello dolly.',T,
'clientID','xxx-yy-zzz')
close.status<-destroy.logger(logger)
}
}
\keyword{ to.logger }
