import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable()
class DataModel {
  Quote quote;

  DataModel({this.quote});

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

class TagModel {
  int id;
  String tag;

  TagModel({this.id, this.tag});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "tag": tag,
    };
  }
}

@JsonSerializable()
class Quote {
  int id;
  bool dialogue;
  bool private;
  List<String> tags;
  String url;
  int favoritesCount;
  int upvotesCount;
  int downvotesCount;
  String author;
  String authorPermalink;
  String body;

  Quote(
      {this.id,
      this.dialogue,
      this.private,
      this.tags,
      this.url,
      this.favoritesCount,
      this.upvotesCount,
      this.downvotesCount,
      this.author,
      this.authorPermalink,
      this.body});

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
