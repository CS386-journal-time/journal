import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Photo extends StatefulWidget {

  File localImage;

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {

  final picker = ImagePicker();

  // method to import image from gallery
  Future _getImageGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
     widget.localImage = File(pickedFile.path);
    });
  }

  // method to import image with camera
  Future _getImageCamera() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      widget.localImage = File(pickedFile.path);
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

  // card container for selected image from image picker
  Widget imageCard() {
      return Container(
      height: 200.0,
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
              child: widget.localImage == null
                  ? Icon(FontAwesomeIcons.image)
                  : Image.file(widget.localImage, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  // build return the card with the selected image
  @override
  Widget build(BuildContext context) {
    return imageCard();
  }
}