# Analyse mémoire - Pour commencer (1/2)
> Vous vous préparez à analyser une capture mémoire et vous notez quelques informations sur la machine avant de plonger dans l'analyse :
> 
>     nom d'utilisateur,
>     nom de la machine,
>     adresse IPv4, non locale, de la machine.
> 
> Le flag est au format FCSC{<nom d'utilisateur>:<nom de la machine>:<adresse IPv4>} où :
> 
>     <nom d'utilisateur> est le nom de l'utilisateur qui utilise la machine,
>     <nom de la machine> est le nom de la machine analysée et
>     <adresse IPv4> est l'adresse IPv4, non locale, de la machine.
> 
> Par exemple : FCSC{Arthur:Ordinateur-de-rct:192.168.1.150}.
> 
> Attention : pour cette épreuve, vous n'avez que 10 tentatives de flag.

- To get the IP: `/opt/volatility3/vol.py -f ./analyse-memoire.dmp windows.netscan.NetScan` the IP is **10.0.2.15** (check the localAddr column)
- To get the username: `/opt/volatility3/vol.py -f ./analyse-memoire.dmp windows.hashdump` (for example), the user is **userfcsc-10**
- To get the computername: `/opt/volatility3/vol.py -f ./analyse-memoire.dmp windows.registry.hivelist.HiveList` (to get the offset of SYSTEM, 0xb88510266000), then `/opt/volatility3/vol.py -f ./analyse-memoire.dmp windows.registry.printkey.PrintKey --offset 0xb88510266000 --key 'ControlSet001\Control\ComputerName\ComputerName'` and we get the computername: **DESKTOP-JV996VQ**

We have the flag: **FCSC{userfcsc-10:DESKTOP-JV996VQ:10.0.2.15}**