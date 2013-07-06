.onLoad <- function(libname, pkgname) {
    .jpackage(pkgname, lib.loc = libname)
}

initialize.logger <- function(url, type, name) {
    obj <- .jnew("org/math/r/activemq/logger/Producer", url, type, name)
    return(obj)
}
to.logger <- function(obj, log, asString = F, propertyName = NULL, propertyValue = NULL) {
    if (is.null(propertyName) || is.null(propertyValue)) 
       {
        	propertyName <- .jnull("java/lang/String")
        	propertyValue <- .jnull("java/lang/String")
    	}
    
    if (asString) 
        out <- .jcall(obj, "Z", "send", log, propertyName, propertyValue) 
    else 
    	out <- .jcall(obj, "Z", "send", serialize(log, connection=NULL), propertyName, propertyValue)
    return(out)
}
destroy.logger <- function(obj) {
    out <- .jcall(obj, "Z", "destroy")
}
initialize.consumer <- function(url, type, name) {
    obj <- .jnew("org/math/r/activemq/logger/Consumer", url, type, name)
    return(obj)
}
consume <- function(obj, propertyName = NULL, propertyValue = NULL, asString = F, timeOut=0) {
   if (is.null(propertyName) || is.null(propertyValue)) 
       {
        	propertyName <- .jnull("java/lang/String")
        	propertyValue <- .jnull("java/lang/String")
    	}
    out <- .jcall(obj, "[B", "consume", propertyName, propertyValue, .jlong(timeOut))
    if (is.jnull(out)) 
        message <- NULL else {
        if (!asString) 
            message <- unserialize(out,NULL) else message <- .jcall(.jnew("java/lang/String", out), "S", "toString")
    }
    return(message)
}
destroy.consumer <- function(obj) {
    out <- .jcall(obj, "Z", "destroy")
}

listen <- function(consumer, property, value, asString, exitCode = "#exit123", callback = printCallback, 
    ...) {
    # default callback, prints the received messages
    printCallback <- function(x) print(x)
    
    # consume the first message and initialize x
    x <- consume(consumer, property, value, asString)
    
    # keep consuming messages until an escape signal is received
    while (typeof(x) != typeof(exitCode)) {
        # do not callback if an escape signal is received
        if (typeof(x) != typeof(exitCode) && x != exitCode) 
            callback(x, ...)
        
        # keep consuming messages
        x <- consume(consumer, property, value, asString)
    }
}
