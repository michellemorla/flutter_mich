
import 'package:flutter_mich/models/github_issues.dart';
import 'package:flutter_mich/repositories/interfaces/github_issues_repo_interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mich/repositories/api/services.dart' as services;

class GithubIssuesRepository implements IGithubIssuesRepo {
  final Dio _dio;

  GithubIssuesRepository(this._dio);

  @override
  Future<List<GithubIssue>> getIssuesByState(String state) async {
    List<GithubIssue> issues = [];

    String url = services.GET_ALL_ISSUES.replaceAll(services.OWNER_ID, 'flutter').
    replaceAll(services.REPOSITORY_ID, 'flutter');

    _dio.options.headers['accept'] = 'application/vnd.github.v3+json';

    var response = await _dio.get(url, queryParameters: {"per_page":100, "state": state});
    response.data.map((issue){
      issues.add(GithubIssue.fromJson(issue));
    }).toList();

    return issues;
  }
}