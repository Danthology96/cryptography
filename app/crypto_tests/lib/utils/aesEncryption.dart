import 'package:encrypt/encrypt.dart' as encrypt;

class AesEncryption {
  /// clase para AES Encriptar/Descifrar
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encryptedText = encrypter.encrypt(text, iv: iv);

    print("Bytes: ${encryptedText.bytes}");
    print("Base 16: ${encryptedText.base16}");
    print("Base64: ${encryptedText.base64}");
    return encryptedText;
  }

  static decryptAES(text) {
    return encrypter.decrypt(text, iv: iv);
  }
}
