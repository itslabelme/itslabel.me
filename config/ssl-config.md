## Configure SSL


You need CSR, private key and a CRT (as of what I have understood). Get them from Godaddy or so.

You must have got 2 .crts 
combine them into one to form a chained crt

```
$ cat 7eb091bbf463b1d0.crt gd_bundle-g2-g1.crt > app.itslabel.me.chained.crt
```

Read More about configuring SSL with nginx:
http://nginx.org/en/docs/http/configuring_https_servers.html#chains


### Verify your SSL Certificate

#### Create a new CSR

```
$ openssl req -new -newkey rsa:2048 -nodes -keyout app.itslabel.me.key -out app.itslabel.me.csr

$ rm app.itslabel.me.crt
$ cat 7eb091bbf463b1d0.crt 7eb091bbf463b1d0.pem > app.itslabel.me.crt
$ cat app.itslabel.me.crt gd_bundle-g2-g1.crt > app.itslabel.me.chained.crt

```

#### Joining (Chaining) the keys

```
$ openssl x509 -noout -text -in app.itslabel.me.chained.crt
$ openssl rsa -noout -text -in app.itslabel.me.key
$ openssl rsa -in app.itslabel.me.key

# If its in der format
$ openssl rsa -in app.itslabel.me.key -inform DER -modulus -noout
```

Now move it to /etc/nginx/ssl and then check it there

```
$ openssl x509 -noout -text -in /etc/nginx/ssl/app.itslabel.me.chained.crt
$ openssl rsa -noout -text -in /etc/nginx/ssl/app.itslabel.me.key
$ openssl rsa -in /etc/nginx/ssl/app.itslabel.me.key -inform DER -modulus -noout
```

There could be an issue if your .key file is in BOM format. 
You might get the below error when you try above command on .key file

```
unable to load Private Key
139924757534360:error:0906D06C:PEM routines:PEM_read_bio:no start line:pem_lib.c:701:Expecting: ANY PRIVATE KEY
```

Check if the file is in BOM format using file command.
```
$ file /etc/nginx/ssl/app.itslabel.me.key
PEM RSA private key
```
if it is showing bom you need to format it after removing bom
```
$ file /etc/nginx/ssl/app.itslabel.me.key
UTF-8 Unicode (with BOM) text
```

Just open it in vi mode
and before saving
try :set nobomb

http://vim.1045645.n5.nabble.com/How-to-display-and-remove-BOM-in-utf-8-encoded-file-td4681708.html