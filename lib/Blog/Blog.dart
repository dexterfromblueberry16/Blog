import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';

import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:blogapp/like_button.dart';
import 'package:flutter/material.dart';

// class Blog extends StatelessWidget {
//   Blog({Key key, this.addBlogModel, this.networkHandler}) : super(key: key);

// }

class Blog extends StatefulWidget {
  const Blog({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  var g = Random();

  var r = 1;

  int likeCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    r = g.nextInt(11) + 1;
    // likedOrNot();
  }

  @override
  void dispose() {
    super.dispose();

    print("Disposed");
  }

  // Future<void> updateLikes(int status) async {
  // print("that");
  // var response;
  // if (status == 0) {
  //   // Map<String, String> data = {"like": ""};
  //   response = await widget.networkHandler
  //       .postLikes("/blogPost/update/likes/${widget.addBlogModel.id}");
  // } else if (status == 1) {
  //   // Map<String, String> data = {"like": ""};

  //   response = await widget.networkHandler.deleteLikes(
  //       "/blogPost/update/deleteLikes/${widget.addBlogModel.id}");
  // }
  // print("response new");
  // print("response new ${json.decode(response.body)}");
  // response = await json.decode(response.body);
  // response = await widget.networkHandler
  //     .getLikes("/blogPost/get/likes/${widget.addBlogModel.id}");
  // buff = AddBlogModel.fromJson(response);
  // print(buff.like.toString() + "Reached");
  // like = buff.like;
  // setState(() {
  // if (buff.share == 0) {
  //   likes = Icons.thumb_up_outlined;
  // } else if (buff.share == 1) {
  //   likes = Icons.thumb_up;
  // }
  // });
  // }

  // IconData likedOrNot() {
  //   if (widget.addBlogModel.share == 0) {
  //     likes = Icons.thumb_up_outlined;
  //   } else if (widget.addBlogModel.share == 1) {
  //     likes = Icons.thumb_up;
  //   }
  // }

  // String getLikes() {}

  // IconData likes = likedOrNot;

  // Uint8List bytes = Uint8List.fromList(widget.addBlogModel.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 365,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                            Uint8List.fromList(widget.addBlogModel.image)),
                        // image: AssetImage("assets/Blog${r}.jpg"),
                        // image: networkHandler.getImage(addBlogModel.id),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: Text(
                      widget.addBlogModel.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        // Icon(
                        //   Icons.chat_bubble,
                        //   size: 18,
                        // ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        // Text(
                        //   addBlogModel.comment.toString(),
                        //   style: TextStyle(fontSize: 15),
                        // ),
                        // SizedBox(
                        //   width: 15,
                        // ),
                        // Icon(
                        //   Icons.thumb_up,
                        //   size: 18,
                        // ),
                        Like(
                          addBlogModel: widget.addBlogModel,
                          networkHandler: widget.networkHandler,
                        ),
                        // SizedBox(
                        //   width: 15,
                        // ),
                        // Icon(
                        //   Icons.share,
                        //   size: 18,
                        // ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                        // Text(
                        //   addBlogModel.share.toString(),
                        //   style: TextStyle(fontSize: 15),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Text(widget.addBlogModel.body),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
