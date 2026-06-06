## Data siege

Extract HTTP object to get a .net exe, in windows reverse the encrypt/decrypt function :
```
encryptKey = VYAemVeO3zUDTL6N62kVA

Rfc2898DeriveBytes rfc2898DeriveBytes = new Rfc2898DeriveBytes(encryptKey, new byte[]
86, 101, 114, 121, 95, 83, 51, 99, 114, 51, 116, 95, 83 == Very_S3cr3t_S
```

In wireshark we can see multiple TCP with a LEN > 0 (filter on them), 
To get the base64 : 
- copy paste all hex+ascii in a file
- delete all line not aligned and delete the space at the beginning of the ascii
- cat all_packets_data.txt| cut -d" " -f22 > cleaned
- need to clean more then when only the base 64 go on windows

Now decrypt : On windows copy the decrypt function to a new project on VSCode :

```
using System.Security.Cryptography;
using System.Text;

string text;

string cipherText = "1BhuY4/niTopIBHAN6vvmQ==";
try
{

    string encryptKey = "VYAemVeO3zUDTL6N62kVA";
    byte[] array = Convert.FromBase64String(cipherText);
    using (Aes aes = Aes.Create())
    {
        Rfc2898DeriveBytes rfc2898DeriveBytes = new Rfc2898DeriveBytes(encryptKey, new byte[]
        {
                86, 101, 114, 121, 95, 83, 51, 99, 114, 51,
                116, 95, 83
        });
        aes.Key = rfc2898DeriveBytes.GetBytes(32);
        aes.IV = rfc2898DeriveBytes.GetBytes(16);
        using (MemoryStream memoryStream = new MemoryStream())
        {
            using (CryptoStream cryptoStream = new CryptoStream(memoryStream, aes.CreateDecryptor(), CryptoStreamMode.Write))
            {
                cryptoStream.Write(array, 0, array.Length);
                cryptoStream.Close();
            }
            cipherText = Encoding.Default.GetString(memoryStream.ToArray());
        }
    }
    text = cipherText;
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
    Console.WriteLine("Cipher Text: " + cipherText);
    text = "error";
}
Console.WriteLine(text);
```

In the decrypted data :
HTB{c0mmun1c4710n5_h45_b33n_r3570r3d_1n_7h3_h34dqu4r73r5}
