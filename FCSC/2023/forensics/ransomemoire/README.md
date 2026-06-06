# Intro

> Ce challenge est en 4 parties, selon le découpage initial suivant :
>> Ransomémoire 0/3 - Pour commencer :
>>> 500 points de départ
>> Ransomémoire 1/3 - Mon précieux :
>>> 500 points de départ
>> Ransomémoire 2/3 - Début d'investigation :
>>> 500 points de départ
>>> débloqué après Ransomémoire 1/3 - Mon précieux
>> Ransomémoire 3/3 - Doppelgänger :
>>> 500 points de départ

Fichier :
- SHA256([fcsc.7z](https://drive.google.com/file/d/1jMoc88y_PzsVQv4EbPE2qcXxHFEwHZVq/view?usp=share_link)) = 754cb093af343356827d650270f9faa56cc4c44f44243ea08590edb1bc270b5e

# 0/3

>Vous vous préparez à analyser une capture mémoire et vous notez quelques informations sur la machine avant de plonger dans l'analyse :
>> nom d'utilisateur,
>> nom de la machine,
>> navigateur utilisé.
> Le flag est au format FCSC{<nom d'utilisateur>:<nom de la machine>:<nom du navigateur>} où :
>> <nom d'utilisateur> est le nom de l'utilisateur qui utilise la machine,
>> <nom de la machine> est le nom de la machine analysée et
>> <nom du navigateur> est le nom du navigateur en cours d'exécution.
> Par exemple : FCSC{toto:Ordinateur-de-jojo:Firefox}.

1. Navigateur (brave) :

```
python /opt/vol3/vol.py -f fcsc.dmp windows.cmdline
```

2. Computername (DESKTOP-PI234GP) :

```
python /opt/vol3/vol.py -f fcsc.dmp windows.envars | grep -i computer
```

3. User (Admin) :


```
python /opt/vol3/vol.py -f fcsc.dmp windows.envars | grep -i user
```

# 1/3

> Vous étiez en train de consulter vos belles photos de chats quand patatra, votre fichier super secret sur votre Bureau change d'extension et devient illisible...
> Vous faites une capture mémoire pour comprendre ce qu'il s'est passé, dans le but de récupérer ce précieux fichier.

0x818689b077d0
strings give us : C:\Users\Admin\Desktop\flag.fcsc but not find by vol3...
Avec vol2 : 

```
python /opt/vol2/vol.py -f fcsc.dmp --profile=Win10x64_19041 mftparser >> mfttable.txt
$FILE_NAME
Creation                       Modified                       MFT Altered                    Access Date                    Name/Path
------------------------------ ------------------------------ ------------------------------ ------------------------------ ---------
2023-04-17 17:23:45 UTC+0000 2023-04-17 17:23:50 UTC+0000   2023-04-17 17:23:50 UTC+0000   2023-04-17 17:23:50 UTC+0000   Users\Admin\Desktop\flag.fcsc.enc

$DATA
0000000000: 3b 65 17 19 64 03 71 9f dd 1a 30 ec 37 ba 83 c9   ;e..d.q...0.7...
0000000010: 1b b0 44 c9 8d 05 45 88 ff 41 40 d6 32 e5 61 09   ..D...E..A@.2.a.
0000000020: 5f f2 32 07 44 6a 8d 05 c7 fe 82 2f 22 76 9a 08   _.2.Dj...../"v..
0000000030: 32 28 7a ad ff 90 c8 4d 96 ca 99 54 1c 2c 58 f7   2(z....M...T.,X.
0000000040: 7a 8b e5 c5 5d 51 5a                              z...]QZ

***************************************************************************
***************************************************************************
MFT entry found at offset 0x1327800
Attribute: In Use & File
Record Number: 96166
Link count: 1
```


# 2/3

# 3/3

> Vous ne comprenez pas comment l'agent que vous avez trouvé dans Ransomémoire 2/3 - Début d'investigation a pu se retrouver sur la machine (Note : il n'est pas nécessaire d'avoir résolu ce challenge pour résoudre Ransomémoire 3/3 - Doppelgänger). Vous suspectez la présence d'un agent dormant, qui se cache en mémoire...
> Le flag est au format FCSC{<pid>:<ip>:<port>} où :
>> <pid> est l'ID du processus malveillant et
>> <ip> et <port> sont les paramètres de la connexion avec le C2.

1. 

``` 
python /opt/vol3/vol.py -f fcsc.dmp windows.netstat

Volatility 3 Framework 2.4.2
Progress:  100.00		PDB scanning finished                        
Offset	Proto	LocalAddr	LocalPort	ForeignAddr	ForeignPort	State	PID	Owner	Created

0x8186882b3010	TCPv4	10.0.2.15	50067	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:12.000000 
0x818688796320	TCPv4	10.0.2.15	50076	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x818688515560	TCPv4	10.0.2.15	50055	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:07.000000 
0x818688796a20	TCPv4	10.0.2.15	50082	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x818688389010	TCPv4	10.0.2.15	50056	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:07.000000 
0x8186882a7a20	TCPv4	10.0.2.15	49836	192.168.1.106	443	CLOSE_WAIT	6808	brave.exe	2023-04-17 17:16:51.000000 
0x818688040b50	TCPv4	10.0.2.15	49807	20.199.120.151	443	ESTABLISHED	728	svchost.exe	2023-04-17 17:16:17.000000 
0x818684b27400	TCPv4	10.0.2.15	50066	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:12.000000 
0x818688d44050	TCPv4	10.0.2.15	50074	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x8186889fd010	TCPv4	10.0.2.15	50053	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:07.000000 
0x8186875d94b0	TCPv4	10.0.2.15	50077	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x8186887cba20	TCPv4	10.0.2.15	49850	20.199.120.151	443	ESTABLISHED	728	svchost.exe	2023-04-17 17:18:10.000000 
0x8186880c68a0	TCPv4	10.0.2.15	50087	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:37.000000 
0x818688554950	TCPv4	10.0.2.15	50059	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:08.000000 
0x8186882d9b50	TCPv4	10.0.2.15	50072	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x818688033620	TCPv4	10.0.2.15	50050	152.199.19.74	80	ESTABLISHED	1748	CompatTelRunne	2023-04-17 17:23:54.000000 
0x818687f9e010	TCPv4	10.0.2.15	50071	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x81868489d640	TCPv4	10.0.2.15	50089	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:37.000000 
0x8186880b8010	TCPv4	10.0.2.15	8080	10.0.2.2	43543	ESTABLISHED	3144	brave.exe	2023-04-17 17:18:48.000000 
0x8186880e8010	TCPv4	10.0.2.15	50051	192.229.221.95	80	ESTABLISHED	1748	CompatTelRunne	2023-04-17 17:23:54.000000 
0x818687755010	TCPv4	10.0.2.15	50058	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:08.000000 
0x818684f3fac0	TCPv4	10.0.2.15	50078	93.184.221.240	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x818686db6010	TCPv4	10.0.2.15	50075	95.100.85.138	80	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:22.000000 
0x818687fa6050	TCPv4	10.0.2.15	50088	23.52.250.184	443	ESTABLISHED	4852	svchost.exe	2023-04-17 17:24:37.000000 
0x818682fd5e90	TCPv4	0.0.0.0	135	0.0.0.0	0	LISTENING	948	svchost.exe	2023-04-16 21:46:22.000000 
0x818682fd5e90	TCPv6	::	135	::	0	LISTENING	948	svchost.exe	2023-04-16 21:46:22.000000 
0x818682fd5bd0	TCPv4	0.0.0.0	135	0.0.0.0	0	LISTENING	948	svchost.exe	2023-04-16 21:46:22.000000 
0x818684ae41b0	TCPv4	10.0.2.15	139	0.0.0.0	0	LISTENING	4	System	2023-04-17 17:16:09.000000 
0x818686fbfcb0	TCPv4	0.0.0.0	445	0.0.0.0	0	LISTENING	4	System	2023-04-16 21:46:57.000000 
0x818686fbfcb0	TCPv6	::	445	::	0	LISTENING	4	System	2023-04-16 21:46:57.000000 
0x818686fc0650	TCPv4	0.0.0.0	5040	0.0.0.0	0	LISTENING	1288	svchost.exe	2023-04-16 21:47:17.000000 
0x818686fc0230	TCPv4	0.0.0.0	7680	0.0.0.0	0	LISTENING	4852	svchost.exe	2023-04-16 21:47:22.000000 
0x818686fc0230	TCPv6	::	7680	::	0	LISTENING	4852	svchost.exe	2023-04-16 21:47:22.000000 
0x818682fd5a70	TCPv4	0.0.0.0	49664	0.0.0.0	0	LISTENING	716	lsass.exe	2023-04-16 21:46:22.000000 
0x818682fd5a70	TCPv6	::	49664	::	0	LISTENING	716	lsass.exe	2023-04-16 21:46:22.000000 
0x818682fd41b0	TCPv4	0.0.0.0	49664	0.0.0.0	0	LISTENING	716	lsass.exe	2023-04-16 21:46:22.000000 
0x818682fd5d30	TCPv4	0.0.0.0	49665	0.0.0.0	0	LISTENING	572	wininit.exe	2023-04-16 21:46:22.000000 
0x818682fd5d30	TCPv6	::	49665	::	0	LISTENING	572	wininit.exe	2023-04-16 21:46:22.000000 
0x818682fd5230	TCPv4	0.0.0.0	49665	0.0.0.0	0	LISTENING	572	wininit.exe	2023-04-16 21:46:22.000000 
0x818682fd4e10	TCPv4	0.0.0.0	49666	0.0.0.0	0	LISTENING	1120	svchost.exe	2023-04-16 21:46:23.000000 
0x818682fd4e10	TCPv6	::	49666	::	0	LISTENING	1120	svchost.exe	2023-04-16 21:46:23.000000 
0x818682fd5390	TCPv4	0.0.0.0	49666	0.0.0.0	0	LISTENING	1120	svchost.exe	2023-04-16 21:46:23.000000 
0x818682fd45d0	TCPv4	0.0.0.0	49667	0.0.0.0	0	LISTENING	728	svchost.exe	2023-04-16 21:46:23.000000 
0x818682fd45d0	TCPv6	::	49667	::	0	LISTENING	728	svchost.exe	2023-04-16 21:46:23.000000 
0x818682fd4470	TCPv4	0.0.0.0	49667	0.0.0.0	0	LISTENING	728	svchost.exe	2023-04-16 21:46:23.000000 
0x81867fca61b0	TCPv4	0.0.0.0	49668	0.0.0.0	0	LISTENING	860	spoolsv.exe	2023-04-16 21:46:56.000000 
0x81867fca61b0	TCPv6	::	49668	::	0	LISTENING	860	spoolsv.exe	2023-04-16 21:46:56.000000 
0x81867fca6050	TCPv4	0.0.0.0	49668	0.0.0.0	0	LISTENING	860	spoolsv.exe	2023-04-16 21:46:56.000000 
0x818686fbf1b0	TCPv4	0.0.0.0	49669	0.0.0.0	0	LISTENING	696	services.exe	2023-04-16 21:46:57.000000 
0x818686fbf1b0	TCPv6	::	49669	::	0	LISTENING	696	services.exe	2023-04-16 21:46:57.000000 
0x818686fbf730	TCPv4	0.0.0.0	49669	0.0.0.0	0	LISTENING	696	services.exe	2023-04-16 21:46:57.000000 
0x818686fc00d0	TCPv4	0.0.0.0	49670	0.0.0.0	0	LISTENING	2252	svchost.exe	2023-04-16 21:47:00.000000 
0x818686fc00d0	TCPv6	::	49670	::	0	LISTENING	2252	svchost.exe	2023-04-16 21:47:00.000000 
0x818686fbfe10	TCPv4	0.0.0.0	49670	0.0.0.0	0	LISTENING	2252	svchost.exe	2023-04-16 21:47:00.000000 
0x818687574d10	UDPv4	10.0.2.15	137	*	0		4	System	2023-04-17 17:16:09.000000 
0x8186875722e0	UDPv4	10.0.2.15	138	*	0		4	System	2023-04-17 17:16:09.000000 
0x818687030830	UDPv4	0.0.0.0	500	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x818687030830	UDPv6	::	500	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x818687031320	UDPv4	0.0.0.0	500	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x8186884550f0	UDPv6	fe80::b5bb:163f:5627:748f	1900	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x818688463060	UDPv6	::1	1900	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x8186884679d0	UDPv4	10.0.2.15	1900	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x818688468330	UDPv4	127.0.0.1	1900	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x818687031c80	UDPv4	0.0.0.0	4500	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x818687031c80	UDPv6	::	4500	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x818687030ce0	UDPv4	0.0.0.0	4500	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x818687920c10	UDPv4	0.0.0.0	5050	*	0		1288	svchost.exe	2023-04-16 21:47:17.000000 
0x818687565c70	UDPv4	0.0.0.0	5353	*	0		1500	svchost.exe	2023-04-17 17:16:10.000000 
0x818687565c70	UDPv6	::	5353	*	0		1500	svchost.exe	2023-04-17 17:16:10.000000 
0x81868844ae70	UDPv4	0.0.0.0	5353	*	0		1500	svchost.exe	2023-04-17 17:16:10.000000 
0x8186873c3a10	UDPv4	0.0.0.0	5355	*	0		1500	svchost.exe	2023-04-17 17:16:10.000000 
0x8186873c3a10	UDPv6	::	5355	*	0		1500	svchost.exe	2023-04-17 17:16:10.000000 
0x818688459bf0	UDPv4	0.0.0.0	5355	*	0		1500	svchost.exe	2023-04-17 17:16:10.000000 
0x818687080320	UDPv4	127.0.0.1	49259	*	0		728	svchost.exe	2023-04-16 21:46:57.000000 
0x818688466d50	UDPv6	fe80::b5bb:163f:5627:748f	49413	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x818688467200	UDPv6	::1	49414	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x8186884663f0	UDPv4	10.0.2.15	49415	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x818688466a30	UDPv4	127.0.0.1	49416	*	0		756	svchost.exe	2023-04-17 17:16:08.000000 
0x818689b0ee20	UDPv4	0.0.0.0	54124	*	0		4060	brave.exe	2023-04-17 17:24:21.000000 
0x818689b13600	UDPv4	0.0.0.0	54173	*	0		4060	brave.exe	2023-04-17 17:24:47.000000 
```

```
python /opt/vol3/vol.py -f fcsc.dmp windows.pstree                        
Volatility 3 Framework 2.4.2
Progress:  100.00		PDB scanning finished                        
PID	PPID	ImageFileName	Offset(V)	Threads	Handles	SessionId	Wow64	CreateTime	ExitTime

4	0	System	0x81867fc82080	185	-	N/A	False	2023-04-16 21:46:14.000000 	N/A
* 380	4	smss.exe	0x818681879040	2	-	N/A	False	2023-04-16 21:46:14.000000 	N/A
* 1484	4	MemCompression	0x818686d72040	26	-	N/A	False	2023-04-16 21:46:23.000000 	N/A
* 108	4	Registry	0x81867fdc5040	4	-	N/A	False	2023-04-16 21:45:59.000000 	N/A
480	464	csrss.exe	0x8186848a8080	13	-	0	False	2023-04-16 21:46:20.000000 	N/A
556	548	csrss.exe	0x818684d9a140	14	-	1	False	2023-04-16 21:46:20.000000 	N/A
572	464	wininit.exe	0x818684da0080	3	-	0	False	2023-04-16 21:46:21.000000 	N/A
* 696	572	services.exe	0x818684d0a080	8	-	0	False	2023-04-16 21:46:21.000000 	N/A
** 2560	696	svchost.exe	0x81868714c240	18	-	0	False	2023-04-16 21:46:57.000000 	N/A
** 8	696	svchost.exe	0x818684fd5280	20	-	0	False	2023-04-16 21:46:22.000000 	N/A
*** 3552	8	ctfmon.exe	0x818687af1280	12	-	1	False	2023-04-16 21:47:16.000000 	N/A
** 1288	696	svchost.exe	0x818686cb12c0	22	-	0	False	2023-04-16 21:46:23.000000 	N/A
** 1164	696	svchost.exe	0x81868743c240	36	-	0	False	2023-04-16 21:47:00.000000 	N/A
** 3724	696	svchost.exe	0x8186875e0300	7	-	0	False	2023-04-16 21:47:04.000000 	N/A
** 1428	696	BraveUpdate.ex	0x818688975080	7	-	0	True	2023-04-17 17:16:41.000000 	N/A
*** 5588	1428	brave_installe	0x81868189a340	1	-	0	False	2023-04-17 17:17:45.000000 	N/A
**** 6936	5588	setup.exe	0x81867fc69080	1	-	0	False	2023-04-17 17:17:46.000000 	N/A
***** 7304	6936	setup.exe	0x818684d4c080	6	-	0	False	2023-04-17 17:17:46.000000 	N/A
** 7704	696	MsMpEng.exe	0x81868751d080	21	-	0	False	2023-04-16 21:47:59.000000 	N/A
** 7576	696	svchost.exe	0x818684b4d080	11	-	0	False	2023-04-17 17:16:51.000000 	N/A
** 6180	696	MicrosoftEdgeU	0x818688205300	6	-	0	True	2023-04-16 21:47:32.000000 	N/A
*** 6592	6180	MicrosoftEdge_	0x818687faf080	1	-	0	False	2023-04-17 17:16:33.000000 	N/A
**** 620	6592	setup.exe	0x81868814b080	2	-	0	False	2023-04-17 17:16:33.000000 	N/A
** 4392	696	svchost.exe	0x818684ad42c0	6	-	1	False	2023-04-16 21:47:19.000000 	N/A
** 1328	696	VBoxService.ex	0x818686cc4240	12	-	0	False	2023-04-16 21:46:23.000000 	N/A
** 7984	696	svchost.exe	0x818687de8080	5	-	0	False	2023-04-17 17:18:48.000000 	N/A
** 7088	696	sppsvc.exe	0x81868893f080	11	-	0	False	2023-04-17 17:24:10.000000 	N/A
** 948	696	svchost.exe	0x818684ec92c0	11	-	0	False	2023-04-16 21:46:22.000000 	N/A
** 6324	696	TrustedInstall	0x81868775a080	4	-	0	False	2023-04-17 17:22:37.000000 	N/A
** 1848	696	svchost.exe	0x818686f19240	6	-	0	False	2023-04-16 21:46:23.000000 	N/A
** 1980	696	svchost.exe	0x818686f4d2c0	4	-	0	False	2023-04-16 21:46:56.000000 	N/A
** 828	696	svchost.exe	0x818684e15240	18	-	0	False	2023-04-16 21:46:21.000000 	N/A
*** 5124	828	SearchApp.exe	0x818687e3a080	36	-	1	False	2023-04-16 21:47:22.000000 	N/A
*** 1668	828	TiWorker.exe	0x818688f0a080	3	-	0	False	2023-04-17 17:22:38.000000 	N/A
*** 6664	828	dllhost.exe	0x818688621340	6	-	1	False	2023-04-16 21:47:35.000000 	N/A
*** 7564	828	SecurityHealth	0x81868835a300	1	-	1	False	2023-04-16 21:47:49.000000 	N/A
*** 7572	828	SecHealthUI.ex	0x818688d4d300	26	-	1	False	2023-04-16 21:47:49.000000 	N/A
*** 3860	828	RuntimeBroker.	0x81868871f080	3	-	1	False	2023-04-17 17:16:57.000000 	N/A
*** 2328	828	smartscreen.ex	0x8186886cc080	8	-	1	False	2023-04-17 17:21:29.000000 	N/A
*** 6448	828	TextInputHost.	0x818688531080	10	-	1	False	2023-04-16 21:47:34.000000 	N/A
*** 6832	828	WmiPrvSE.exe	0x81868740a080	4	-	0	False	2023-04-17 17:16:32.000000 	N/A
*** 1344	828	RuntimeBroker.	0x818684b242c0	2	-	1	False	2023-04-16 21:47:30.000000 	N/A
*** 5316	828	RuntimeBroker.	0x818687dc6080	11	-	1	False	2023-04-16 21:47:23.000000 	N/A
*** 2120	828	ShellExperienc	0x8186884a7080	14	-	1	False	2023-04-17 17:16:57.000000 	N/A
*** 4812	828	StartMenuExper	0x818687c4f080	13	-	1	False	2023-04-16 21:47:21.000000 	N/A
*** 3408	828	MoUsoCoreWorke	0x818687dc5280	13	-	0	False	2023-04-16 21:47:22.000000 	N/A
*** 6868	828	ApplicationFra	0x8186889ce080	3	-	1	False	2023-04-16 21:47:37.000000 	N/A
*** 1752	828	SecurityHealth	0x818684b4e080	1	-	1	False	2023-04-16 21:48:25.000000 	N/A
*** 5084	828	RuntimeBroker.	0x818687d942c0	5	-	1	False	2023-04-16 21:47:22.000000 	N/A
*** 8056	828	dllhost.exe	0x818681340080	5	-	0	False	2023-04-17 17:16:15.000000 	N/A
*** 4476	828	WmiPrvSE.exe	0x818684cb1080	11	-	0	False	2023-04-17 17:24:05.000000 	N/A
** 1992	696	svchost.exe	0x81867fc80080	7	-	0	False	2023-04-16 21:46:56.000000 	N/A
** 3272	696	svchost.exe	0x8186876ec2c0	13	-	1	False	2023-04-16 21:47:15.000000 	N/A
** 6344	696	SecurityHealth	0x818688521080	24	-	0	False	2023-04-16 21:47:34.000000 	N/A
** 1740	696	svchost.exe	0x818686e962c0	12	-	0	False	2023-04-16 21:46:23.000000 	N/A
*** 7812	1740	audiodg.exe	0x818687431080	8	-	0	False	2023-04-17 17:24:12.000000 	N/A
** 2252	696	svchost.exe	0x818686f58300	5	-	0	False	2023-04-16 21:46:57.000000 	N/A
** 2380	696	svchost.exe	0x8186870bd240	16	-	0	False	2023-04-16 21:46:57.000000 	N/A
** 2128	696	svchost.exe	0x818686f420c0	12	-	0	False	2023-04-16 21:46:56.000000 	N/A
** 728	696	svchost.exe	0x818684fb8240	80	-	0	False	2023-04-16 21:46:22.000000 	N/A
*** 4860	728	taskhostw.exe	0x818684cb0080	8	-	0	False	2023-04-17 17:16:08.000000 	N/A
*** 4900	728	CompatTelRunne	0x81868871d080	1	-	0	False	2023-04-17 17:16:08.000000 	N/A
**** 1748	4900	CompatTelRunne	0x818688c86340	14	-	0	False	2023-04-17 17:16:32.000000 	N/A
**** 5564	4900	conhost.exe	0x81868715e080	4	-	0	False	2023-04-17 17:16:11.000000 	N/A
*** 5252	728	taskhostw.exe	0x81868873f080	3	-	1	False	2023-04-17 17:16:08.000000 	N/A
*** 3208	728	sihost.exe	0x8186876ed280	10	-	1	False	2023-04-16 21:47:15.000000 	N/A
**** 7240	3208	msedge.exe	0x8186889f0080	0	-	1	False	2023-04-16 21:47:39.000000 	2023-04-16 21:47:55.000000 
*** 3336	728	MicrosoftEdgeU	0x818687722300	5	-	0	True	2023-04-16 21:47:15.000000 	N/A
**** 5752	3336	MicrosoftEdgeU	0x8186882f12c0	6	-	0	True	2023-04-16 21:47:28.000000 	N/A
*** 3384	728	BraveUpdate.ex	0x81868884f080	5	-	0	True	2023-04-17 17:16:06.000000 	N/A
*** 3292	728	taskhostw.exe	0x818687716300	10	-	1	False	2023-04-16 21:47:15.000000 	N/A
** 1112	696	svchost.exe	0x818686c222c0	16	-	0	False	2023-04-16 21:46:22.000000 	N/A
** 4568	696	SearchIndexer.	0x818687959240	15	-	0	False	2023-04-16 21:47:20.000000 	N/A
*** 800	4568	SearchFilterHo	0x81868829f080	6	-	0	False	2023-04-17 17:24:32.000000 	N/A
*** 7684	4568	SearchProtocol	0x818688636080	6	-	0	False	2023-04-17 17:22:28.000000 	N/A
** 5720	696	svchost.exe	0x81868815d240	16	-	0	False	2023-04-16 21:47:24.000000 	N/A
** 860	696	spoolsv.exe	0x818686f1c080	12	-	0	False	2023-04-16 21:46:56.000000 	N/A
** 1500	696	svchost.exe	0x818686d9a2c0	17	-	0	False	2023-04-16 21:46:23.000000 	N/A
** 7516	696	svchost.exe	0x818688016080	8	-	0	False	2023-04-17 17:24:50.000000 	N/A
** 1120	696	svchost.exe	0x818686c202c0	12	-	0	False	2023-04-16 21:46:22.000000 	N/A
** 7920	696	SgrmBroker.exe	0x8186870c3340	7	-	0	False	2023-04-17 17:16:34.000000 	N/A
** 4852	696	svchost.exe	0x818687d0d2c0	17	-	0	False	2023-04-16 21:47:21.000000 	N/A
** 756	696	svchost.exe	0x81868828d080	8	-	0	False	2023-04-16 21:47:29.000000 	N/A
** 4088	696	svchost.exe	0x81868815a2c0	3	-	0	False	2023-04-16 21:47:50.000000 	N/A
** 1276	696	svchost.exe	0x818686cb32c0	4	-	0	False	2023-04-16 21:46:23.000000 	N/A
* 716	572	lsass.exe	0x818684d10080	9	-	0	False	2023-04-16 21:46:21.000000 	N/A
* 852	572	fontdrvhost.ex	0x818684e1d140	5	-	0	False	2023-04-16 21:46:22.000000 	N/A
624	548	winlogon.exe	0x818684cd7080	5	-	1	False	2023-04-16 21:46:21.000000 	N/A
* 864	624	fontdrvhost.ex	0x818684d06080	5	-	1	False	2023-04-16 21:46:22.000000 	N/A
* 324	624	dwm.exe	0x818684f840c0	30	-	1	False	2023-04-16 21:46:22.000000 	N/A
* 3892	624	userinit.exe	0x8186813f5340	0	-	1	False	2023-04-16 21:47:17.000000 	2023-04-16 21:47:42.000000 
** 3928	3892	explorer.exe	0x818684aa0340	66	-	1	False	2023-04-16 21:47:17.000000 	N/A
*** 6304	3928	SecurityHealth	0x8186885240c0	6	-	1	False	2023-04-16 21:47:34.000000 	N/A
*** 6424	3928	VBoxTray.exe	0x81868852e080	13	-	1	False	2023-04-16 21:47:34.000000 	N/A
**** 5540	6424	svchost.exe	0x818687754080	1	-	1	False	2023-04-17 17:21:18.000000 	N/A
*** 3524	3928	ProcessHacker.	0x818687fb70c0	10	-	1	False	2023-04-17 17:21:50.000000 	N/A
*** 4072	3928	brave.exe	0x818688060300	31	-	1	False	2023-04-17 17:21:31.000000 	N/A
**** 4160	4072	brave.exe	0x818687e5e080	18	-	1	False	2023-04-17 17:22:11.000000 	N/A
**** 2844	4072	brave.exe	0x818688773080	7	-	1	False	2023-04-17 17:21:44.000000 	N/A
**** 5064	4072	brave.exe	0x8186872b8300	8	-	1	False	2023-04-17 17:21:39.000000 	N/A
**** 3952	4072	brave.exe	0x818687ff6080	14	-	1	False	2023-04-17 17:21:44.000000 	N/A
**** 5500	4072	brave.exe	0x8186886980c0	15	-	1	False	2023-04-17 17:21:46.000000 	N/A
**** 4060	4072	brave.exe	0x818681344080	12	-	1	False	2023-04-17 17:21:44.000000 	N/A
7156	7048	OneDrive.exe	0x81868897e080	20	-	1	False	2023-04-16 21:48:32.000000 	N/A
* 2296	7156	Microsoft.Shar	0x818684b43080	0	-	1	False	2023-04-17 17:16:06.000000 	2023-04-17 17:16:08.000000 
6808	6612	brave.exe	0x818688160300	10	-	1	False	2023-04-17 17:16:19.000000 	N/A
* 3144	6808	brave.exe	0x8186880f4080	0	-	1	False	2023-04-17 17:18:04.000000 	2023-04-17 17:18:58.000000 
960	1528	BraveUpdate.ex	0x818688718080	3	-	0	True	2023-04-17 17:16:26.000000 	N/A
```

Interesting : 0x8186882a7a20	TCPv4	10.0.2.15	49836	192.168.1.106	443	CLOSE_WAIT	6808	brave.exe	2023-04-17 17:16:51.000000 
And two brave.exe 6808 and 4072 but 6808 is child of 6612 which is... nobody ?

The flag is FCSC{6808:192.168.1.106:443}

So the ransomware is the process with the PID 6808

