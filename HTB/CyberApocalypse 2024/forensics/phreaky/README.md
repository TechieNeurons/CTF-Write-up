## Phreaky

Pcap file, analysing the protocol hierarchy give us an insight, a lot of tcp some mail/http
In extract file we can extract IMF (email file), http object are not interesting, come from ubuntu or google

After extracting all eml we have a zip (in base64) attached to each mail and a password in each mail
I made a simple script to get the base64 (I had to add line feeds in some mail in order to get the base64 with my command)
Extract each zip with the password in the mail, we get a pdf cut in part
`for FILE in *; do xxd -p $FILE; done` : to get all the hex
Copy all hexx in cyberchef, then remove whitepase then from hex then save to pdf file, and FLAG !
