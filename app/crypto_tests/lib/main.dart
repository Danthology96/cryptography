import 'package:flutter/material.dart';

import 'package:crypto_tests/pages/AESPage.dart';
import 'package:crypto_tests/pages/RSAPage.dart';
import 'package:crypto_tests/pages/SHA256Page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Cryptografía en Flutter'),
            bottom: TabBar(
              tabs: [Text("AES"), Text("SHA-256"), Text("RSA")],
            ),
          ),
          body: TabBarView(children: [
            AESPage(),
            Sha256Page(),
            RSAPage(title: "RSA Encryption"),
          ]),
        ),
      ),
    );
  }
}
