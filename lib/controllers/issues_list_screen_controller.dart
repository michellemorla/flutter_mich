
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mich/models/github_issues.dart';
import 'package:flutter_mich/repositories/github_issues_repository.dart';
import 'package:flutter_mich/repositories/interfaces/github_issues_repo_interface.dart';

class IssuesListScreenController extends ChangeNotifier {

  final IGithubIssuesRepo _githubIssuesRepo = GithubIssuesRepository(Dio());
  List<GithubIssue> githubIssues = [];

  getIssuesByState(String state) async {
    githubIssues = await _githubIssuesRepo.getIssuesByState(state);
    notifyListeners();
  }

}