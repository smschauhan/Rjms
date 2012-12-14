library(Rjms)
logger<-initialize.logger('tcp://localhost:61616', 'Q','queue:R:test')
consumer<-initialize.consumer('tcp://localhost:61616', 'Q','queue:R:test')
result.list<-c()
run.case<-function(id, logger, consumer, in.message, in.asString, in.propertyName, in.propertyValue, out.asString, out.propertyName, out.propertyValue,result.list)
{
send.status<-to.logger(logger,in.message, in.asString, in.propertyName, in.propertyValue)
result<-consume(consumer, out.propertyName, out.propertyValue, out.asString)
result.list<-c(result.list, paste(id, result,sep=":"))
}

#test case 1
result.list<-run.case(1,logger, consumer, "HELLO", T, "clientID","xxx-yy-zzz",T,"clientID","xxx-yy-zzz",result.list)
#test case 2
result.list<-run.case(2,logger, consumer, "HELLO", T, NULL,"xxx-yy-zzz",T,NULL,"xxx-yy-zzz",result.list)
#test case 3
result.list<-run.case(3,logger, consumer, "HELLO", T, "clientID",NULL,T,"clientID",NULL,result.list)
#test case 4
result.list<-run.case(4,logger, consumer, "HELLO", T, NULL,NULL,T,NULL,NULL,result.list)
#test case 5
result.list<-run.case(5,logger, consumer, "HELLO", F, "clientID","xxx-yy-zzz",F,"clientID","xxx-yy-zzz",result.list)
#test case 6
result.list<-run.case(6,logger, consumer, "HELLO", F, NULL,"xxx-yy-zzz",F,NULL,"xxx-yy-zzz",result.list)
#test case 7
result.list<-run.case(7,logger, consumer, "HELLO", F, "clientID",NULL,F,"clientID",NULL,result.list)
#test case 8
result.list<-run.case(8,logger, consumer, "HELLO", F, NULL,NULL,F,NULL,NULL,result.list)
#test case 9
result.list<-run.case(9,logger, consumer, "HELLO", T, "clientID","xxx-yy-zzz",T,NULL,NULL,result.list)
#test case 10
result.list<-run.case(10,logger, consumer, "HELLO", T, NULL,"xxx-yy-zzz",T,"clientID",NULL,result.list)
#test case 11
result.list<-run.case(11,logger, consumer, "HELLO", T, "clientID",NULL,T,NULL,"xxx-yy-zzz",result.list)
#test case 12
result.list<-run.case(12,logger, consumer, "HELLO", T,NULL,NULL,T,"clientID","xxx-yy-zzz",result.list)
#test case 13
result.list<-run.case(13,logger, consumer, "HELLO", F, "clientID","xxx-yy-zzz",F,NULL,NULL,result.list)
#test case 14
result.list<-run.case(14,logger, consumer, "HELLO", F, NULL,"xxx-yy-zzz",F,"clientID",NULL,result.list)
#test case 15
result.list<-run.case(15,logger, consumer, "HELLO", F, "clientID",NULL,F,NULL,"xxx-yy-zzz",result.list)
#test case 16
result.list<-run.case(16,logger, consumer, "HELLO", F,NULL,NULL,F,"clientID","xxx-yy-zzz",result.list)
#test case 17
result.list<-run.case(17,logger, consumer, "HELLO", F,"clientID","xxx-yy-zzz",F,"clientID","xxx-yy-zzx",result.list)
#test case 18
result.list<-run.case(18,logger, consumer, "HELLO", T,"clientID","xxx-yy-zzz",T,"clientID","xxx-yy-zzx",result.list)