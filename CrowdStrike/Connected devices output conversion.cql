#event_simpleName=DcUsbDeviceConnected OR (#event_simpleName=*FileWritten IsOnRemovableDisk=1)
| DeviceId:=DeviceInstanceId
| DeviceId:=DiskParentDeviceInstanceId
| selfJoinFilter(field=[DeviceId, aid], where=[{#event_simpleName=*FileWritten OR #event_simpleName=DcUsbDeviceConnected},{IsOnRemovableDisk=1},{UserName=/morpheus/i}])
| ContextTimeStamp := ContextTimeStamp*1000
| EventTime := formatTime("%Y-%m-%dT%H:%M:%S.%L", field=ContextTimeStamp, timezone="UTC")
|case{
#event_simpleName=*FileWritten
| FileSizeKB:= unit:convert(Size, binary=true, to=k)
| format("%,d KB",field=["FileSizeKB"], as="FileSizeKB")
| format("%s - %s (%s)", field=[EventTime, FileName, FileSizeKB], as=FileDetails);
*;
}
| groupBy([aid, DeviceId], function=([collect([ComputerName, DevicePropertyClassName, DeviceManufacturer, DeviceProduct, FileDetails])]))