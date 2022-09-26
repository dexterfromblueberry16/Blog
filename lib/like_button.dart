import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';

class Like extends StatefulWidget {
  const Like({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  IconData likes;

  int like = 1;

  AddBlogModel buff;

  int alreadyLiked = 0;

  @override
  void initState() {
    super.initState();
    initializeLikes();
  }

  @override
  void dispose() {
    super.dispose();
    setLikes();
  }

  void setLikes() async {
    if (likes == Icons.thumb_up_outlined && alreadyLiked == 1) {
      var response;
      response = await widget.networkHandler.deleteLikes(
          "/blogPost/update/deleteLikes/${widget.addBlogModel.id}");
      // Map<String, String> data = {"share": "0"};
      // var response3 = await widget.networkHandler.updateLikedOrNot(
      //     "/blogPost/update/likedOrNot/${widget.addBlogModel.id}", data);
    } else if ((likes == Icons.thumb_up) && (alreadyLiked == 0)) {
      var response;
      response = await widget.networkHandler
          .postLikes("/blogPost/update/likes/${widget.addBlogModel.id}");
      // Map<String, String> data = {"share": "1"};
      // var response3 = await widget.networkHandler.updateLikedOrNot(
      //     "/blogPost/update/likedOrNot/${widget.addBlogModel.id}", data);
    }
  }

  void initializeLikes() async {
    var response = await widget.networkHandler
        .getLikes("/blogPost/get/likes/${widget.addBlogModel.id}");
    // var response3 = await widget.networkHandler
    //     .getLikedOrNot("/blogPost/get/likedOrNot/${widget.addBlogModel.id}");
    buff = AddBlogModel.fromJson(response);
    aLiked(buff.share);
    setState(() {
      like = buff.like;
      if (buff.share == 0) {
        likes = Icons.thumb_up_outlined;
      } else if (buff.share == 1) {
        likes = Icons.thumb_up;
      }
    });
  }

  void aLiked(int like) {
    if (like == 1) {
      alreadyLiked = 1;
    } else {
      alreadyLiked = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        IconButton(
          onPressed: () async {
            if (likes == Icons.thumb_up_outlined) {
              likes = Icons.thumb_up;
              like = like + 1;
              setState(() {});

              // await updateLikes(0);
            } else {
              likes = Icons.thumb_up_outlined;
              like = like - 1;
              setState(() {});

              // await updateLikes(1);

              // print(response.body);
            }
            ;
          },
          icon: Icon(likes),
          iconSize: 24,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "${like}",
          style: TextStyle(fontSize: 15),
        ),
      ],
    ));
  }
}
