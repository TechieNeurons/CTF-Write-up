# Cbizarre [1/2]

#intro #reverse

> Vous êtes prêt à partir en voyage spatial ! Mais la fusée demande le fameux flag qui commence par 404CTF{...}… sauf que vous l’avez oublié 😢. Ni une ni deux, vous vous plongez dans les méandres du programme pour voir s’il est vraiment nécessaire d’avoir un mot de passe pour découvrir ce mystérieux flag…

## Analysis
```
$ file chall1 
chall1: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=672ea0b68be1ad9fd7ca55b481c5c3cc2b520bb8, for GNU/Linux 3.2.0, not stripped
```
Strings:
```
Usage: %s <password>
b457cbb3a588fda49339744bdeff34ca0885bb3b630dbdb57fcbab5595d64a49a5338b5efe8e7cfdccb75fd137b172fa5dcc5e47748d2ed55f7ccad26829670b9eeb98ded4429c4d66f01dd5ddbd2c2668ba4b666e29d206dbcdec0e11ebb5d53a0de62612ed923beda79aea3dae06a05efe67f4c3dec8f92ecbaa3a1c16e8693ef93aa28b962e39e2bf1308b0d46f61
%2hhx
AV5Ukqn7VMi@z08w71WCzJd6$G*EF#fhsF2taRxYxccVXwk!Uc7@QsBUgZzFVXz1p7vBlmpUILL$T7#8@#WNE#68JW$AamQYJlsrQj#NZkb%n&5DqA*pQ67X&OVp68BN
Decrypted message does not match expected message
Failed to initialize CURL
https://pastebin.com/raw/n8CXuwE0
;*3$"
GCC: (Debian 12.2.0-14) 12.2.0
```
The pastebin give: 404CTF{PAst3_mY_FL2g}