import 'package:blogapp/Blog/Blog.dart';
import 'package:blogapp/Blog/editBlog.dart';
import 'package:blogapp/CustumWidget/BlogCard.dart';
import 'package:blogapp/Model/SuperModel.dart';
import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:blogapp/Pages/HomePage.dart';
import 'package:blogapp/Profile/MainProfile.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  Blogs({Key key, this.url, this.page}) : super(key: key);
  final String url;
  final int page;

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => Blog(
                                              addBlogModel: item,
                                              networkHandler: networkHandler,
                                            )));
                              },
                              child: BlogCard(
                                addBlogModel: item,
                                networkHandler: networkHandler,
                              ),
                            ),
                            (widget.page == 1)
                                ? Positioned(
                                    child: IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Color.fromARGB(255, 35, 120, 190),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => editBlog(
                                                    addBlogModel: item,
                                                    networkHandler:
                                                        networkHandler,
                                                  )),
                                        );
                                      },
                                    ),
                                    left: 30,
                                    bottom: 19,
                                  )
                                : SizedBox(),
                            (widget.page == 1)
                                ? Positioned(
                                    child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'Please Confirm'),
                                                content: const Text(
                                                    'Are you sure to delete the Blog?'),
                                                actions: [
                                                  // The "Yes" button
                                                  TextButton(
                                                      onPressed: () async {
                                                        // Remove the box
                                                        setState(() {
                                                          isLoading = true;
                                                        });

                                                        AddBlogModel
                                                            addBlogModel =
                                                            AddBlogModel(
                                                                username: item
                                                                    .username);

                                                        var response =
                                                            await networkHandler
                                                                .delete(
                                                                    "/blogPost/delete/${item.id}",
                                                                    addBlogModel
                                                                        .toJson());
                                                        if (response
                                                                .statusCode ==
                                                            200) {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          HomePage()));
                                                          // Navigator.pop(
                                                          //     context);
                                                        }

                                                        // Close the dialog
                                                        // Navigator.pop(
                                                        //     context);
                                                      },
                                                      child: const Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        // Close the dialog
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('No'))
                                                ],
                                              )),
                                      color: Color.fromARGB(255, 214, 52, 41),
                                    ),
                                    right: 30,
                                    bottom: 19,
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any Blog Yet"),
          );
  }
}
