For solving this challenge I used a Windows VM, but I needed to convert the **.vhdx** to **.vhd**, so I did that :
1. On VMWare, in the settings of the VM, under Processors, activate "Virtualize Intel VT-x/EPT"
2. Then I Activated Hyper-V in the VM (in the menu "Activate windows features")
3. I installed **Autopsy** then convert the **.vhdx** to **.vhd** with the following command :

```
Convert-VHD -Path .vhdx -DestinationPath .vhd
```

4. I add the **.vhd** to a new case in autopsy and let him do his analyze
5. After some research on the disk in fund, in **"File views" -> .dll**, a dll file with the extension **.ps1**
6. I extracted the file from the timeline (we can see the file is modified just after she is created) 
7. After extracting the file take all the base64 and paste to cyberchef
8. Paste the result in a new file, and delete the last pipe (for not executing the code)
9. We get a lot of "char", put them in cyberchef with the recipe : 
   - remove whitespace (uncheck space) 
   - Find/Replace (Find : '[Char]' Replace : '') 
   - Find/Replace (Find : '+ ' Replace : '') 
   - From Decimal
10. The flag is at the end of the script
