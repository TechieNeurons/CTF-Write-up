# Analyse mémoire 1/5 - Exfiltration
> Ce challenge est en 5 parties se débloquant en cascade, selon le découpage suivant :
>
>     Analyse mémoire 1/5 - Exfiltration ⭐ (score dynamique débutant à 250 points) ;
>     Analyse mémoire 2/5 - Origine de la menace ⭐ (score static à 100 points) ;
>     Analyse mémoire 3/5 - Où est le pansement ? ⭐⭐⭐ (score dynamique débutant à 250 points) ;
>     Analyse mémoire 4/5 - Un échelon de plus dans la chaîne ⭐⭐⭐ (score dynamique débutant à 250 points) ;
>     Analyse mémoire 5/5 - Le commencement ⭐⭐ (score dynamique débutant à 250 points).
>
> Un agent du FCSC démarre son ordinateur pour réfléchir et noter des idées de challenges pour l'année prochaine. Il nous a cependant alerté que lors du démarrage, un étrange écran rouge est apparu à peine une seconde, puis le poste a démmaré normalement.
>
> Il a pu commencé son travail sans souci, mais afin de s'assurer que le problème ne vienne pas d'un potentiel malware, nous lui avons fait capturer la mémoire du poste avec l'outil DumpIt. Analysez la mémoire et retrouvez le malware qui tente d'exfiltrer le document :
>
>     le processus exécutant le malware
>     l'adresse et le port du serveur contrôlé par l'attaquant
>
> Le flag est au format FCSC{<process_name>:<process_id>:<adresse_ip_distante>:<port_distant>:<protocole utilisé>} où :
>
>     <process_name> est le nom du processus exécutant le malware,
>     <process_id> est le numéro du processus (PID) exécutant le malware,
>     <adresse_ip_distante> est l'adresse IP du serveur controlé par l'attaquant,
>     <port_distant> est le port utilisé sur le serveur controlé par l'attaquant et
>     <protocole utilisé> est le protocole utilisé pour la communication avec le serveur de l'attaquant (TCP ou UDP).
>
> Par exemple : FCSC{malware.exe:512:51.255.68.182:21:UDP}.
>
> Attention : pour cette épreuve, vous n'avez que 10 tentatives de flag.

Let's begin with a netscan

I can see this line which seems a bit suspicious:
`0xa50a29eaea60	TCPv4	10.0.2.15	49709	100.68.20.103	443	ESTABLISHED	1800	rundll32.exe	2025-04-01 22:11:15.000000 UTC`

To check I did a pstree, the PID 1800 (rundll32.exe) is a child of 936 (svchost.exe) which is a child of 800 (services.exe) all these process look legitimate but the chain is a bit weird :/ for me at least

That give us: **FCSC{rundll32.exe:1800:100.68.20.103:443:TCP}**