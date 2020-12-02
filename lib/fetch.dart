import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchData extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  String name;
  String email;
  String imgUrl;

  void fetchData() async {
    var response = await http.get("https://reqres.in/api/users/2");
    if (response.statusCode != 200) {
      print(response.statusCode);
    } else {
      var data = jsonDecode(response.body);
      setState(() {
        name = data['data']['first_name'];
        email = data['data']['email'];
        imgUrl = data['data']['avatar'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch API"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            name == null
                ? FlatButton(
                    color: Colors.greenAccent,
                    onPressed: () {
                      fetchData();
                    },
                    child: Text(
                      "Fetch",
                      textScaleFactor: 1.7,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: NetworkImage(imgUrl), fit: BoxFit.cover),
                        ),
                        child: null,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            textScaleFactor: 1.7,
                          ),
                          Text(email),
                        ],
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
