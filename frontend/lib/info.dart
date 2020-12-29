import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Map data = {};
  bool uploaded = false;
  String message = "";

  var url = 'http://localhost:8000/api';

  void _uploadImage(File file) async {
    if (uploaded) return;
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    var res = await dio.post('$url/image', data: data);
    final response = json.decode(res.toString());
    print("${response['msg']} uploaded");
    setState(() {
      uploaded = true;
      message = 'uploaded';
    });
  }

  @override
  void initState() {
    // _uploadImage(data['image']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    _uploadImage(data['image']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ways to Recycle.'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: 400,
        height: 400,
        // child: Image.file(data['image']),
        child: uploaded
            ? Text('$message')
            : SpinKitCircle(
                color: Colors.green,
                size: 100,
              ),
      ),
    );
  }
}
