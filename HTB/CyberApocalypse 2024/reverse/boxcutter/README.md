## BoxCutter

Simple ELF, open it with ghidra
Everything in the main :
```
  undefined8 local_28;
  undefined7 local_20;
  undefined uStack_19;
  undefined7 uStack_18;
  int local_10;
  uint local_c;
  
  local_28 = 0x540345434c75637f;
  local_20 = 0x45f4368505906;
  uStack_19 = 0x68;
  uStack_18 = 0x374a025b5b0354;
  for (local_c = 0; local_c < 0x17; local_c = local_c + 1) {
    *(byte *)((long)&local_28 + (long)(int)local_c) =
         *(byte *)((long)&local_28 + (long)(int)local_c) ^ 0x37;
  }
  local_10 = open((char *)&local_28,0);
  if (local_10 < 1) {
    puts("[X] Error: Box Not Found");
  }
  else {
    puts("[*] Box Opened Successfully");
    close(local_10);
  }
  return 0;
```
We see a simple xor 
*local_28, local_20, ustack_19 and ustack_18* seems to be the flag which is xored with *0x37*
As python array :
```
0x540345434c75637f
0x45f4368505906
0x68
0x374a025b5b0354
--> I passed local_28 as uchar[32] : \x7f c u L C E \x03 T \x06 Y P h C _ \x04 h T \x03 [ [ \x02 J 7
Pass the char in hex : 7f 63 75 4c 43 45 03 54 06 59 50 68 43 5f 04 68 54 03 5b 5b 02 4a 37
Transform in python list : [0x7f, 0x63, 0x75, 0x4c, 0x43, 0x45, 0x03, 0x54, 0x06, 0x59, 0x50, 0x68, 0x43, 0x5f, 0x04, 0x68, 0x54, 0x03, 0x5b, 0x5b, 0x02, 0x4a, 0x37]
```

In python cli :
```
>>> encoded = [0x7f, 0x63, 0x75, 0x4c, 0x43, 0x45, 0x03, 0x54, 0x06, 0x59, 0x50, 0x68, 0x43, 0x5f, 0x04, 0x68, 0x54, 0x03, 0x5b, 0x5b, 0x02, 0x4a, 0x37]
>>> decoded = ''
>>> for i in encoded:
...  decoded += chr(i ^ 0x37)
>>> print (decoded)
HTB{tr4c1ng_th3_c4ll5}
```

or just : `ltrace ./cutter`
