import binascii
from Cryptodome.Cipher import DES


key = b'12345678'	#   (solo 8)
iv = b'12345678'	# Vector de inicialización

# Se crea un objeto de cifrado DE DES
cipher1 = DES.new(key, DES.MODE_CFB, iv)

# Datos necesarios
data = 'Estoy codificando esta frase'.encode()

#    
msg = cipher1.encrypt(data)

print(f'mensaje encriptado: {msg}')

# Creó un objeto de descifrado (descifrado cifrado no puede usar la misma clave)
cipher2 = DES.new(key, DES.MODE_CFB, iv)

# Proceso de descifrado
print(f'mensaje desencriptado: {cipher2.decrypt(msg).decode()}')