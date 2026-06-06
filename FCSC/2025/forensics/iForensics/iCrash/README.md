# iForensics - iCrash
> Lors d'un passage de douane, le douanier vous demande de lui remettre votre téléphone ainsi que son code de déverrouillage. Le téléphone vous est rendu quelques heures plus tard ...
>
> Suspicieux, vous envoyez votre téléphone pour analyse au CERT-FR de l'ANSSI. Les analystes du CERT-FR effectuent une collecte sur le téléphone, composée d'un sysdiagnose et d'un backup.
>
> Note : à l'exception de iForensics - iBackdoor 2/2 qui dépend de la résolution de iForensics - iBackdoor 1/2, les épreuves sont indépendantes. Nous vous conseillons néanmoins de faire les épreuves par difficulté croissante, en terminant par iForensics - iCompromise.
>
> Il semblerait qu'un flag se soit caché à l'endroit où sont stockés les crashes sur le téléphone ...

In the sysdiagnose archive : sysdiagnose - private/var/mobile/Library/Logs/CrashReporter/ 
```bash 
cat fcsc_intro.txt
FCSC{7a1ca2d4f17d4e1aa8936f2e906f0be8}
```

So the flag is: **FCSC{7a1ca2d4f17d4e1aa8936f2e906f0be8}**