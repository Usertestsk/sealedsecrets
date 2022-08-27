# sealedsecrets
Follow these steps:
1. Generate a root CA for your domain:

```bash
 openssl genrsa -out "rootca.key" 4096
```

2. Genrate a CSR using the key you reated in step 1:

```bash
openssl req \
          -new -key "rootca.key" \
          -out "rootca.csr" -sha256 \
          -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA'
```
