#  Intro to pwntools
> Ceci n'est pas une vraie épreuve, mais plutôt un exemple d'utilisation de Python pour communiquer avec les services distants du FCSC, de Hackropole, et plus généralement de n'importe quelle service exposant un port TCP.
> 
> Si vous n'êtes pas familier avec ces concepts, commencez par installer le package Python pwntools sur votre machine. Celui-ci est extrêmement utile en CTF et permet de simplifier l'écriture de beaucoup de choses.
> 
> Dans notre cas, nous allons uniquement nous en servir pour communiquer avec un service exposant un port TCP.
> 
> Ce service est accessible ici : nc chall.fcsc.fr 2053.
> 
>     le port est le port TCP numéro 2053,
>     le serveur est situé à l'adresse chall.fcsc.fr,
>     nc (netcat) est un utilitaire permettant de se connecter à un port TCP.
> 
> Bien qu'il soit possible de résoudre cette épreuve à la main ou directement à partir du fichier template.py fourni, nous vous conseillons d'étudier les différentes fonctions utilisées dans template.py. Celles-ci sont les principales fonctions utilisées dans pwntools pour communiquer avec les services distants, et elles pourront vous être utiles pour les autres épreuves du FCSC ou de Hackropole.

We can just launch the py file, the flag is **FCSC{5bdcc7d8671457aa9366753d9f4cf2ed67832784c383c502f5c3d07361b16158}**