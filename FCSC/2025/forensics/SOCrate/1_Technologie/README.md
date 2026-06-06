#  SOCrate 1/6 - Technologie
> En juin 2023, un opérateur d'importance vitale est victime d'une attaque compromettant tout son système d'information. Vous avez reçu les logs Linux et Windows et vous devez répondre aux questions des enquêteurs.
> 
> Note : Les parties sont numérotées dans l'ordre chronologique de l'attaque, mais il n'est pas nécessaire de les résoudre dans l'ordre.
> Sur la machine webserver, sous quel chemin tourne l'application web ?
> 
> Format du flag : FCSC{/var/www/***/************/}

The easy way, in this linux log folder: `grep "\/var\/www\/" *`
We get the flag: **FCSC{/var/www/app/banque_paouf}**