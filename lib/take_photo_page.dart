import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoPage extends StatefulWidget {
  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  File _image;
  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(
        source: isTakePhoto ? ImageSource.camera :ImageSource.gallery
    );
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('拍照功能'),
        ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_pickImage,
        tooltip: '选择图片',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  ///底部弹框
  _pickImage() {
    showModalBottomSheet(context: context, builder: (context) => Container(
      height: 160,
      child: Column(
        children: <Widget>[
          _takePhotoItem('拍照',true),
          _takePhotoItem('从相册选择',false),
        ],
      ),
    ));

  }

  _takePhotoItem(String title, bool isTakePhoto) {
    print(isTakePhoto);
      return GestureDetector(
        child: ListTile(
          leading: Icon(
            isTakePhoto ? Icons.camera_alt : Icons.photo_library,
          ),
          title: Text(title),
          onTap: () => getImage(isTakePhoto),
        ),
      );
  }
}
