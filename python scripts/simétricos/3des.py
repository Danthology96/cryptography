
from Cryptodome.Cipher import DES3
from Crypto.Random import get_random_bytes

while True:
    try:
        key = DES3.adjust_key_parity(get_random_bytes(24))
        break
    except ValueError:
        pass

# Se crea un objeto de cifrado DE DES
cipher1 = DES3.new(key, DES3.MODE_CFB)

# Datos necesarios
data = b'Estoy codificando esta frase'
#    
msg = cipher1.iv+cipher1.encrypt(data)

print(f'mensaje encriptado: {msg}')

# Creó un objeto de descifrado (descifrado cifrado no puede usar la misma clave)
cipher2 = DES3.new(key, DES3.MODE_CFB,)

# Proceso de descifrado
print(f'mensaje desencriptado: {cipher2.decrypt(msg)}')