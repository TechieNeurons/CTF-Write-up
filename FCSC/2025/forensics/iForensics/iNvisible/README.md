# iForensics - iNvisible
> Lors d'un passage de douane, le douanier vous demande de lui remettre votre téléphone ainsi que son code de déverrouillage. Le téléphone vous est rendu quelques heures plus tard ...
>
> Suspicieux, vous envoyez votre téléphone pour analyse au CERT-FR de l'ANSSI. Les analystes du CERT-FR effectuent une collecte sur le téléphone, composée d'un sysdiagnose et d'un backup.
>
> Note : à l'exception de iForensics - iBackdoor 2/2 qui dépend de la résolution de iForensics - iBackdoor 1/2, les épreuves sont indépendantes. Nous vous conseillons néanmoins de faire les épreuves par difficulté croissante, en terminant par iForensics - iCompromise.
>
> Il semblerait qu'un message n'ait pas pu s'envoyer ... Retrouvez le destinataire de ce message.
>
> Le flag est au format FCSC{<destinataire>}. Par exemple, si le destinataire est example@example.com : FCSC{example@example.com}.
>
> Attention : pour cette épreuve, vous n'avez que 5 tentatives de flag.

In the sms.db file (3d0d7e5fb2ce288813306e4d4636395e047a3d28) we have two account contacted (kristy.friedman@outlook.com) and robert (robert is the user of the iphone)
also we can see the message to kristy is filtered (is_filtered column not sure if that mean the message not send)

The flag is: **FCSC{kristy.friedman@outlook.com}**