"#event_simpleName" = ProcessRollup2 FileName=cmd.exe
| !in(field="CommandLine", values=["/k echo*", "*onedrive*", "*silcollector*", "*sethc.exe*"], ignoreCase=true)
| groupBy([CommandLine], limit=20000)
| sort(_count, order=desc)