# Reversconstrictor

#easy #reverse

> Lors de votre voyage intergalactique, vous croisez un serpent géant qui fonce droit sur vous. Heureusement, ce genre de problème avait été anticipé : il vous suffit d’activer votre super blaster intergalactique pour vous sortir de cette mauvaise passe. Mais au moment d’appuyer sur le bouton, une fenêtre s’affiche sur votre tableau de bord… Elle demande un mot de passe pour mettre à jour vos systèmes avant de pouvoir déclencher le laser ! Dépêchez-vous de retrouver ce mot de passe !

## analysis
```
$ file chall 
chall: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=fc89f558d158bb1cc6e5e463d6fe7c536da15abb, stripped
```
strings give some interesting things:
```
blib-dynload/_bisect.cpython-39-x86_64-linux-gnu.so
blib-dynload/_blake2.cpython-39-x86_64-linux-gnu.so
blib-dynload/_bz2.cpython-39-x86_64-linux-gnu.so
blib-dynload/_codecs_cn.cpython-39-x86_64-linux-gnu.so
blib-dynload/_codecs_hk.cpython-39-x86_64-linux-gnu.so
x_tk_data/unsupported.tcl
x_tk_data/xmfbox.tcl
xbase_library.zip
xmodules/encrypt_key.cpython-39.pyc
zPYZ-00.pyz
5libpython3.9.so.1.0
.shstrtab
```
Looks like python :)

```
git clone https://github.com/extremecoders-re/pyinstxtractor.git
python pyinstxtractor/pyinstxtractor.py chall 
```

we got a lot of pyc file :)

```
git clone https://github.com/zrax/pycdc.git
cd pycdc
cmake .
make
```

The tool is ready we can get the chall.py:
```
$ ../pycdc/pycdc chall.pyc 
# Source Generated with Decompyle++
# File: chall.pyc (Python 3.9)

import tkinter as tk
import importlib.util as importlib
import os
import sys

def import_module():
    module_path = os.path.join(sys._MEIPASS, 'modules/encrypt_key.cpython-39.pyc')
    spec = importlib.util.spec_from_file_location('nom_module', module_path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod

module = import_module()

def xor(a, b):
    return bytes((lambda .0: for x, y in .0:
x ^ y)(zip(a, b)))


def validate_password(password):
    if xor(module.encode_password(password.encode('ascii')), module.encrypt_key(0x6D39D56F8A40A6BBE43A82A53B2C762EA780C21A32C6B3EF765D3A54F3432432F3E6D39D56F8A40A6BBE43A82A53B2C762EA780C21A32C6B3EF765D3A54F3432432F3E)) == b'\xe9J\x1aB\xe2\xc5\xf3S\'\xd6>\n$\x94\x1a\x07\'F\xc6\xa1\x07\xb7\xcc\xec\xe1\x84\xec\xac\xe4\xd64\x8f\xc3\x12\x04\x16$n\x15\xec\xe1\xaee5\xc7\xecOX"\x98EO\x1f2\xb4\x15\xc4\xed\xf4\xcd$\xd3\xd3u\xc2\xf8\xc6\xae\x06\x08\xcd\xff\xe0(\xe9\xb0\xe7\xde6\x90\xcc\xfd\x02}%\x1a\x1a\xc9#\x10\xc2\x86\x06\x08\xcd\xfe&\xb8K\x0f)\x9a\xb6\xb9\x02\x17\xa0\xd8\xe4]\x98\xf5*\x154<\x06\x875\xbd\x05@\xe6\x88\xe3&6%\xcc\x18\x06\\%\xa4\x1a7!\xfe\xc3\xae\x06\x08\xcd\xff\xe2\x18\xe2x\xe0\x927x\r\xfa\xa6\xbd\xe67\x97\xf7\xe5)f\x94\xc8\xbdv\r\xef\x12\x1bZ\xe8e\xf3S\'\xd6>\n"8\x1be\x9c\xdf\xe8\x9b\x06\xb7\x0b3V\x1f\xedN\x87\xbbI!C>8z%\xc0\xeaM\xb5\xd1p\xd1\x0f|A\xd7B\x03\xc54\xd5T\xb9\xfd\x88;\xbf\x10\x81L\x90L\x0b\xff\xed\xe1\xe5dQ\xc4\x17\xd5\xafUl\xec':
        label.config('Mot de passe correct !', **('text',))
    else:
        label.config('Mot de passe incorrect !', **('text',))

root = tk.Tk()
root.title('Rêve en Python')
root.geometry('300x200')
label = tk.Label(root, 'Entrez le mot de passe :', **('text',))
label.pack(10, **('pady',))
entry_password = tk.Entry(root, 20, **('width',))
entry_password.pack(5, **('pady',))
validate_button = tk.Button(root, 'Valider', (lambda : validate_password(entry_password.get())), **('text', 'command'))
validate_button.pack(5, **('pady',))
root.mainloop()
```

