# Toortik Triflexation [1/2]

#volatility #linux #rookti #keylogger

>Après avoir détecté des requêtes anormales sur une de nos machines, nous avons décidé de réaliser une capture de la mémoire vive. Il semblerait, que ces requêtes soient périodiques...
>
> Retrouvez le chemin du binaire executé, la période (HH:mm:ss) entre chaque execution, le nom du module kernel malveillant et le type de spyware.
>
> Format : 404CTF{/etc/passwd:01:15:00:nom:trojan}

## Analysis

I begun with the plugins `banners.Banners` and see that we have an Ubuntu memory dump.

I add this to my command to get the correct profil: `--remote-isf-url 'https://github.com/Abyss-W4tcher/volatility3-symbols/raw/master/banners/banners.json'`

The description said it's a malicious kernel module so let's try to find this module before anything.
I find it with:
```
$ /opt/volatility3/vol.py --remote-isf-url 'https://github.com/Abyss-W4tcher/volatility3-symbols/raw/master/banners/banners.json' -f ./toortik_triflexation.elf linux.hidden_modules.Hidden_modules
Volatility 3 Framework 2.26.2
Progress:  100.00		Stacking attempts finished                  
Offset	Module Name	Code Size	Taints	Load Arguments	File Output

0xffffc08dc1c0	chall	0x3000	OOT_MODULE,UNSIGNED_MODULE		N/A
```

Let's extract the module:
```
$ /opt/volatility3/vol.py --remote-isf-url 'https://github.com/Abyss-W4tcher/volatility3-symbols/raw/master/banners/banners.json' -f ./toortik_triflexation.elf linux.module_extract.ModuleExtract --base 0xffffc08dc1c0
Volatility 3 Framework 2.26.2
Progress:  100.00		Stacking attempts finished                  
Base	File Size	File output

0xffffc08dc1c0	36052	kernel_module.chall.0xffffc08dc1c0.elf
```

In the strings of the kernel module we have: `/home/user/Documents/bokit/src/keylogging.c`
Could be a keylogger

I tried to find the kernel module from this unique strings, so I goes in the recovered FS and used that: `grep -riHa "keylogging.c"`
The only find where I find that is: `c072cb1f-1d3e-4703-bd39-9fde617b2b8d/snap/firefox/.config/firefox_utilities`
(the hash of the file is not known on virustotal, but not the same hash as the previously extracted kernel)
In the same folder we have a logs file (and a .bash_history and .parameters and config-firefox)
In the logs file we have: `e ariane _MAJ__MAJ__MAJ__MAJ__MAJ__MAJ__MAJ__MAJ__MAJ__MAJ_6`

In the .parameters file we have:
```
-----BEGIN CERTIFICATE-----
MIIDkTCCAnmgAwIBAgIUEx5UBmFHOPxY3yrwCOYBKEDiCo4wDQYJKoZIhvcNAQEL
BQAwWDELMAkGA1UEBhMCQVUxEzARBgNVBAgMClNvbWUtU3RhdGUxITAfBgNVBAoM
GEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDERMA8GA1UEAwwIMTAuMC4yLjQwHhcN
MjUwMjI3MTc0MzMyWhcNMjYwMjI3MTc0MzMyWjBYMQswCQYDVQQGEwJBVTETMBEG
A1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50ZXJuZXQgV2lkZ2l0cyBQdHkg
THRkMREwDwYDVQQDDAgxMC4wLjIuNDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAKvMDzerlYec93KkDJop9rGy2CI70vkKdqMcmwou6QAGGk1VNOlzfCSB
A9mkhAipaL4BWxCgkkjlNJ/ZhRj5y89GALT/2aA93VVlVjgNk/AXT7LM1QLIuNu+
OjuInlqqqrjKJJC+pCt77Apy0DvWODJ6Wu64yJjKMteI2taXuVtDMWYKGUZGhUfj
SE/iyia/yCSQAP72sLw9VharcJYwU/aXIoWRbOnLhPMkkb15FqvUh8I/Lojci3bw
xoYDygcgguVj4Pbxk+xJn+CuHxUo9ckoZ90OTOHq/Pt6jVs1dOqBqcErzOOmWLlY
Aqgl9UCLy+jJwIgtKxj9+i8vfrSr638CAwEAAaNTMFEwHQYDVR0OBBYEFEk70eaD
fEN6nc0B6BEAilzaj1UfMB8GA1UdIwQYMBaAFEk70eaDfEN6nc0B6BEAilzaj1Uf
MA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBAGYeDRfS867hg2NI
tXY0jMRZMdyYCgTyVi0rrzfO8qxczHKFk23TwdL7OzCmo2IS+65uPMhN53DdDhOz
WMvBOWpLS7thIVILkCASW0jkrlPHdeywi4TTfw6w+6e3pD10tunFMRgzSuhuGche
HdBm4rr9cdb8Jf0ig7mG79JID3SocpGgZpGI8gBUg2m35sSaC+n6+9k/tYsR4Os/
wY+PRRGwd6P51Xh9zuTO3leSQabYaFZUMKQCg0uTcsTZzATBLhHgjLESaSUj/ytD
/dxEu8f700YHKA7FRfH4irkT+PR8OLouo1SXKYUgXWI9ygTl1BxyatK74B0rMuYU
0AjPu1A=
-----END CERTIFICATE-----
```

I know wireshark was running on the machine so I loked for wireshark file, I just looked at the strings of the config-firefox file and find some interesting strings like:
```
/snap/firefox/.config/.parameters
curl_easy_perform() failed: %s
/snap/firefox/.config/logs
/tmp/
SSLKEYLOGFILE
https://10.0.2.4:8080
;*3$"
GCC: (GNU) 14.2.1 20250207
test.c
```
Seems like the data are send encrypted via the certificate in the parameters file to the IP 10.0.2.4:8080

Doing strings on firefox_utilities give us:
```
module.h
chall.mod.c
chall.mod.c
```
syslog:2025-05-03T13:00:01.568865+00:00 Ubuntu2 CRON[3789]: (root) CMD (/snap/firefox/.config/config-firefox)


404CTF{/snap/firefox/.config/firefox_utilities:00:04:00:chall:keylogger}
