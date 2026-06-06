## babyfuscation
> Un reverse (très) légèrement obfusqué !

```bash
file babyfuscation 
babyfuscation: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=80e2baa56f7f889a55c075839bfbb875d883476b, for GNU/Linux 3.2.0, not stripped
```

### Analysis:
Begin with the main :
```c
void main(void)

{
  int i;
  int j;
  int k;
  
  for (i = 0; i < 0x50; i = i + 1) {
    VYeXkgjLLMrczyw7i7dJPkyAbxqgCahe[i] = VYeXkgjLLMrczyw7i7dJPkyAbxqgCahe[i] ^ 0x42;
  }
  for (j = 0; j < 0x50; j = j + 1) {
    a93rEUcvwf4Ec9KHKqzFx7wL[j] = a93rEUcvwf4Ec9KHKqzFx7wL[j] ^ 0x13;
  }
  for (k = 0; k < 0x50; k = k + 1) {
    ouPrjEhgqPVNXCqchuzw7WTWLHnkbwqj[k] = ouPrjEhgqPVNXCqchuzw7WTWLHnkbwqj[k] ^ 0x37;
  }
  VsvYbpipYYgRoCeFtoxhtAmdFuNu3WvV();
  wKtyPoT4WdyrkVzhvYUfvqo3M9iPVMd3();
  VakkEeHbtHMpNqXPMkadR4v7K();
  return;
}
```

Open in ida (looks boring to reverse static), in ida i put a break point after the third for loop, and look at the three modified variable by the loops, and renamed the variable :
```c
  for ( i = 0; i <= 79; ++i )
  {
    envp = (const char **)enter_flag;
    enter_flag[i] ^= 0x42u;
  }
  for ( j = 0; j <= 79; ++j )
  {
    envp = (const char **)correct_flag;
    correct_flag[j] ^= 0x13u;
  }
  for ( k = 0; k <= 79; ++k )
  {
    envp = (const char **)wrong_flag;
    wrong_flag[k] ^= 0x37u;
  }
```
Put breakpoint on first function (VsvYbpipYYgRoCeFtoxhtAmdFuNu3WvV) and let's debug

In the first function we have a call to LdUonKvqsjsJu4JdfAgtgbU9 which take the user input and the byte 0xA
	This function seems to count how many ASCII character have been given by the user
After this it looks like the line return has been deleted (user_input[result] = 0;)
Then "result" is returned and contain what seems to be the length (16 in myn case, I put 16 A)

In the second function
	We have a call to another function kRvUaKbhJewpX4HHFuMuPkNWc7xJ4cUV
		This function has just one while loop and looks like is counting and adding one to the result...
	Then a for loop which modify our user input and store in another var (modified_user_input[i] = ((user_input[i] >> 5) | (8 * user_input[i])) ^ (3 * i + 31);)
	THIS LINE IS THE ONLY ONE THAT'S INTERESTING
	In order to check my comprehension I did this script which took my input (16 A) and transform with the same algorithm :
	
```python
user_input = "AAAAAAAAAAAAAAAA"
result = []
hex_result = []
for i, char in enumerate(user_input):
    # Step 1: Right shift 5 bits
    shifted_right = ord(char) >> 5
    
    # Step 2: Left shift 3 bits (equivalent to 8*ord(char))
    # shifted_left = ord(char) << 3
    shifted_left = 8 * ord(char)
    
    # Step 3: Bitwise OR
    or_result = shifted_right | shifted_left
    
    # Step 4: Bitwise XOR with (3i + 31)
    xor_result = or_result ^ (3 * i + 31)
    
    # Store result as byte (0-255)
    result.append(xor_result & 0xFF)

    # Convert to hex (0xXX format) and keep 2 digits
    hex_value = f"0x{xor_result & 0xFF:02X}"
    hex_result.append(hex_value)

print("Resulting bytes:", result)
print("Hex values:", hex_result)
```
And I get the same final hex values than the one in the program, so it's good
	
Final things we go in the last function and see that : `if ( (unsigned int)faubPTXHmhV4vfgEpzjqfMRjJ3qunsq9(modified_user_input, jMunhwoW4bRqeCdJfXvfNrRm) )`
The second var given to the if is the encrypted flag, I took it as a python list via ghidra : `[ 0x2d, 0x38, 0xbf, 0x32, 0xf0, 0x05, 0xa8, 0xb5, 0x04, 0x9b, 0x8c, 0x53, 0xca, 0xe7, 0xf0, 0x67, 0xf6, 0x59, 0xc4, 0xf1, 0x50, 0xe7, 0x7a, 0xa5, 0x74, 0xab, 0xdc, 0xd9, 0x50, 0xf7, 0x5a, 0xbd, 0xb6, 0x2b, 0x9e, 0x31, 0x90, 0x37, 0x08, 0x1d, 0x3e, 0xa9, 0x2c, 0x69, 0x0a, 0x67, 0x38, 0x9f, 0x0e, 0x2b, 0x24, 0x93, 0x72, 0x1f, 0x40, 0x6d, 0xd4, 0x7b, 0xee, 0x51, 0x1a, 0x4f, 0xca, 0x6d, 0xec, 0xf1, 0x24, 0xcb, 0x72, 0x05, 0xf1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ]`
Now a script to brute force that (can't reverse because of the bit shift)

```python
import string

result = [
    0x2d, 0x38, 0xbf, 0x32, 0xf0, 0x05, 0xa8, 0xb5, 0x04, 0x9b, 0x8c, 0x53,
    0xca, 0xe7, 0xf0, 0x67, 0xf6, 0x59, 0xc4, 0xf1, 0x50, 0xe7, 0x7a, 0xa5,
    0x74, 0xab, 0xdc, 0xd9, 0x50, 0xf7, 0x5a, 0xbd, 0xb6, 0x2b, 0x9e, 0x31,
    0x90, 0x37, 0x08, 0x1d, 0x3e, 0xa9, 0x2c, 0x69, 0x0a, 0x67, 0x38, 0x9f,
    0x0e, 0x2b, 0x24, 0x93, 0x72, 0x1f, 0x40, 0x6d, 0xd4, 0x7b, 0xee, 0x51,
    0x1a, 0x4f, 0xca, 0x6d, 0xec, 0xf1, 0x24, 0xcb, 0x72, 0x05, 0xf1, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
]

def transform(char, i):
    shifted_right = ord(char) >> 5
    shifted_left = ord(char) << 3
    or_result = shifted_right | shifted_left
    return (or_result ^ (3 * i + 31)) & 0xFF

def brute_force_position(position):
    target = result[position]
    for char in string.printable:
        if transform(char, position) == target:
            return char
    return None  # If no printable character matches (unlikely)

# Recover original string
original = []
for i in range(len(result)):
    if result[i] == 0:  # Skip null bytes
        original.append('\x00')
        continue
    c = brute_force_position(i)
    original.append(c if c else '?')

print("Recovered string:", ''.join(original))
```
The result is : Recovered string: **FCSC{e30f46b147e7a25a7c8b865d0d895c7c7315f69582f432e9405b6d093b6fb8d3}**