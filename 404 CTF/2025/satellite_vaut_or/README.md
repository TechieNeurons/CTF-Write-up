# Un satellite qui vaut de l'or 

#osint

> Quel est le nom du satellite à l'intérieur du propulseur sur la photo ?
>
> Format du flag : 404CTF{satellite}
>
> N.B : le flag ne contient aucun accent ni chiffre ni caractère spécial et tient en un seul mot

## Analysis
We have a picture, I put it on google images and crop to focus on the rocket, google said it's the french rocket "Diamant A", then I go on wikipedia to see the satelites launch with this rocket.
https://fr.wikipedia.org/wiki/Diamant_(fus%C3%A9e)#Historique_des_lancements_des_fus%C3%A9es_Diamant
In the table I see 4 launch for the Diamond A, The first launching astérix contain an accent so not this one, the second is diapason (the good one) the 3rd and 4th have a number and a space and accent so can't be these ones

flag: 404CTF{diapason}