# iForensics - iTreasure
> Lors d'un passage de douane, le douanier vous demande de lui remettre votre téléphone ainsi que son code de déverrouillage. Le téléphone vous est rendu quelques heures plus tard ...
>
> Suspicieux, vous envoyez votre téléphone pour analyse au CERT-FR de l'ANSSI. Les analystes du CERT-FR effectuent une collecte sur le téléphone, composée d'un sysdiagnose et d'un backup.
>
> Note : à l'exception de iForensics - iBackdoor 2/2 qui dépend de la résolution de iForensics - iBackdoor 1/2, les épreuves sont indépendantes. Nous vous conseillons néanmoins de faire les épreuves par difficulté croissante, en terminant par iForensics - iCompromise.
>
> Avant la remise du téléphone à la douane, le propriétaire du téléphone a eu le temps d'envoyer un trésor. Retrouvez ce trésor.

We have to find a file send by the user, the files are in the backup archive (backup of the fs)
First let's open the Manifest.db in sqlitebrower, all the file are named with their hash instead of their name bu the manifest db do the correspondance.
In this file I looked and found the sms.db file : 3d0d7e5fb2ce288813306e4d4636395e047a3d28 - Library/SMS/sms.db

Then I open the file 3d0d7e5fb2ce288813306e4d4636395e047a3d28 with sqlitebrowser, and we can see (in the attachment table) : `~/Library/SMS/Attachments/9e/14/4C3DF366-1CE1-42F1-9570-C76206181041/679329D1-12E7-45F2-A082-1E58A6CB454F.HEIC	public.heic	image/heic`
The user send an image, we can go back to the manifest db to get : `6f4e34098e00a80fde876c8638fb1d685be2318b - Library/SMS/Attachments/9e/14/4C3DF366-1CE1-42F1-9570-C76206181041/679329D1-12E7-45F2-A082-1E58A6CB454F.HEIC`

I opened the `6f4e34098e00a80fde876c8638fb1d685be2318b` image and get the flag: **FCSC{511773550dca}**