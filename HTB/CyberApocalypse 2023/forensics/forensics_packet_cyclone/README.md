1. for this challenge we have a docker running, when we connect we see the following message :

```
nc 165.232.100.46 31035

+----------------+-------------------------------------------------------------------------------+
|     Title      |                                  Description                                  |
+----------------+-------------------------------------------------------------------------------+
| Packet Cyclone |           Pandora's friend and partner, Wade, is the one that leads           |
|                |                  the investigation into the relic's location.                 |
|                |         Recently, he noticed some weird traffic coming from his host.         |
|                |             That led him to believe that his host was compromised.            |
|                | After a quick investigation, his fear was confirmed. Pandora tries now to see |
|                |  if the attacker caused the suspicious traffic during the exfiltration phase. |
|                |             Pandora believes that the malicious actor used rclone             |
|                |                  to exfiltrate Wade's research to the cloud.                  |
|                |     Using the tool chainsaw and many sigma rules that can be found online,    |
|                |   can you detect the usage of rclone from the event logs produced by Sysmon?  |
|                |                 To get the flag, you need to start and connect                |
|                |         to the docker service and answer all the questions correctly.         |
+----------------+-------------------------------------------------------------------------------+
```

2. The description told us to use chainsaw, so I git clone chainsaw then I did this command (I used the simgma rules given in the zip file) :

```
./chainsaw/chainsaw hunt -r rules ../Logs -s ../sigma_rules --mapping mappings/sigma-event-logs-all.yml
```

3. With the result of the chainsaw command I answered all the questions :

```
What is the email of the attacker used for the exfiltration process? (for example: name@email.com)
> majmeret@protonmail.com
[+] Correct!

What is the password of the attacker used for the exfiltration process? (for example: password123)
> FBMeavdiaFZbWzpMqIVhJCGXZ5XXZI1qsU3EjhoKQw0rEoQqHyI
[+] Correct!

What is the Cloud storage provider used by the attacker? (for example: cloud)
> mega
[+] Correct!

What is the ID of the process used by the attackers to configure their tool? (for example: 1337)
> 3820
[+] Correct!

What is the name of the folder the attacker exfiltrated; provide the full path. (for example: C:\Users\user\folder)
> C:\Users\wade\AppData\Local\Temp\rclone-v1.61.1-windows-amd64\
[-] Wrong Answer.
What is the name of the folder the attacker exfiltrated; provide the full path. (for example: C:\Users\user\folder)

> C:\Users\wade\AppData\Local\Temp\rclone-v1.61.1-windows-amd64 
[-] Wrong Answer.
What is the name of the folder the attacker exfiltrated; provide the full path. (for example: C:\Users\user\folder)

> C:\Users\Wade\Desktop\Relic_location\
[-] Wrong Answer.
What is the name of the folder the attacker exfiltrated; provide the full path. (for example: C:\Users\user\folder)
Please wait 1 seconds..
> C:\Users\Wade\Desktop\Relic_location 
[+] Correct!

What is the name of the folder the attacker exfiltrated the files to? (for example: exfil_folder)
> exfiltration
[+] Correct!

[+] Here is the flag: HTB{3v3n_3xtr4t3rr3str14l_B31nGs_us3_Rcl0n3_n0w4d4ys}
```