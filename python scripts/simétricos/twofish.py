from twofish import Twofish
T = Twofish(b'*secreta*')
x = T.encrypt(b'DESEGURONOLASABES')
print(T.decrypt(x).decode())
