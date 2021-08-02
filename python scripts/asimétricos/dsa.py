from Crypto.PublicKey import DSA
from Crypto.Signature import DSS
from Crypto.Hash import SHA256
# Crea una nueva llave dsa
key = DSA.generate(2048)

# genera un archivo con llave pública en el proyecto.
f = open("public_key.pem", "w")
f.write(key.publickey().export_key())
f.close()

# firma el mensaje
message = b"Hello"
hash_obj = SHA256.new(message)
signer = DSS.new(key, 'fips-186-3')
signature = signer.sign(hash_obj)

# carga la llave pública
f = open("public_key.pem", "r")
hash_obj = SHA256.new(message)
pub_key = DSA.import_key(f.read())
verifier = DSS.new(pub_key, 'fips-186-3')
# Verifica la autenticidad del mensaje 
try:
    verifier.verify(hash_obj, signature)
    print ("El mensaje es auténtico.")
except ValueError:
    print ("El mensaje es auténtico")