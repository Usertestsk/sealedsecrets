# Using secrets with NGINX
First part is to generate site certificate and second part is to configure NGINX to use the certificate and how to use secrets in Docker.

## Generating Certificate:

1. Generate a root CA for your domain:

```bash
 openssl genrsa -out "rootca.key" 4096
```

2. Genrate a CSR using the key you reated in step 1:

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


## Using the secret in Docker
