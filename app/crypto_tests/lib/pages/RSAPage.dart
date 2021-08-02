import 'package:crypto_tests/utils/dependency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:pointycastle/asymmetric/api.dart';

TextStyle get whiteTextStyle => TextStyle(color: Colors.white);

class RSAPage extends StatefulWidget {
  RSAPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RSAPageState createState() => _RSAPageState();
}

class _RSAPageState extends State<RSAPage> {
  /// The Future that will show the Pem String
  Future<String>? futureText;

  /// Future to hold the reference to the KeyPair generated with PointyCastle
  /// in order to extract the [crypto.PrivateKey] and [crypto.PublicKey]
  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>?
      futureKeyPair;

  /// The current [crypto.AsymmetricKeyPair]
  crypto.AsymmetricKeyPair? keyPair;

  /// With the helper [RsaKeyHelper] this method generates a
  /// new [crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>
  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
      getKeyPair() {
    var keyHelper = DependencyProvider(
      child: Container(),
    ).getRsaKeyHelper();
    return keyHelper.computeRSAKeyPair(keyHelper.getSecureRandom());
  }

  /// GlobalKey to be used when showing the [Snackbar] for the successful
  /// copy of the Key
  final key = new GlobalKey<ScaffoldState>();

  /// Text Editing Controller to retrieve the text to sign
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MaterialButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  "Generar nuevo Par de claves",
                  style: whiteTextStyle,
                ),
                onPressed: () {
                  setState(() {
                    // If there are any pemString being shown, then show an empty message
                    futureText = Future.value("");
                    // Generate a new keypair
                    futureKeyPair = getKeyPair();
                  });
                },
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder<
                        crypto.AsymmetricKeyPair<crypto.PublicKey,
                            crypto.PrivateKey>>(
                    future: futureKeyPair,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // if we are waiting for a future to be completed, show a progress indicator
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        // Else, store the new keypair in this state and sbow two buttons
                        this.keyPair = snapshot.data!;
                        return Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            MaterialButton(
                              color: Colors.red,
                              child:
                                  Text("Llave Privada", style: whiteTextStyle),
                              onPressed: () {
                                setState(() {
                                  // With the stored keypair, encode the private key to
                                  // PKCS1 and show it
                                  futureText = Future.value(DependencyProvider(
                                    child: Container(),
                                  )
                                      .getRsaKeyHelper()
                                      .encodePrivateKeyToPemPKCS1(keyPair!
                                          .privateKey as RSAPrivateKey));
                                });
                              },
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child:
                                  Text("LLave pública", style: whiteTextStyle),
                              onPressed: () {
                                setState(() {
                                  // With the stored keypair, encode the public key to
                                  // PKCS1 and show it
                                  futureText = Future.value(DependencyProvider(
                                    child: Container(),
                                  ).getRsaKeyHelper().encodePublicKeyToPemPKCS1(
                                      keyPair!.publicKey as RSAPublicKey));
                                });
                              },
                            ),
                            TextField(
                              decoration:
                                  InputDecoration(hintText: "Texto a firmar"),
                              controller: _controller,
                            ),
                            MaterialButton(
                              color: Colors.black87,
                              child:
                                  Text("Firmar Texto", style: whiteTextStyle),
                              onPressed: () {
                                setState(() {
                                  futureText = Future.value(DependencyProvider(
                                    child: Container(),
                                  ).getRsaKeyHelper().sign(_controller.text,
                                      keyPair!.privateKey as RSAPrivateKey));
                                });
                              },
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
              Expanded(
                flex: 2,
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    child: FutureBuilder(
                        future: futureText,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              // the inkwell is used to register the taps
                              // in order to be able to copy the text
                              child: InkWell(
                                  onTap: () {
                                    // Copies the data to the keyboard
                                    Clipboard.setData(new ClipboardData(
                                        text: snapshot.data as String));

                                    key.currentState!.showSnackBar(new SnackBar(
                                      content:
                                          new Text("Copiado al portapapeles"),
                                    ));
                                  },
                                  child: Text(snapshot.data as String)),
                            );
                          } else {
                            return Center(
                              child: Text("Your keys will appear here"),
                            );
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
