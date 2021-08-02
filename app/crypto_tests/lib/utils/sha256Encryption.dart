import 'dart:convert';

import 'package:crypto/crypto.dart';

class SHA256Encryption {
  static encryptSHA256(text) {
    var bytes = utf8.encode(text); // data being hashed

    var digest = sha256.convert(bytes);

    print("bytes: ${digest.bytes}");
    print("hex: $digest");
    return digest.toString();
  }
}
