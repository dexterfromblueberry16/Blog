// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addBlogModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBlogModel _$AddBlogModelFromJson(Map<String, dynamic> json) {
  // final buffer = json['coverImage']["data"]["data"];
  print(json.toString());
  // List<int> buffer = json;
  return AddBlogModel(
    coverImage: json['coverImage'] as String,
    count: json['count'] as int,
    share: json['share'] as int,
    image: json['Image']['data']['data'].cast<int>() as List<int>,
    comment: json['comment'] as int,
    like: json['like'] as int,
    id: json['_id'] as String,
    username: json['username'] as String,
    body: json['body'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$AddBlogModelToJson(AddBlogModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      'count': instance.count,
      'share': instance.share,
      'Image': instance.image,
      'comment': instance.comment,
      'like': instance.like,
      '_id': instance.id,
      'username': instance.username,
      'title': instance.title,
      'body': instance.body,
    };
