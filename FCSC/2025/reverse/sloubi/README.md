# Sloubi
> Sloubi 1 ! Sloubi 2 ! Sloubi 3 ! Sloubi 4 ! Sloubi 5 ! Sloubi 6 ! Sloubi 7 ! Sloubi 8 ! Sloubi 9 ! Sloubi 10 ! Sloubi 11 ! Sloubi 12 ! Sloubi 13 ! Sloubi 14 ! Sloubi 15 ! Sloubi 16 ! Sloubi 17 ! Sloubi 18 ! Sloubi 19 ! Sloubi 20 ! Sloubi 21 ! Sloubi 22 ! Sloubi 23 ! Sloubi 24 ! Sloubi 25 ! Sloubi 26 ! Sloubi 27 ! Sloubi 28 ! Sloubi 29 ! Sloubi 30 ! Sloubi 31 ! Sloubi 32 !

1. import sloubi in Ghidra and analyze.
2. In the main, we have our user input : `fgets(user_input,0x28,stdin);`
3. Later we have our encoded flag (compared with our modified input): `strcmp(local_38,"4B}mCuCNJmeVhvCzQusFHS7{2gCBCrQW");`
4. The len is stored in a variable: `len_input = strlen(user_input);` and compared with 0x20 (32) `if (len_input == 0x20) {`
5. If the len is correct then we transform the input (just before comparing it with the encoded flag): 
```c
for (i = 0; i < 0x20; i = i + 1) {
	modified_input[(i * 0x11 + 0x33) % 0x20] = user_input[i];
}
```
6. Write a script to do the inverse:
```
n = 0x20
modified_input = list("4B}mCuCNJmeVhvCzQusFHS7{2gCBCrQW")
reversed_input = [''] * n

for i in range(n):
    j = (i * 0x11 + 0x33) % n  # Original index calculation
    reversed_input[i] = modified_input[j]  # Reverse mapping

original = ''.join(reversed_input)
print(original)
```

Output: **FCSC{JgeBhrCWQBsmHu7N2mCVCvQz4u}**