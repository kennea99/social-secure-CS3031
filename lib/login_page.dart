import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'home_page.dart';
import 'user.dart';
import 'firebase_stuff.dart';
import "admin_add.dart";

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
    new _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  //Future to hold our KeyPair
  Future<crypto.AsymmetricKeyPair> futureKeyPair;

//to store the KeyPair once we get data from our future
  crypto.AsymmetricKeyPair keyPair;
  Reqs req = new Reqs();

  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>> getKeyPair()
  {
    var helper = RsaKeyHelper();
    return helper.computeRSAKeyPair(helper.getSecureRandom());
  }
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Social Secure Login",
            style: TextStyle(color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width *.2),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  controller: textEditingController

                ),
              ),
            ),
          ),
          RaisedButton(
            child: Text(
              "sign in"
            ),
            onPressed: () {
              login(textEditingController.text);
            },
          ),
        ],
      ),
    );
  }
  login(String id) async {
    User user = await req.userCheck(id);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder:(context) => HomePage(users: user,)
      ),
    );
    textEditingController.clear();
  }


}