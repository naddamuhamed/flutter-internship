import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageUploads extends StatefulWidget {
  const ImageUploads({Key? key}) : super(key: key) ;

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {

// no need of the file extension, the name will do fine.
  bool ActiveConnection = false;
  String T = "";
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {                                                                                                     
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';
// ref(destination)
    try {                  
      final rf = FirebaseStorage.instance
          .ref()                            
          .child(fileName);
      await rf.putFile(_photo!);

      UploadTask uploadTask = rf.putFile(_photo!);

      var dowurl = await (await uploadTask).ref.getDownloadURL();
      String dsf = dowurl.toString();
      print("5454545454545454545454545454545454"+rf.getDownloadURL().toString());
      print("============================"+dsf);

    } catch (e) {
      print('error occured');
    }
  }

  @override
  void initState() {
    CheckUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     // String url="https://firebasestorage.googleapis.com/v0/b/hoba-7e83d.appspot.com/o/cee95fd2-2cc4-46ba-8dba-d63fb258cfd46626787236936380176.jpg?alt=media&token=47d6b54c-e3fa-4ce9-84fb-d0b32eda0132";
    CheckUserConnection();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:
        <Widget>[
          const SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xffFDCF09),
                child: _photo != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _photo!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),

          ),
          Conditional.single(

              context: context,
              conditionBuilder: (BuildContext context) => ActiveConnection==true,
              widgetBuilder: (BuildContext context){
                String url="https://firebasestorage.googleapis.com/v0/b/hoba-7e83d.appspot.com/o/fd5483d9-cfe5-4cbc-853e-17d3184378ac3673006523237063226.jpg?alt=media&token=4b3c6404-23b4-4571-b02f-5baa5c037288";

                return Expanded(child:
                Image.network(Uri.parse(url).toString()),
                  // Image.network(url),
                  //   Image.memory(image),
                );
              },
              fallbackBuilder: (BuildContext context){
                return Text("looks like you have no internet connection");
              },
          ),
          // Expanded(child:
          //   Image.network(Uri.parse(url).toString()),
          //   // Image.network(url),
          // //   Image.memory(image),
          // ),

            // Text("null"),

        ],

        // Image.asset('assets/images/shape_of_you.jpg'),
        // Expanded(child: NetworkImage(url),),

      ),


      // NetworkImage(url),
//         final ref = FirebaseStorage.instance.ref().child('testimage');
// // no need of the file extension, the name will do fine.
//     var url = await ref.getDownloadURL();
//     print(url);
    // Once you've the url,


    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }


  getUrl()async{

    final storageRef =  FirebaseStorage.instance.ref().child("o/files/image_picker998828238215846456.jpg");
    final url=await storageRef.getDownloadURL().toString();

    print("---00-"+url.toString());

  }

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
    // return ActiveConnection;
  }

}