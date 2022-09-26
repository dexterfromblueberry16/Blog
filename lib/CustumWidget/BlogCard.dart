import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    var g = Random();
    Uint8List bytes = Uint8List.fromList(addBlogModel.image);
    return Container(
      height: 280,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            Positioned(
              bottom: 60,
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MemoryImage(bytes),
                      // image: AssetImage("assets/Blog${g.nextInt(11) + 1}.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: 19, right: 7, bottom: 7, left: 7),
                height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  addBlogModel.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
