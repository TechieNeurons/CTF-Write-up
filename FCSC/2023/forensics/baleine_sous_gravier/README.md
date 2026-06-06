> Les analystes de sécurité d'un opérateur télécom font face à un problème majeur. Depuis quelques jours, une alerte sur leur système de détection d'intrusion ne cesse d'être levée par leur sonde d'analyse comportementale. La sonde indique que le trafic capturé sur certains liens du cœur de réseau est anormal.
> Voici la topologie du réseau cœur de l'opérateur :
> Après plusieurs nuits passées à analyser le trafic, nos analystes n'ont pas réussi à trouver la cause de cette alerte.
> Pourriez-vous les aider à identifier la cause de ce trafic anormal à partir d'un ensemble de fichiers pcap contenant le trafic capturé sur les interfaces des routeurs du cœur de réseau ?

Fichiers :
- SHA256(baleine-sous-graviers.png) = 33fef1024de54eaa2e4a1a822edde2acbd5d80979b6abcc6d1a243c777d49719.
- SHA256([captures.xz](https://drive.google.com/file/d/1vf24ufnUSEyenLxlyZ2B9N3krvh6cjOK/view?usp=share_link)) = d3b6852ae479dbd22ad99b177900f5d9586d24bcf24886b874e1d95485178570.

Notification :
>Baleine sous graviers
>
>   Une petite erreur s'est glissée dans les pcaps fournis pour Baleine sous graviers : merci à naacbin pour l'avoir détectée ! Cette erreur ne remet pas en cause la résolution de l'épreuve.
>
>    Les captures au niveau de R11 sur GiO/O, GiO/1 et GiO/2 ont été décalées et sont en fait des captures sur GiO/1, GiO/2 et GiO/3, respectivement. Les fichiers devraient donc être renommés en :
>
>    r11_gi00.pcap => r11_gi01.pcap
>    r11_gi01.pcap => r11_gi02.pcap
>    r11_gi02.pcap => r11_gi03.pcap
>
>    ce qui implique que :
>
>        le pcap pour GiO/O manque dans l'archive fournie avec le challenge,
>        la capture GiO/3 n'aurait pas dû être fournie.
>
>    La solution attendue n'est cependant pas impactée.
