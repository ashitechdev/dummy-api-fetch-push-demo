import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PushData extends StatefulWidget {
  @override
  _PushDataState createState() => _PushDataState();
}

class _PushDataState extends State<PushData> {
  String email;

  String password;

  int StatusCode;

  int id;

  String token;

  void push(String email, String password) async {
    var response = await http.post("https://reqres.in/api/register", body: {
      "email": email.toString(),
      "password": password.toString(),
    });

    if (response.statusCode != 200) {
    } else {
      var data = jsonDecode(response.body);
      setState(() {
        id = data['id'];
        token = data['token'];

        StatusCode = 200;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API PUSH DEMO"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          // checking if status code have some value ??
          // if not then displays Register Widget
          child: StatusCode == null
              ? RegisterWidget()
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 340, horizontal: 10),
                  // checking the value in StatusCode if its 200 i.e. Successful or something else
                  child: StatusCode == 200
                      ? Column(
                          children: [
                            Text("Response Received"),
                            Text(
                              'Status Code ' + StatusCode.toString(),
                              textScaleFactor: 1.8,
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                            Text("id : $id"),
                            Text("token : $token")
                          ],
                        )
                      : Text('Status Code ' + StatusCode.toString(),
                          textScaleFactor: 1.8)),
        ),
      ),
    );
  }

  Widget RegisterWidget() {
    return Container(
      height: 300,
      width: 300,
      padding: EdgeInsets.only(top: 50, bottom: 30, left: 15, right: 15),
      margin: EdgeInsets.symmetric(vertical: 250, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(7)),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "email",
              prefix: Text('   '),
            ),
            onChanged: (value) {
              // storing latest value in email variable
              email = value;
            },
          ),
          TextField(
            decoration:
                InputDecoration(hintText: "password", prefix: Text('   ')),
            obscureText: true,
            onChanged: (value) {
              // storing latest value in password variable
              password = value;
            },
          ),
          Spacer(),
          Text('only works if parameters are right'),
          Spacer(),
          FlatButton(
            onPressed: () {
              //checking if the email or password are not empty
              if (email != null && password.isNotEmpty) {
                push(email, password);
              } else if (email == null && password == null) {
                print("ERROR :- Fields are null !!");
              }
            },
            child: Text(
              "Register",
              textScaleFactor: 1.4,
            ),
            color: Colors.yellow[100],
          )
        ],
      ),
    );
  }
}
