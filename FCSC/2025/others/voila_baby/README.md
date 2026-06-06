#  Voilà (Baby)
> Alice adore écouter de la musique. Malheureusement, elle a mal configuré son pare-feu et expose involontairement sa collection musicale sur Internet. Alice range sa collection personnelle d'une manière non conventionnelle : plutôt que de trier par genres, albums, ou artistes, elle renomme ses musiques selon son imagination.
> 
> Pour commencer, connectez-vous à sa collection musicale et trouvez le flag caché dans les métadonnées.
> 
> La collection musicale d'Alice est exposée sur nc chall.fcsc.fr 2052.

When we connect we have: `OK MPD 0.23.5` type on google to find (Music Player Daemon): `The MPD command protocol exchanges line-based text records between client and server over TCP. Once the client is connected to the server, they conduct a conversation until the client closes the connection. The conversation flow is always initiated by the client.`

Can find commands here: https://mpd.readthedocs.io/en/latest/protocol.html#command-reference

After trying a lot of different command I get the flag with the command: `list album group albumartist` **FCSC{da73b72ebff9d887d6e329a50da3fe470439d5ad1a530dea04dd382f63e79b5f}**