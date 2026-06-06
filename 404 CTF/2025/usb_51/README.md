# USB 51

#intro #pcapng #cyberchef #usb

> Alors que vous travaillez tranquillement dans votre bureau à l'ESA (Agence Spatiale Européenne), une alarme intrusion retentit. Il semblerait qu'un petit malin ait essayé d'exfiltrer des documents secrets. Mais pas de panique : armé de vos outils et de vos connaissances, vous êtes prêt à analyser la capture réseau de l’attaque ! Vous ne devriez pas avoir trop de mal à retrouver le document exfiltré, ainsi que les informations cachées qu’il contient — celles que l’attaquant cherchait sûrement...

## Analysis
https://shankaraman.wordpress.com/tag/extract-files-from-pcap-usb-protocol/

Packet N°43 contain a pdf, right click on "Leftover Capture Data" and copy as hex stream, put it in cyberchef and save as file.

Open the pdf to find some binary data written in the middle, in cyberchef "from binary" gave us: 404CTF{W3_c0ME_IN_p3aC3}