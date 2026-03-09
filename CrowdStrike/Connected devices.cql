This query shows a summary of the devices connected in the past seven days with details for each device. The report auto sorts newest to oldest based on the DeviceTime. However, sorting on the “Device ID” will group devices with the same fingerprint together in the results:
#event_simpleName=DcUsbDeviceConnected
| DevicePropertyDeviceDescription = "USB Mass Storage Device"
| rename([[ComputerName, "Host Name"], [DevicePropertyClassName, "Connection Type"], [DeviceManufacturer, "Manufacturer"], [DeviceProduct, "Product Name"], [DevicePropertyDeviceDescription, "Description"], [DeviceInstanceId, "Device ID"]])
| DeviceTimeStamp := DeviceTimeStamp*1000
| DeviceTime := formatTime("%Y/%m/%d %H:%M:%S", field=DeviceTimeStamp, locale=en_US, timezone="UTC")
| table([DeviceTime, "Host Name", "Connection Type", "Manufacturer", "Product Name", "Description", "Device ID"])