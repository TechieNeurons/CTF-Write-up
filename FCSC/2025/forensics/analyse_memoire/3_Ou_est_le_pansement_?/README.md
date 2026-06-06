#  Analyse mémoire 3/5 - Où est le pansement ?
> Le processus à l'origine du malware parait légitime. L'attaquant a certainement dû le modifier pour injecter son code et exécuter sa chaine de compromission. Retrouvez le Thread malveillant. À partir de là, retrouvez l'adresse virtuelle de la PTE modifiée par l'attaquant.
>
> Le flag est au format FCSC{<thread_id>:<virtual_address>} où :
>
>     <thread_id> est l'identifiant du Thread (TID) malveillant et
>     <virtual_address> est l'adresse virtuelle (dans le contexte du processus malveillant) du début de la page mémoire (PTE) modifiée, au format 0x%016x.
>
> Par exemple : FCSC{420:0x0022446688aaccee}.
>
> Attention : pour cette épreuve, vous n'avez que 10 tentatives de flag.

I checked the Threads of the process:
/opt/volatility3/vol.py -f analyse-memoire.dmp windows.threads.Threads | grep 936
Offset	PID	TID	StartAddress	CreateTime	ExitTime
0xa50a26103080	936	940	0x7ffd16e9cc70	2025-04-01 22:10:44.000000 UTC	1600-09-07 05:53:23.000000 UTC
0xa50a26147040	936	500	0x7ffd16e9cc70	2025-04-01 22:10:44.000000 UTC	1600-09-07 05:53:23.000000 UTC
0xa50a2619c080	936	620	0xb88513975c60	2025-04-01 22:10:44.000000 UTC	1600-09-07 05:53:23.000000 UTC
0xa50a26224080	936	872	0x7ffd16e9cc70	2025-04-01 22:10:44.000000 UTC	1600-09-07 05:53:23.000000 UTC
0xa50a26211080	936	472	0x7ffd16e9cc70	2025-04-01 22:10:44.000000 UTC	1600-09-07 05:53:23.000000 UTC
0xa50a2620b080	936	1028	0x7ffd16e9cc70	2025-04-01 22:10:44.000000 UTC	1600-09-07 05:53:23.000000 UTC
0xa50a209d0080	936	1416	0x7ffd16e9cc70	2025-04-01 22:10:45.000000 UTC	1600-09-07 05:53:13.000000 UTC
0xa50a1f94f080	936	4500	0x7ffd16e9cc70	2025-04-01 22:10:52.000000 UTC	1600-09-07 05:53:12.000000 UTC
0xa50a2978b080	936	7148	0x7ffd16e9cc70	2025-04-01 22:11:01.000000 UTC	1600-09-07 05:53:28.000000 UTC
0xa50a29dc2080	936	7484	0x7ffd16e9cc70	2025-04-01 22:15:01.000000 UTC	1600-09-07 05:53:29.000000 UTC
0xa50a1f8f3040	936	1296	0x7ffd16e9cc70	2025-04-01 22:17:50.000000 UTC	1600-09-07 05:53:12.000000 UTC

/opt/volatility3/vol.py -f analyse-memoire.dmp windows.threads.Threads | grep 1800
Offset	PID	TID	StartAddress	CreateTime	ExitTime
0xa50a270b6080.01800	1804	0xb88513e56ca0	2025-04-01 22:10:45.000000 UTC	1600-09-07 05:53:24.000000 UTC
0xa50a274b2080	1800	2760	0x7ffd16e9cc70	2025-04-01 22:10:46.000000 UTC	1600-09-07 05:53:25.000000 UTC
0xa50a274ab080	1800	2796	0x7ffd16e9cc70	2025-04-01 22:10:46.000000 UTC	2025-04-01 22:15:18.000000 UTC
0xa50a274a8080	1800	2872	0x7ffd16e9cc70	2025-04-01 22:10:46.000000 UTC	1600-09-07 05:53:25.000000 UTC
0xa50a2970f080	1800	7372	0x7ffd16e9cc70	2025-04-01 22:15:25.000000 UTC	1600-09-07 05:53:28.000000 UTC

This: https://github.com/f-block/volatility-plugins --> Not's working