Docker Setup
---

## Requisites

- docker
- docker-compose

## Verify

Verify development network

```bash
# Check if not exist
docker network ls | grep development
# Create network
docker network create --driver=bridge --subnet=172.20.0.0/16 --gateway=172.20.0.1 development
```

### Allow access from another networks segment to containers development network

```bash
# Connect another network in each container and use name over ip
docker network connect <network-name> db
docker network connect <network-name> cache
```

### Deploy

Deploy Apache Server with PHP 7.3 (apache73)

```bash
docker-compose up -d
```

### SSL Certificate in Windows

See: (https://curl.haxx.se/docs/sslcerts.html)[https://curl.haxx.se/docs/sslcerts.html]

0. Add in: C:C:\Windows\System32\drivers\etc\hosts

```
127.0.0.1       analitica.local
::1             analitica.local
```

1. Download certificate package from: https://curl.haxx.se/docs/caextract.html (save as: `curl-ca-bundle.crt`)

2. Run in cmd (or sh with Git) command:

```bash
openssl s_client -showcerts -servername server -connect analitica.local:443 > analitica.local.pem
```

3. Concat `analitica.local.pem` chain certificates in `curl-ca-bundle.crt` file.

4. Move file curl-ca-bundle.crt concatenated to:

```bash
C:/Windows/System32/curl-ca-bundle.crt
```

5. Run in cmd to test (a URL valid), for example:

```bash
curl -I https://analitica.local
```

It must be return: 302 | 200 HTTP Code

## PenTesting

See [Kali](https://www.kali.org/news/official-kali-linux-docker-images/) installation from Docker :D

and

See [SQLMap](https://www.ma-no.org/en/security/sqlmap-installation-and-usage-in-ubuntu-and-kali-linux) :P


```bash
python sqlmap.py -h
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms --banner
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms --users
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms --users --passwords
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms --dbs
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms -D db --tables
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms -D db -T table --columns
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --forms -D db -T table -C column1,column2 --dump
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --level 5
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --risk 3
python sqlmap.py -u MY_APP_URL --batch --dbms=mysql --technique

python sqlmap.py -u "MY_APP_URL?PARAM1=1&PARAM2=2" -o --batch --dbms=mysql --forms --keep-alive --threads=3 -v 3 --method=POST
```

Get command `sqlmap` in javascript (for MySQL and POST method):

```javascript
var data = '';
document.querySelectorAll('input').forEach(function (input, index) {
  data = data + (index === 0 ? '' : '&') + input.name + '=' + input.value;
});
console.log('python sqlmap.py -o --batch --dbms=mysql --forms --keep-alive --threads=3 --method=POST --url="' + window.location.href + '" --cookie="' + document.cookie + '" --data="' + data + '" > SQLMap' +  window.location.pathname.replace(/\//g, '_') + '.log');
console.log('cat SQLMap' +  window.location.pathname.replace(/\//g, '_') + '.log | egrep "(.*) is vulnerable"');
```