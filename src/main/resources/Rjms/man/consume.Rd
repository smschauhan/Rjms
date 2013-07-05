\name{consume}
\alias{consume}

\title{
consumes a message
}
\description{
consumes a single message every time the function is executed, from a queue with a given propertyName and propertyValue
}
\usage{
consume(obj, propertyName = NULL, propertyValue = NULL, asString = F, timeOut=0)
}

\arguments{
  \item{obj}{
a consumer as created from \code{\link{initialize.consumer}} 
}
  \item{propertyName}{
Default is \code{NULL}. This is a generic property that is used to set message headers. One property per message is allowed for now. This could easily be used for filtering messages when using topics.
}
  \item{propertyValue}{
Default is \code{NULL}. The value of the message header that is being set in propertyName.
}
  \item{asString}{
Boolean, default is F. T if you wish to read a Text message, F if an R object. 
}
  \item{timeOut}{
Numeric, specifies the time out in milliseconds. The call blocks until a message arrives, or the timeout expires. A timeout of zero never expires  
}}
\details{
Calling the consume function consumes only one single message at a time from a queue. Topics aren't currently implemented. Also, to add that a consumer can read R objects directly using the native deserialization. As of now, the consume function can only consume objects serialized in R. Usage of the function to try and read any other type of object would result in R errors.
}
\value{
returns the body of the message, an R object if asString=F and a string message if asString=T.
}

\author{
SMS Chauhan
}
\note{
No further notes.
}


\seealso{
\code{\link{initialize.consumer}}
\code{\link{destroy.consumer}}
\code{\link{listen}}
}
\examples{
\dontrun{
logger<-initialize.logger('tcp://localhost:61616',
'Q','queue:R:test')
L3 <- LETTERS[1:3]
d <- data.frame(cbind(x=1, y=1:10), fac=sample(L3, 10, 
replace=TRUE))
send.status<-to.logger(logger,d,F,'clientID','xxx-yy-zzz')
close.status<-destroy.logger(logger)
consumer<-initialize.consumer('tcp://localhost:61616',
'Q','queue:R:test')
#read a message with infinite timeout period
z<-consume(consumer,'clientID','xxx-yy-zzz')
#read a message within 100 milliseconds
#z1<-consume(consumer,'clientID','xxx-yy-zzz',100)
close.consumer<-destroy.consumer(consumer)
identical(d,z)
}
}

\keyword{ consume }
