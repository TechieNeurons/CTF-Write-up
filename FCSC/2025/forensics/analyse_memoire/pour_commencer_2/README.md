# Analyse mémoire - Pour commencer (2/2)

> La capture mémoire a été réalisée pendant qu'un utilisateur était en train de travailler sur un document hautement sensible. Si une compromission du poste a eu > lieu, ce document a peut-être été volé. Pouvez-vous retrouver :
> 
>     le nom du logiciel d'édition du document,
>     le nom du document.
> 
> Le flag est au format FCSC{<nom du logiciel>:<nom du document>} où :
> 
>     <nom du logiciel> est le nom de l'exécutable du logiciel d'édition et
>     <nom du document> est le nom du document en cours d'édition par l'utilisateur (sans le chemin du fichier).
> 
> Par exemple : FCSC{calc.exe:Mes comptes 2025.txt}.
> 
> Attention : pour cette épreuve, vous n'avez que 10 tentatives de flag.

Print the cmdline: `/opt/volatility3/vol.py -f ./analyse-memoire.dmp windows.cmdline`
We see: `8968 - soffice.exe - "C:\Program Files\LibreOffice\program\soffice.exe" -o "C:\Users\userfcsc-10\Desktop\[SECRET-SF][TLP-RED]Plan FCSC 2026.odt"`

So the flag is: **FCSC{soffice.exe:[SECRET-SF][TLP-RED]Plan FCSC 2026.odt}**