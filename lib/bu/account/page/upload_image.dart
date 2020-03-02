import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/engine/http_manager.dart';
import 'package:gank_flutter/util/toast_util.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UploadImage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      HttpManager.upload(image,true,(res){
        ToastUtil.show("上传成功："+res["form"]["name"].toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

}