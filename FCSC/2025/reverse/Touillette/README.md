# Touillette
> J'ai mis une touillette dans mon flag et j'ai ... touillé !
> 
> A vous de le reconstituer !

```
def decode(encoded: str) -> str:
    # Reconstruct x from encoded string
    x_even = encoded[32:]  # Contains even indices of x
    x_odd = encoded[:32]   # Contains odd indices of x
    x = []
    for even, odd in zip(x_even, x_odd):
        x.extend([even, odd])
    x = "".join(x)
    
    # Rebuild flag from x
    flag = [""] * 64
    for pos in range(64):
        k = pos // 8
        m = pos % 8
        flag_index = 56 + k - 8 * m
        flag[flag_index] = x[pos]
    
    return "".join(flag)

# Example usage:
encoded_output = "Z2yFm7bCjR6SMWOCSiw{wqKWoJxTtxP4Hf74mQZ4qmghcu1mdX9HND7u8oxF}JsR" # output.txt string
original_flag = decode(encoded_output)
print(original_flag)
```

Give us: **FCSC{WT444hmHuFRyb6OwKxP7Zg197xs27RWiqJxfQmuXDoJZmjMSwotHmqcdN8}**