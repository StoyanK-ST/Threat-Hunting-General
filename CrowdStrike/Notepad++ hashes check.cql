#event_simpleName=PeVersionInfo ImageFileName="*notepad++.exe"
| groupBy([SHA256HashData, FileName, FileVersion, CompanyName],
          function=([
            count(ComputerName, as=DeviceCount, distinct=true),
            collect([ComputerName])
          ])
        )