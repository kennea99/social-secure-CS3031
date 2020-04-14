import "package:flutter/material.dart";
import "package:firebase_database/firebase_database.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import 'package:socialsecure/user.dart';

class Reqs {
  DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  Future<http.Response> fetchallUsers(String id) {
    return http.get (
    'https://social-app-d128a.firebaseio.com/members.json'
    );
  }

   Future<User>userCheck(String id) async {
    http.Response res = await fetchallUsers(id);
    bool isMem = false;
    bool isAdmin = false;
    print(res.body);
    Map<String, dynamic> map = jsonDecode((res.body));
    map.forEach((key, value)
    {
      if( key.toLowerCase() == id.toLowerCase() && value['member'] == true) {
        isMem = true;
        if (value["administrator"] == true) {
          isAdmin = true;
        }
      }
    });
    print(isMem);
    return new User(id:id, isMem: isMem, isAdmin : isAdmin);
  }

  Future<bool>checkUser(String id) async {
    http.Response res = await fetchallUsers(id);
    bool isMem = false;
    bool isAdmin = false;
    print(res.body);
    Map<String, dynamic> map = jsonDecode((res.body));
    map.forEach((key, value)
    {
      if( key.toLowerCase() == id.toLowerCase() && value['member'] == true) {
        isMem = true;
      }

    });
    return isMem;

  }


  memAdd(String id, bool isAdmin) {
    databaseRef.child("/members/" + "/" + id + "/").set({
      "administrator" : isAdmin,
      "member" : true,
    });
  }

  memRemove(String id, bool isAdmin) {
    databaseRef.child("/members/" + "/" + id +"/").update({
      "administrator" : false,
      "member" : false,
    });
  }
}