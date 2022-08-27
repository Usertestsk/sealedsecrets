# Using secrets with cert and Docker secrets
First part is to generate site certificate and second part is to configure NGINX to use the certificate and how to use secrets in Docker.

## Generating Certificate:

1. Generate a root CA for your domain:

```bash
 openssl genrsa -out "rootca.key" 4096
```

2. Genrate a Certificate Signing Request (CSR using) the root CA you reated in step 1:

```bash
openssl req \
          -new -key "rootca.key" \
          -out "rootca.csr" -sha256 \
          -subj '/C=US/ST=CA/L=San Francisco/O=UserT/CN=*.usertestsk.com'
```


3. Create an intermediate certificate that can only sign end certificates but not further CAs:

```bash
[root_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
subjectKeyIdentifier=hash
```

4. Sign CSR created in step 2:


```bash
 openssl x509 -req  -days 3650  -in "rootca.csr" \
               -signkey "rootca.key" -sha256 -out "rootca.crt" \
               -extfile "rootca.cnf" -extensions server
```

## Using the secret in Docker


2. Crete secrets in Docker

```bash
 docker secret create site.key site.key
 docker secret create site.crt site.crt
 docker secret create site.conf site.conf
 ```
