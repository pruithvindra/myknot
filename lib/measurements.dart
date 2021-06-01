import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Measurementscreen extends StatefulWidget {
  static const routename = 'measurement';

  @override
  _MeasurementscreenState createState() => _MeasurementscreenState();
}

class _MeasurementscreenState extends State<Measurementscreen> {
  String image_url = 'https://firebase-storage-image/imageName.jpeg';
  Map<String, Object> measurementsdata = {};
  Future<void> apicalls() async {
    final url = Uri.parse(
        'https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement');

    final response =
        await http.post(url, body: json.encode({'image url': image_url}));

    final data = jsonDecode(response.body);
    final extracteddata = data['d'] as Map<String, Object>;
    measurementsdata = extracteddata;
    print('the data is $measurementsdata');
    print(measurementsdata.length);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          'Measurements',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: FutureBuilder(
          future: apicalls(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: ListView.builder(
                      itemCount: measurementsdata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                measurementsdata.keys.toList()[index],
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Text(
                                measurementsdata.values.toList()[index],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
