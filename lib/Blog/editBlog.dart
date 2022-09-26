import 'dart:convert';

import 'package:blogapp/Pages/HomePage.dart';
import 'package:blogapp/Profile/MainProfile.dart';
import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:image_picker/image_picker.dart';

class editBlog extends StatefulWidget {
  const editBlog({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  State<editBlog> createState() => _editBlogState();
}

class _editBlogState extends State<editBlog> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.image;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _title.text = widget.addBlogModel.title;
    _body.text = widget.addBlogModel.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        // actions: <Widget>[
        //   ElevatedButton(
        //     onPressed: () {
        //       if (_globalkey.currentState.validate()) {
        //         showModalBottomSheet(
        //           context: context,
        //           builder: ((builder) => OverlayCard(
        //                 imagefile: _imageFile,
        //                 title: _title.text,
        //               )),
        //         );
        //       }
        //     },
        //     child: Text(
        //       "Preview",
        //       style: TextStyle(fontSize: 18, color: Colors.blue),
        //     ),
        //   )
        // ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            bodyTextField(),
            SizedBox(
              height: 30,
            ),
            addButton(),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _title,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be <=100";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Edit Title ",
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Colors.teal,
            ),
            onPressed: takeCoverPhoto,
          ),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _body,
        validator: (value) {
          if (value.isEmpty) {
            return "Body can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Edit The Body",
        ),
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : InkWell(
            onTap: () async {
              if (_globalkey.currentState.validate()) {
                String id = widget.addBlogModel.id;
                AddBlogModel addBlogModel1 =
                    AddBlogModel(body: _body.text, title: _title.text);
                var response = await widget.networkHandler
                    .patchBlog("/blogpost/update/$id", addBlogModel1.toJson());
                print(response.body);

                setState(() {
                  isLoading = true;
                });

                if ((response.statusCode == 200 ||
                        response.statusCode == 201) &&
                    _imageFile != null) {
                  var imageResponse = await widget.networkHandler.patchImage(
                      "/blogpost/add/coverImage/$id", _imageFile.path);
                  print(imageResponse.statusCode);
                  if (imageResponse.statusCode == 200 ||
                      imageResponse.statusCode == 201) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  }
                }
                if (response.statusCode == 200 || response.statusCode == 201) {
                  setState(() {
                    isLoading = false;
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  // );

                  // Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              }
            },
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal),
                child: Center(
                    child: Text(
                  "Edit Blog",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }
}
