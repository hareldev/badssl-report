# BadSSL.com Certificate Report :lock:

## Motivation
[BadSSL](https://badssl.com/) contains many addresses with unique certificates, to test your system / browser, and make sure some of the weak certificates will be blocked.

When performing hardening on your system ([Crypto policy](https://github.com/RedHatDemos/SecurityDemos/blob/master/2020Labs/RHELSecurity/documentation/lab11_cryptopolicies.adoc), for example), it can be useful to make sure it's successfully applied.

## Usage
Running this command in Linux Terminal / WSL is simple, no parameters are required, and it will only used built-in executables - `jq`, `curl`.
```
$ ./badssl-report.sh 
type                  status-code  result
expired               000          BAD
wrong.host            000          BAD
self-signed           000          BAD
untrusted-root        000          BAD
revoked               000          BAD
pinning-test          200          GOOD
no-common-name        000          BAD
no-subject            000          BAD
badssl.com            200          GOOD
sha1-intermediate     000          BAD
mixed-content         000          BAD
superfish             000          BAD
edellroot             000          BAD
dsdtestprovider       000          BAD
cbc                   200          GOOD
rc4                   000          BAD
des3                  000          BAD
null                  000          BAD
export                000          BAD
dh480                 000          BAD
dh512                 000          BAD
dh1024                000          BAD
null                  000          BAD
invalid-sni           000          BAD
client-renegotiation  000          BAD
tls-v1-2              200          GOOD
tls-v1-1              000          BAD
tls-v1                000          BAD
```

### Notes:
  * This repository can be cloned before usage, but the script can also run independanlty, and will download the [json file](https://github.com/hareldev/badssl-report/blob/main/badssl-endpoints.json).