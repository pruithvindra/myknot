import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myknot/measurements.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Homepage.routename,
      routes: {
        Homepage.routename: (ctx) => Homepage(),
        Measurementscreen.routename: (ctx) => Measurementscreen(),
      },
    );
  }
}

class Homepage extends StatefulWidget {
  static const routename = '/';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    String image_url = 'https://firebase-storage-image/imageName.jpeg';
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isloading = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'App Bar',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Center(
          child: Container(
            child: ElevatedButton(
              onPressed: () {},
              child: TextButton(
                onPressed: () async {
                  final url = Uri.https(
                      'myknot-10c11-default-rtdb.firebaseio.com', '/data.json');

                  setState(() {
                    isloading = true;
                  });
                  final response = await http.post(url,
                      body: json.encode({'image url': image_url}));

                  setState(() {
                    isloading = false;
                  });

                  Navigator.pushNamed(context, Measurementscreen.routename);
                },
                child: Container(
                  child: isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'upload picture',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
