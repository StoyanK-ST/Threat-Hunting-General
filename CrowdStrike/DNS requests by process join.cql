#event_simpleName= ProcessRollup2
| join({#event_simpleName= DnsRequest| in("DomainName", values=["falconsplayingpoker.com", "winteriscoming.com"])}, field=[TargetProcessId], key=ContextProcessId, include=[DomainName, ContextTimeStamp])
| ContextTimeStamp:=ContextTimeStamp*1000
| EventTime:=formatTime("%Y-%m-%dT%H:%M:%S.%L", field=ContextTimeStamp, timezone="UTC")
| table([EventTime, ComputerName, UserName, DomainName, FileName, ImageFileName, CommandLine])