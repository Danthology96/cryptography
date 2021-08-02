from Crypto.Cipher import Blowfish
from struct import pack

bs = Blowfish.block_size
key = b'Una llave cualquiera'
cipher = Blowfish.new(key, Blowfish.MODE_CBC)
plaintext = b'Codificar esto pls '
plen = bs - len(plaintext) % bs
padding = [plen]*plen
padding = pack('b'*plen, *padding)
msg = cipher.iv + cipher.encrypt(plaintext + padding)

print(f"mensaje encriptado: {msg}")
cipher2 = Blowfish.new(key, Blowfish.MODE_CBC)
decryptedText = cipher2.decrypt(msg)
print(f"mensaje desencriptado: {decryptedText}")

