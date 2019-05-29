import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow Video Recorder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Nextflow Video Recorder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Widget showImage() {
    if (_image == null) {
      return Text('No image selected.');
    } else {
      return Image.file(_image, width: 250.0,); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            showImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  child: Text('ถ่ายภาพ'),
                  onPressed: () async {
                    var file = await ImagePicker.pickImage(source: ImageSource.camera);

                    print(file.path);

                    setState(() {
                      _image = file;
                    });
                  },
                ),
                RaisedButton(
                  child: Text('เลือกรูปภาพ'),
                  onPressed: () async {
                    var file = await ImagePicker.pickImage(source: ImageSource.gallery);

                    print(file.path);

                    setState(() {
                      _image = file;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
