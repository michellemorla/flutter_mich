
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_issues.g.dart';

@JsonSerializable(nullable: true)
class GithubIssue {
  int id;
  String url;
  int number;
  String state;
  String title;
  String description;
  String body;
  DateTime dateCreated;
  DateTime dateClosed;
  GithubUser author;
  String httpUrl;

  static const String STATUS_OPEN = "OPEN";
  static const String STATUS_CLOSE = "CLOSED";
  static const String STATUS_ALL = "ALL";

  GithubIssue({
    this.id,
    this.url,
    this.number,
    this.state,
    this.title,
    this.description,
    this.body,
    this.dateCreated,
    this.dateClosed,
    this.author,
    this.httpUrl});

  factory GithubIssue.fromJson(Map<String, dynamic> map) => _$GithubIssueFromJson(map);
  Map<String, dynamic> toJson() => _$GithubIssueToJson(this);

  Color getColorByStatusKey(){
    switch (state.toUpperCase()){
      case STATUS_OPEN:
        return Colors.green;
        break;
      case STATUS_CLOSE:
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

}

@JsonSerializable(nullable: true)
class GithubUser {
  String login;
  int id;
  String avatarUrl;
  String url;
  String type;

  GithubUser({
    this.login,
    this.id,
    this.avatarUrl,
    this.url,
    this.type,
    });

  factory GithubUser.fromJson(Map<String, dynamic> map) => _$GithubUserFromJson(map);
  Map<String, dynamic> toJson() => _$GithubUserToJson(this);
}

