import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Photo extends StatefulWidget {

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  File _image;
  final picker = ImagePicker();


  // method to import image from gallery
  Future _getImageGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);;
    });
  }

  // method to import image with camera
  Future _getImageCamera() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);;
    });
  }


  // alert for choice between camera and gallery
  Future showAlertDialog() {
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: Text('Where to retrieve your image?'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: const Icon(FontAwesomeIcons.image),
                  ),
                  const Text('Gallery'),
                ],
              ),
                onPressed: (){
                  _getImageGallery();
                  Navigator.pop(context);
                }
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: const Icon(FontAwesomeIcons.camera),
                  ),
                  const Text('Camera'),
                ],
              ),
              onPressed: (){
                _getImageCamera();
                Navigator.pop(context);
              }
            ),
          ],
        );
      },
    );
  }


  // card container for selected image
  Widget imageCard(File localImage) {
      return Container(
      width: 240.0,
      child: GestureDetector(
        onTap: showAlertDialog,
        child: Container(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Container(
              child: localImage == null
                  ? Icon(FontAwesomeIcons.image)
                  : Image.file(localImage, fit: BoxFit.cover,),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return imageCard(_image);
  }
}