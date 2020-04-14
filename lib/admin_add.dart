import "package:flutter/material.dart";
import "firebase_stuff.dart";

class PageAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
    new _PageAdminState();
}

class _PageAdminState extends State<PageAdmin> {
  Reqs req = new Reqs();
  TextEditingController _textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Administrator Page"
          ),
          backgroundColor: Colors.green
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center
        ,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton (
                onPressed: () {
                  addToGroup();
                },
                color: Colors.green,
                child: Text(
                  "Add Member to Group"
                ),
              ),
              RaisedButton (
                onPressed: () {
                  removeMember(_textEditingController.text);
                },
                color: Colors.red,
                child:Text(
                  "Remove Member"
                ),
              ),
            ],
          ),
          Column (
            children: <Widget>[
              TextField (
                controller: _textEditingController,
                decoration: InputDecoration (
                  labelText: "Write the name of member to add or remove..."
                ),
              )

            ],
          )
        ],
      )
    );
  }

  addToGroup() {
    String login = _textEditingController.text;
    String id = req.memAdd(login, false);
    showDialog(
        context: context,
        child: AlertDialog (
        title: Text("Member Added"),
        content: Text("Login: " +_textEditingController.text),
        actions: <Widget>[
        FlatButton(
          child:Text('Exit'),
          onPressed: () {
          Navigator.pop(context);
          },
        ),
      ],
    ),
    );
    _textEditingController.clear();
  }

  removeMember(String id) async {
   bool isMember = await req.checkUser(id);
   if(isMember == true)
     {
        req.memRemove(id, true);
        showDialog(
          context: context,
          child: AlertDialog (
            title: Text(_textEditingController.text+ " Has been Removed."),
            actions: <Widget>[
              FlatButton(
                child:Text('Exit'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
        _textEditingController.clear();
     }
   else{
     showDialog(
         context: context,
         child: AlertDialog (
         title: Text("Not a Member of the Group"),
          content: Text("Login: " +_textEditingController.text),
          actions: <Widget>[
           FlatButton(
               child:Text('Exit'),
                onPressed: () {
                 Navigator.pop(context);
           },
         ),
       ],
      ),
     );
     _textEditingController.clear();

   }
  }
}