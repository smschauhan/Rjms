\name{Rjms-package}
\alias{Rjms-package}
\alias{Rjms}
\docType{package}
\title{
R package to send messages to activeMQ
}
\description{
The package can be used to fire messages to an activeMQ queue or topic. It has a wide variety of applications. One such common application is firing messages during processes with a large number of iterations. R does not provide the ability to interact with it while a certain piece of code is executing. This is where Rjms plays an important role - it enables you to see what's going on under the hood. 
Recently, the capabiltiy to consume messages has also been added, with the limitation of listening messages to a specified queue. Topics haven't been implemented yet due to the lack of a clean callback capability. 
In the iteration example, it's possible to fire intermediately results at the end of each iteration. These messages can either be viewed directly using the activeMQ web console, or a certain monitoring application can be built around it using Message Oriented Middleware.

ActiveMQ is commonly used to implement basic elements of Enterprise Integrations patterns.
}
\details{
\tabular{ll}{
Package: \tab Rjms\cr
Type: \tab Package\cr
Version: \tab 0.0.4\cr
Date: \tab 2012-12-13\cr
License: \tab LGPL-3\cr
LazyLoad: \tab yes\cr
}
The package is pretty straightforward to use. 
Three steps: \cr
1) Create a connection\cr
This is accomplished by calling the R function:\cr
\code{logger<-initialize.logger(url,type,name)}

2) Send a message, or more messages \cr
Once the logger is initialized, you can begin logging messages. The logger can send message both as a string or a serialized R Object, set to T for a string.The second step would be:\cr
\code{result<-to.logger(logger,'Hello dolly.',T, propertyName, propertyValue)}

3) Kill the connection \cr 
Dormant connections can slow down the system. It's always good to cleanup.:\cr
\code{result<-destroy.logger(logger)}

Each function results a boolean - true if successful.
}
\author{
SMS Chauhan <smschauhan@gmail.com>, Zubin Dowlaty <zubin@dowlaty.com>

Maintainer: SMS Chauhan <smschauhan@gmail.com>
}
\references{
Apache ActiveMQ: Apache ActiveMQ is the most popular and powerful open source messaging and Integration Patterns provider.Apache ActiveMQ is fast, supports many Cross Language Clients and Protocols, comes with easy to use Enterprise Integration Patterns and many advanced features while fully supporting JMS 1.1 and J2EE 1.4. Apache ActiveMQ is released under the Apache 2.0 License. It is available at: \url{http://activemq.apache.org/}
}

\keyword{ Rjms }
\keyword{messaging}
\keyword{logger}

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
