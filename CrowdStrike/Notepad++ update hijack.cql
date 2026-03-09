#event_simpleName=ProcessRollup2 FileName="regsvr32.exe"
| event_platform="Win"
| (ParentBaseFileName="notepad++*" OR (ParentBaseFileName="setup.exe" AND 
CommandLine="*notepad++*") OR CommandLine="*npp*" OR CommandLine="*installer*")
| (ImageFileName!="C:\\Windows\\System32\\regsvr32.exe" OR
ImageFileName!="C:\\Windows\\SysWOW64\\regsvr32.exe")
| groupBy([SHA256HashData, ImageFileName, ParentBaseFileName, UserSid, CommandLine],
    function=[
      count(aid, as=ExecutionCount, distinct=true),
      collect([ComputerName]),
      collect([ParentCommandLine]),
      collect([CommandLine])
    ]
)