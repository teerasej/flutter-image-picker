import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

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
  bool _isMovie = false;
  File _file;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  Widget showImage() {
    if (_file == null) {
      return Text('No image selected.');
    } else if (!_isMovie) {
      return Image.file(
        _file,
        width: 250.0,
      );
    } else {
      _videoPlayerController = VideoPlayerController.file(_file);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16/9,
        allowFullScreen: true
      );

      return Chewie(controller: _chewieController,);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
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
                    var file =
                        await ImagePicker.pickImage(source: ImageSource.camera);

                    print(file.path);

                    setState(() {
                      _isMovie = false;
                      _file = file;
                    });
                  },
                ),
                RaisedButton(
                  child: Text('ถ่ายวิดีโอ'),
                  onPressed: () async {
                    var file =
                        await ImagePicker.pickVideo(source: ImageSource.camera);

                    print(file.path);

                    setState(() {
                      _isMovie = true;
                      _file = file;
                    });
                  },
                ),
                RaisedButton(
                  child: Text('เลือกรูปภาพ'),
                  onPressed: () async {
                    var file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);

                    print(file.path);

                    setState(() {
                      _file = file;
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
