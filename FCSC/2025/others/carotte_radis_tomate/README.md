# Carotte Radis Tomate
> Mangez cinq fruits et légumes par jour !

The encryption uses a 256-bit AES key with 5 known modular remainders (carotte, radis, etc.) using distinct large primes. We can recover the key via the Chinese Remainder Theorem (CRT) and decrypt the flag.
Step 1: Reconstruct the AES Key

Mathematical Insight:
The key satisfies these congruences:

text
key ≡ carotte  mod 17488856370348678479  
key ≡ radis    mod 16548497022403653709  
key ≡ tomate   mod 17646308379662286151  
key ≡ pomme    mod 14933475126425703583  
key ≡ banane   mod 17256641469715966189  

Use CRT to solve these equations and recover key.
Step 2: Python Implementation

python
from sympy.ntheory.modular import crt
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

# Replace with given values from the problem
carotte = ...  # Value from "carotte = "
radis = ...    # Value from "radis = "
tomate = ...   # Value from "tomate = "
pomme = ...    # Value from "pomme = "
banane = ...   # Value from "banane = "
enc_hex = "..."  # Encrypted flag hex string

moduli = [
    17488856370348678479,
    16548497022403653709,
    17646308379662286151,
    14933475126425703583,
    17256641469715966189
]
remainders = [carotte, radis, tomate, pomme, banane]

# Solve using Chinese Remainder Theorem
key_int, _ = crt(moduli, remainders)
key = key_int.to_bytes(32, 'big')  # Convert to 32-byte AES key

# Decrypt the ciphertext
enc = bytes.fromhex(enc_hex)
cipher = AES.new(key, AES.MODE_ECB)
decrypted = unpad(cipher.decrypt(enc), 16)
print(decrypted.decode())