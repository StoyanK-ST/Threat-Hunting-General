#event_simpleName=ProcessRollup2
| join({#event_simpleName=NetworkConnectIP4 RemoteAddressIP4=1.1.1.1}, field=[TargetProcessId], key=ContextProcessId,include=[LocalAddressIP4, ContextTimeStamp, RemoteAddressIP4, aip])
| ContextTimeStamp:=ContextTimeStamp*1000
| EventTime:=formatTime("%Y-%m-%dT%H:%M:%S.%L", field=ContextTimeStamp, timezone="UTC")
| table([EventTime,LocalAddressIP4, RemoteAddressIP4, aip, ComputerName, UserName,ParentProcessId, RawProcessId, TargetProcessId, FileName, MD5HashData, SHA256HashData, aid, cid])