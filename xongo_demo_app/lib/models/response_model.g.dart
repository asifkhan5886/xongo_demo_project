// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
    quote: json['quote'] == null
        ? null
        : Quote.fromJson(json['quote'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'quote': instance.quote,
    };

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return Quote(
    id: json['id'] as int,
    dialogue: json['dialogue'] as bool,
    private: json['private'] as bool,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    url: json['url'] as String,
    favoritesCount: json['favoritesCount'] as int,
    upvotesCount: json['upvotesCount'] as int,
    downvotesCount: json['downvotesCount'] as int,
    author: json['author'] as String,
    authorPermalink: json['authorPermalink'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'id': instance.id,
      'dialogue': instance.dialogue,
      'private': instance.private,
      'tags': instance.tags,
      'url': instance.url,
      'favoritesCount': instance.favoritesCount,
      'upvotesCount': instance.upvotesCount,
      'downvotesCount': instance.downvotesCount,
      'author': instance.author,
      'authorPermalink': instance.authorPermalink,
      'body': instance.body,
    };
