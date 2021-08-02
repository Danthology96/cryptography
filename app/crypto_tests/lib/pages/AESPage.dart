import 'package:crypto_tests/utils/aesEncryption.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class AESPage extends StatefulWidget {
  const AESPage({
    Key? key,
  }) : super(key: key);

  @override
  _AESPageState createState() => _AESPageState();
}

class _AESPageState extends State<AESPage> {
  /// variables
  TextEditingController tecEncrypter = TextEditingController();
  TextEditingController tecDecrypter = TextEditingController();
  var encryptedTextAES, plainTextToEncrypt, plainTextToDecrypt, decryptedText;

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(20), children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Encriptador: ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
          TextField(
            controller: tecEncrypter,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        plainTextToEncrypt = tecEncrypter.text;
                        setState(() {
                          encryptedTextAES =
                              AesEncryption.encryptAES(plainTextToEncrypt);
                        });
                      },
                      child: Text("Encriptar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          decryptedText =
                              AesEncryption.decryptAES(encryptedTextAES);
                        });
                      },
                      child: Text("Desencriptar"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: "Resultado Encriptado: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      children: [
                        TextSpan(
                          text: (encryptedTextAES == null)
                              ? ""
                              : encryptedTextAES is encrypt.Encrypted
                                  ? encryptedTextAES.base64
                                  : encryptedTextAES,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        )
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    text: "Resultado Desencriptado: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    children: [
                      TextSpan(
                        text: decryptedText,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      )
                    ]),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
