import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/api.dart' as crypto;
import "user.dart";
import "admin_add.dart";

class HomePage extends StatefulWidget {
  @override
  User users;
  HomePage({@required this.users});
  State<StatefulWidget> createState() =>
      new _HomePageState(this.users);
  }

  class _HomePageState extends State<HomePage> {
  User users;
  _HomePageState(this.users) {
    print(users.isAdmin);
  }
  TextEditingController _textEditingController = new TextEditingController();
  Future<crypto.AsymmetricKeyPair> futureKeyPair;
  crypto.AsymmetricKeyPair keyPair;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Social Secure"
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.all(MediaQuery.of(context).size.width *.1),
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _textEditingController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    focusColor: Colors.blue,
                    border: OutlineInputBorder(),
                    labelText: "Enter Post Here."
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   RaisedButton(
                      onPressed: () {
                          decryptText(_textEditingController.text);
                      },

                     child: Text(
                       "Decrypt"
                     ),
                   ),
                   RaisedButton(
                      onPressed: () {
                        encryptText(_textEditingController.text);
                      },
                      child: Text(
                        "Share Message"
                      ),
                   ),
                   RaisedButton(
                     onPressed: () {
                       _textEditingController.clear();
                   },
                     color: Colors.red,
                     child: Text(
                       "Clear"
                     ),
                   ),
                 ],
                ),
              ],
            ),
          ),
          users.isAdmin?
          RaisedButton (
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder:(context) => PageAdmin())
              );
            },
            color: Colors.green,
            child: Text(
              "Add User to Group."
            )
          ):Container(),
        ],
      ),
    );
  }

    decryptText(String input) {
      if(users.isMem) {
        String decrypted = decrypt(input, users.keyPair.privateKey);
        _textEditingController.text = decrypted;
      }
      else {
        showDialog(
          context: context,
          child: AlertDialog (
            title: Text("You are not in the group"),
            content: Text("have an admin add you."),
            actions: <Widget>[
              FlatButton(
                child:Text('Exit'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        );
      }
    }

    encryptText(String input) {
      String encrypted = encrypt(input, users.keyPair.publicKey);
      _textEditingController.text = encrypted;
      Share.share(encrypted);
    }


}