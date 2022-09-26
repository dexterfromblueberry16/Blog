import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'addBlogModels.g.dart';

@JsonSerializable()
class AddBlogModel {
  String coverImage;
  int count;
  List<int> image;
  int share;
  int comment;
  int like;
  @JsonKey(name: "_id")
  String id;
  String username;
  String title;
  String body;

  AddBlogModel(
      {this.coverImage,
      this.count,
      this.image,
      this.share,
      this.comment,
      this.like,
      this.id,
      this.username,
      this.body,
      this.title});
  factory AddBlogModel.fromJson(Map<String, dynamic> json) =>
      _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
