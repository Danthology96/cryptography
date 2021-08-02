import 'package:crypto_tests/utils/sha256Encryption.dart';
import 'package:flutter/material.dart';

class Sha256Page extends StatefulWidget {
  const Sha256Page({
    Key? key,
  }) : super(key: key);

  @override
  _Sha256PageState createState() => _Sha256PageState();
}

class _Sha256PageState extends State<Sha256Page> {
  /// variables
  final tecEncrypter = TextEditingController();
  var encryptedText, plainTextToEncrypt, decryptedText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tecEncrypter.addListener(_changedText);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tecEncrypter.dispose();
    super.dispose();
  }

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
                          text: encryptedText,
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
        ],
      ),
    ]);
  }

  void _changedText() {
    print(tecEncrypter.text);
    setState(() {
      encryptedText = SHA256Encryption.encryptSHA256(tecEncrypter.text);
    });
  }
}
