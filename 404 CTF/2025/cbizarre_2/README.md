# Cbizarre [2/2]

#intro #reverse

> Vous êtes à bord de la fusée lorsque vous recevez un message en provenance de la Terre. Mais, étourdi comme toujours, vous avez encore oublié le mot de passe… Allez, c’est reparti pour tenter de retrouver ce flag récalcitrant !

## Analysis
```
$ file chall2 
chall2: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=683fe4c494b6b7dc5df519f9299a42f6616677ff, for GNU/Linux 3.2.0, not stripped
```

```
$ strings chall2 
Usage: %s <password>
Error: Incorrect password.
Bravo ! Vous avez le flag ! %s
```

Add the right to execute and launch with strace/ltrace --> Nothing

Open in Ghidra, everything in the main:
```
    sVar2 = strlen((char *)param_2[1]); # check if one argument (the password)
    if (sVar2 == 20) { # Check if the password is 20 char long
```

Then, each char is compared with a char:
```
      if (*(char *)(param_2[1] + 5) != 'Z') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0xc) != 'o') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)param_2[1] != 'f') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0x12) != '1') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 7) != '%') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 3) != 'M') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 9) != 'y') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0x10) != 'v') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0xe) != 'n') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 1) != 'a') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0x13) != 'x') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 6) != 'a') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0xf) != 'M') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 8) != '3') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 4) != 'P') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0xb) != 'K') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 10) != 'N') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0x11) != '%') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 2) != 'V') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
      if (*(char *)(param_2[1] + 0xd) != '@') {
        fwrite("Error: Incorrect password.\n",1,0x1b,stderr);
                    /* WARNING: Subroutine does not return */
        exit(1);
      }
```
Let's do by hand, with two or three "find and replace" I have:
```
5 = 'Z'
0xc = 'o'
param_2[1] = 'f'
0x12 = '1'
7 = '%'
3 = 'M'
9 = 'y'
0x10 = 'v'
0xe = 'n'
1 = 'a'
0x13 = 'x'
6 = 'a'
0xf = 'M'
8 = '3'
4 = 'P'
0xb = 'K'
10 = 'N'
0x11 = '%'
2 = 'V'
0xd = '@'
```
Now just put in order to get: `faVMPZa%3yNKo@nMv%1x`
And finally:
```
./chall2 faVMPZa%3yNKo@nMv%1x
Bravo ! Vous avez le flag ! 404CTF{Cg00d&slmpL3}
```