\name{listen}
\alias{listen}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
listens to streaming messages
}
\description{
listens to streaming message using the consume command unless an escape sequence is provided, apply the callback function to the received message
}
\usage{
listen(consumer, property, value, exitCode = "#exit123", callback = printCallback, ...)
}
\arguments{
  \item{consumer}{
a consumer create using \code{initialize.consumer}
}
  \item{property}{
a header property name set for the message using \code{to.logger}
}
  \item{value}{
the value of the property described above
}
  \item{exitCode}{
the consumer will stop listening to the messages if an exit code is received. Default is '#exit123'
}
  \item{callback}{
a callback function to apply on the consumed messages. This can be used to perform streaming analysis. Prints by default
}
  \item{\dots}{
     extra arguments for the callback function
}
}
\details{
this function is a wrapper written on top of consume, to attach a callback function to streaming messages 
}
\value{
does not return a value, just exits when an exit code can be provided
}

\author{
SMS Chauhan
}
\note{
No further notes.
}
\section{Warning}{Please make sure that an exit code is provided once all messages are consumed. Failing to do so will result in a block, R could listen infinitely to the messages and the session will have to be kill to exit R}

\seealso{
\code{\link{consume}}
}
\examples{
\dontrun{library(Rjms)
env<-new.env(parent=globalenv())
#initialize a logger
logger<-initialize.logger('tcp://localhost:61616','Q','queue:R:test')
#enqueue 100 random numbers from 1 to 100 on the queue
lapply(1:100,function(x) to.logger(logger,sample(1:100,1),asString=F,'clientID','xxx-yy-zzz'))
#enqueue the exit code
to.logger(logger,"#exit123",asString=F,'clientID','xxx-yy-zzz')
#close the connection
destroy.logger(logger)
#initialize a consumer
consumer<-initialize.consumer('tcp://localhost:61616','Q','queue:R:test')
#store the sum
env$sumx<-0
#store the numbers generated
env$numc<-NULL
#listen to the messages and apply a running total
listen(consumer,'clientID','xxx-yy-zzz',callback=function(x)
{
env$numc<-c(env$numc,x) 
env$sumx=env$sumx+x 
}
)
#destroy the consumer
destroy.consumer(consumer)
#compare the two sums
all.equal(sum(env$numc),env$sumx)
}
}
\keyword{messaging}
\keyword{logger}

