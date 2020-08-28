import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoPage extends StatefulWidget {
  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  // File _image;
  ///记录每次选择的图片
  List<File> _images = [];
//  List<PickedFile> _images = [];
  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    try {
      var image = await ImagePicker.pickImage(
          source:isTakePhoto ? ImageSource.camera :ImageSource.gallery
      );
      if (image == null) {
        return;
      } else {
        setState(() {
          // _image = image;
          _images.add(image);
        });
      }
    } catch (e) {
      print("模拟器不支持相机！");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('拍照功能'),
        ),
      body: Center(
        child: Container(
          color: Colors.yellow,
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: _generateImages(),
          ),
        ),
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

  /// 封装图片面板
  _generateImages() {
    return _images.map((file){
      return Stack(
        children: <Widget>[
          ClipRRect(
            //圆角效果
            borderRadius: BorderRadius.circular(10),
            child: Image.file(file,width: 120,height: 90,fit:BoxFit.fill),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _images.remove(file);
                });
              },
              child: ClipOval(
                //圆角删除按钮
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.black54),
                  child: Icon(Icons.close,size: 20,color: Colors.white,),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
