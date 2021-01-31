// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_issues.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubIssue _$GithubIssueFromJson(Map<String, dynamic> json) {
  return GithubIssue(
    id: json['id'] as int,
    url: json['url'] as String,
    number: json['number'] as int,
    state: json['state'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    body: json['body'] as String,
    dateCreated: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    dateClosed: json['closed_at'] == null
        ? null
        : DateTime.parse(json['closed_at'] as String),
    author: json['user'] == null
        ? null
        : GithubUser.fromJson(json['user'] as Map<String, dynamic>),
    httpUrl: json['html_url'] as String,
  );
}

Map<String, dynamic> _$GithubIssueToJson(GithubIssue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'number': instance.number,
      'state': instance.state,
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'dateClosed': instance.dateClosed?.toIso8601String(),
      'author': instance.author,
      'httpUrl': instance.httpUrl,
    };

GithubUser _$GithubUserFromJson(Map<String, dynamic> json) {
  return GithubUser(
    login: json['login'] as String,
    id: json['id'] as int,
    avatarUrl: json['avatar_url'] as String,
    url: json['url'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$GithubUserToJson(GithubUser instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatarUrl': instance.avatarUrl,
      'url': instance.url,
      'type': instance.type,
    };
