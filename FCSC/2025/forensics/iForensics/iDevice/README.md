#  iForensics - iDevice
> Lors d'un passage de douane, le douanier vous demande de lui remettre votre téléphone ainsi que son code de déverrouillage. Le téléphone vous est rendu quelques heures plus tard ...
>
> Suspicieux, vous envoyez votre téléphone pour analyse au CERT-FR de l'ANSSI. Les analystes du CERT-FR effectuent une collecte sur le téléphone, composée d'un sysdiagnose et d'un backup.
>
> Note : à l'exception de iForensics - iBackdoor 2/2 qui dépend de la résolution de iForensics - iBackdoor 1/2, les épreuves sont indépendantes. Nous vous conseillons néanmoins de faire les épreuves par difficulté croissante, en terminant par iForensics - iCompromise.
>
> Pour commencer, trouvez quelques informations d'intérêt sur le téléphone : version d'iOS et identifiant du modèle de téléphone.
>
> Le flag est au format FCSC{<identifiant du modèle>|<numéro de build>}. Par exemple, pour un iPhone 14 Pro Max en iOS 18.4 (22E240) : FCSC{iPhone15,3|22E240}.

The build seems to be : 20A362 because I see the file : `sysdiagnose_2025.04.07_08-06-18-0700_iPhone-OS_iPhone_20A362.tar.gz` in private/var/mobile/Library/Logs/CrashReporter/DiagnosticLogs/sysdiagnose

In the backup folder we can cat the `Info.plist` file to find the "product type" key which is iPhone12,3
Concatenate with the build find earlier we have : **FCSC{iPhone12,3|20A362}**