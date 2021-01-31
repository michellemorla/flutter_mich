
import 'package:flutter_mich/models/github_issues.dart';

abstract class IGithubIssuesRepo {

  Future<List<GithubIssue>> getIssuesByState(String state);

}