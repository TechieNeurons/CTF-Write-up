# Message lointain 

#intro #crypto

> Un message vient d'être reçu de l'espace, je me demande ce qu'il peut bien vouloir dire...

## Analysis
Ask IA:
```
charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{}-!"
n = len(charset)  # n = 66 characters

# Precompute reverse mapping: encrypted_y -> original_x
reverse_map = {}
for x in range(n):
    encrypted_y = pow(2, x, n+1)  # Calculate y = 2^x mod 67
    reverse_map[encrypted_y] = x

# Encrypted flag from the challenge
encrypted_flag = "828x6Yvx2sOnzMM4nI2sQ"

# Decrypt each character
decrypted = []
for char in encrypted_flag:
    y = charset.index(char)  # Get y value from character position
    x = reverse_map[y]      # Find original x using precomputed map
    decrypted.append(charset[x])

print("DECRYPTED FLAG:", "".join(decrypted))
```
And I get: `DECRYPTED FLAG: 404CTF{C0nstEllAt!0n}`
