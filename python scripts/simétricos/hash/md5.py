# -。- encoding = utf-8 -.-
import hashlib

data = 'Este texto voy a desencriptar para que no hayan espías'

text = hashlib.md5()

text.update(data.encode())

print('MD5 Datos antes del cifrado:', data)
print('MD5 Datos encriptados:', text.hexdigest())
print('MD5 Longitud encriptada:', len(text.hexdigest()))