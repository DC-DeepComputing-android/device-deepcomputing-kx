
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048  -outform PEM -out kx_private.pem

avbtool extract_public_key --key  kx_private.pem --output kx_public.bin


