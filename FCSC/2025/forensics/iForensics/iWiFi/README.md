# iForensics - iWiFi
> Lors d'un passage de douane, le douanier vous demande de lui remettre votre téléphone ainsi que son code de déverrouillage. Le téléphone vous est rendu quelques heures plus tard ...
>
> Suspicieux, vous envoyez votre téléphone pour analyse au CERT-FR de l'ANSSI. Les analystes du CERT-FR effectuent une collecte sur le téléphone, composée d'un sysdiagnose et d'un backup.
>
> Note : à l'exception de iForensics - iBackdoor 2/2 qui dépend de la résolution de iForensics - iBackdoor 1/2, les épreuves sont indépendantes. Nous vous conseillons néanmoins de faire les épreuves par difficulté croissante, en terminant par iForensics - iCompromise.
>
> Pour continuer, trouvez quelques informations d'intérêt sur le téléphone : SSID et BSSID du réseau WiFi sur lequel le téléphone est connecté ainsi que le compte iCloud associé au téléphone.
>
> Le flag est au format FCSC{<SSID>|<BSSID>|<compte iCloud>}. Par exemple, si le téléphone est connecté sur le réseau WiFi example, qui a pour BSSID 00:11:22:33:44:55 et que le compte iCloud associé est example@example.com : FCSC{example|00:11:22:33:44:55|example@example.com}.

I install the libpslist tool to read the plist apple files: `sudo apt-get install libplist-utils -y`
Then search for all plist file in the sysdiagnose : `find . -name *.plist`
Then open the known-networks one with the plist utils : `plistutil -i ./DiagnosticLogs/sysdiagnose/sysdiagnose_2025.04.07_08-06-18-0700_iPhone-OS_iPhone_20A362/WiFi/com.apple.wifi.known-networks.plist`

Now let's find the icloud account
Hard to find... To find it I did that:
Goes in the backup folder and used this grep command to get all the icloud strings `grep -ria "icloud"`
And found that: robertswigert@icloud.com

So the flag is: **FCSC{FCSC|66:20:95:6c:9b:37|robertswigert@icloud.com}**